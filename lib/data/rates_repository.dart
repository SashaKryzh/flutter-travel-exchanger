import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_exchanger/data/dto/get_rates_response_dto.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rate.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'rates_repository.g.dart';

@riverpod
RatesRepository ratesRepository(RatesRepositoryRef _) {
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

  Future<void> init() async {
    final stored = await _fetchStoredRates();
    if (stored != null && stored.rates.isNotEmpty) {
      _setRatesData = stored;
    } else {
      _setRatesData = await _fetchRemoteRates();
      await _storeRates(_ratesData);
      await _storeRemoteTimestamp();
    }

    assert(_ratesData.rates.isNotEmpty, 'Remote base not initialized');
  }

  Future<void> updateRatesIfExpired() async {
    final lastStored = _getStoredTimestamp();

    if (_ratesData.rates.remoteRates.isNotEmpty &&
        lastStored.isAfter(DateTime.now().subtract(const Duration(hours: 1)))) {
      logDebug('Rates are not expired');
      return;
    }

    final remoteRates = await _fetchRemoteRates();
    if (remoteRates.rates.isEmpty) {
      return;
    }

    final mergedRates = (_ratesData.rates + remoteRates.rates)
        .map(RateEqualityExceptRateWrapper.new)
        .toSet()
        .map((e) => e.rate)
        .toList();
    _setRatesData = RatesData(remoteRates.updatedAt, remoteRates.base, mergedRates);
    await _storeRates(_ratesData);
    await _storeRemoteTimestamp();
  }

  Future<void> setCustomRate(MoneyCurrency from, MoneyCurrency to, double rate) async {
    final newRate = Rate(
      from: from,
      to: to,
      rate: rate,
      source: RateSource.custom,
    );

    await removeCustomRateBetween(from, to, notify: false);
    final rates = [..._ratesData.rates];
    rates.add(newRate);

    _setRatesData = _ratesData.copyWith(rates: rates);
    await _storeRates(_ratesData);
  }

  Future<void> removeCustomRateBetween(
    MoneyCurrency a,
    MoneyCurrency b, {
    bool notify = true,
  }) async {
    final rates = [..._ratesData.rates];
    rates.removeWhere(
      (e) =>
          e.source == RateSource.custom && (e.from == a && e.to == b || e.from == b && e.to == a),
    );

    if (notify) {
      _setRatesData = _ratesData.copyWith(rates: rates);
    } else {
      _ratesData = _ratesData.copyWith(rates: rates);
    }
    await _storeRates(_ratesData);
  }

  Future<RatesDataTimestamps> getTimestamps() async {
    return RatesDataTimestamps(
      updatedAt: _ratesData.updatedAt,
      lastFetchedAt: _getStoredTimestamp(),
    );
  }

  Future<RatesData> _fetchRemoteRates() async {
    logDebug('Fetching rates');

    RatesData ratesData;

    try {
      final response = await _supabase.functions.invoke('rates', method: HttpMethod.get);
      final data = GetRatesResponseDtoMapper.fromMap(response.data as Map<String, dynamic>);
      ratesData = RatesData(
        data.updatedAt,
        MoneyCurrency(data.base),
        data.rates.map((e) => e.toDomain()).toList(),
      );
    } on FunctionException catch (e, stackTrace) {
      logError(
        'FunctionException: ${e.status} ${e.reasonPhrase ?? ''} ${e.details}',
        error: e,
        stackTrace: stackTrace,
      );
      ratesData = RatesData(DateTime.now(), Currency.eur, []);
    } on SocketException catch (e, stackTrace) {
      logError(
        'SocketException: ${e.message}',
        error: e,
        stackTrace: stackTrace,
      );
      ratesData = RatesData(DateTime.now(), Currency.eur, []);
    }

    if (ratesData.rates.isEmpty) {
      logError('Remote rates are empty');
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

      final ratesData = await compute(
        (e) {
          final json = jsonDecode(e) as Map<String, dynamic>;
          return RatesData.fromJson(json);
        },
        jsonString,
      );

      return ratesData;
    } catch (e, stackTrace) {
      logError('Error fetching stored rates', error: e, stackTrace: stackTrace);
      _clear();
      return null;
    }
  }

  Future<void> _storeRates(RatesData ratesData) async {
    logDebug('Storing rates locally');

    final json = ratesData.toJson();
    final ratesDataJsonString = await compute(jsonEncode, json);

    await _sharedPreferences.setString(_ratesDataKey, ratesDataJsonString);
  }

  Future<void> _storeRemoteTimestamp() async {
    await _sharedPreferences.setString(_timestampKey, DateTime.now().toIso8601String());
  }

  Future<void> _clear() async {
    await Future.wait([
      _sharedPreferences.remove(_timestampKey),
      _sharedPreferences.remove(_ratesDataKey),
    ]);
  }
}

extension ListRateX on List<Rate> {
  List<Rate> get remoteRates => where((e) => e.source == RateSource.api).toList();
  List<Rate> get customRates => where((e) => e.source == RateSource.custom).toList();
}

class RateEqualityExceptRateWrapper extends Equatable {
  const RateEqualityExceptRateWrapper(this.rate);

  final Rate rate;

  @override
  List<Object?> get props => [rate.from, rate.to, rate.source];
}
