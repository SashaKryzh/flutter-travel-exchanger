import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_exchanger/data/rates.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rate.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'rates_repository.g.dart';

@riverpod
RatesRepository ratesRepository(RatesRepositoryRef ref) {
  throw Exception('Rates repository provider should be overridden');
}

class RatesRepository {
  static const _timestampKey = 'ratesTimestamp';
  static const _ratesDataKey = 'ratesData';

  RatesRepository(this._supabase, this._sharedPreferences);

  final SupabaseClient _supabase;
  final SharedPreferences _sharedPreferences;

  final _ratesDataController = StreamController<RatesData>.broadcast();
  Stream<RatesData> get ratesDataStream => _ratesDataController.stream;

  late RatesData _ratesData;
  RatesData get ratesData => _ratesData;
  set _setRatesData(RatesData value) {
    _ratesData = value;
    _ratesDataController.add(value);
  }

  Future<void> initRates() async {
    final stored = await _fetchStoredRates();
    if (stored != null && stored.rates.isNotEmpty) {
      _setRatesData = stored;
    } else {
      _ratesData = RatesData(Currency.eur, []);
      final remoteRates = await _fetchRemoteRates();
      final mergedRates = _mergeWithRemoteRates(remoteRates.rates);
      _setRatesData = RatesData(remoteRates.base, mergedRates);
      _storeRates(_ratesData);
    }

    assert(_ratesData.rates.isNotEmpty, 'Remote base not initialized');
  }

  Future<void> updateRatesIfExpired() async {
    final lastStored = _getStoredTimestamp();

    if (_ratesData.rates.remoteRates.isNotEmpty &&
        lastStored.isAfter(DateTime.now().subtract(const Duration(hours: 1)))) {
      logger.d('Rates are not expired');
      return;
    }

    final remoteRates = await _fetchRemoteRates();
    if (remoteRates.rates.isEmpty) {
      return;
    }

    final mergedRates = _mergeWithRemoteRates(remoteRates.rates);
    _setRatesData = RatesData(remoteRates.base, mergedRates);
    _storeRates(_ratesData);
  }

  Future<void> setCustomRate(Currency from, Currency to, double rate) async {
    final newRate = Rate(
      base: from,
      target: to,
      rate: rate,
      updatedAt: DateTime.now(),
      source: RateSource.custom,
    );

    await removeCustomRateBetween(from, to, notify: false);
    final rates = [..._ratesData.rates];
    rates.add(newRate);

    _setRatesData = _ratesData.copyWith(rates: rates);
    await _storeRates(_ratesData);
  }

  Future<void> removeCustomRateBetween(Currency a, Currency b, {bool notify = true}) async {
    final rates = [..._ratesData.rates];
    rates.removeWhere(
      (e) =>
          e.source == RateSource.custom &&
          (e.base == a && e.target == b || e.base == b && e.target == a),
    );

    if (notify) {
      _setRatesData = _ratesData.copyWith(rates: rates);
    } else {
      _ratesData = _ratesData.copyWith(rates: rates);
    }
    await _storeRates(_ratesData);
  }

  Future<RatesData> _fetchRemoteRates() async {
    logger.d('Fetching rates');

    RatesData ratesData;

    try {
      final response = await _supabase.functions.invoke('rates', method: HttpMethod.get);
      final data = GetRatesResponseDto.fromJson(response.data as Map<String, dynamic>);
      ratesData = RatesData(
        Currency(code: data.base),
        data.rates.map((e) => e.toDomain()).toList(),
      );
    } on FunctionException catch (e) {
      logger.e('FunctionException: ${e.status} ${e.reasonPhrase} ${e.details}');
      ratesData = RatesData(Currency.eur, []);
    }

    if (ratesData.rates.isEmpty) {
      logger.e('Remote rates are empty');
    }

    return ratesData;
  }

  DateTime _getStoredTimestamp() {
    final timestamp = _sharedPreferences.getString(_timestampKey);
    if (timestamp == null) {
      return DateTime(0);
    }

    return DateTime.parse(timestamp);
  }

  Future<RatesData?> _fetchStoredRates() async {
    try {
      final jsonString = _sharedPreferences.getString(_ratesDataKey);
      if (jsonString == null) {
        return null;
      }

      final ratesData = await compute((e) {
        final json = jsonDecode(e) as Map<String, dynamic>;
        return RatesData.fromJson(json);
      }, jsonString);

      return ratesData;
    } catch (e, stackTrace) {
      logger.e('Error fetching stored rates', error: e, stackTrace: stackTrace);
      _clear();
      return null;
    }
  }

  List<Rate> _mergeWithRemoteRates(List<Rate> remoteRates) {
    final customRates = _ratesData.rates.customRates;
    final mergedRates = customRates + remoteRates;
    return mergedRates.toSet().toList();
  }

  Future<void> _storeRates(RatesData ratesData) async {
    logger.d('Storing rates locally');

    final json = ratesData.toJson();
    final ratesDataJsonString = await compute(jsonEncode, json);

    await Future.wait([
      _sharedPreferences.setString(_timestampKey, DateTime.now().toIso8601String()),
      _sharedPreferences.setString(_ratesDataKey, ratesDataJsonString),
    ]);
  }

  Future<void> _clear() async {
    await Future.wait([
      _sharedPreferences.remove(_timestampKey),
      _sharedPreferences.remove(_ratesDataKey),
    ]);
  }
}

extension on List<Rate> {
  List<Rate> get remoteRates => where((e) => e.source == RateSource.api).toList();
  List<Rate> get customRates => where((e) => e.source == RateSource.custom).toList();
}
