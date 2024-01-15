import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:travel_exchanger/data/rates.dart';
import 'package:travel_exchanger/domain/rate.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'rates_repository.g.dart';

@riverpod
RatesRepository ratesRepository(RatesRepositoryRef ref) {
  throw UnimplementedError();
}

class RatesRepository {
  static const _timestampKey = 'ratesTimestamp';
  static const _ratesKey = 'rates';

  RatesRepository(this._supabase, this._sharedPreferences);

  final SupabaseClient _supabase;
  final SharedPreferences _sharedPreferences;

  List<Rate> _rates = [];

  List<Rate> get rates {
    assert(_rates.isNotEmpty, 'Rates not loaded');
    return _rates;
  }

  Future<void> initRates() async {
    final stored = await _fetchStoredRates();
    if (stored != null && stored.isNotEmpty) {
      _rates = stored;
    } else {
      _rates = await _fetchAndStoreRates();
    }

    assert(_rates.isNotEmpty, 'Rates not loaded');
  }

  Future<void> updateRatesIfExpired() async {
    final lastStored = _getStoredTimestamp();

    if (lastStored.isAfter(DateTime.now().subtract(const Duration(hours: 1)))) {
      logger.d('Rates are not expired');
      return;
    }

    final rates = await _fetchAndStoreRates();
    if (rates.isEmpty) {
      return;
    }

    _rates = rates;
  }

  Future<List<Rate>> _fetchAndStoreRates() async {
    logger.d('Fetching rates');

    List<Rate> rates;

    try {
      final response = await _supabase.functions.invoke('rates', method: HttpMethod.get);
      final data = GetRatesResponse.fromJson(response.data);
      rates = data.rates;
    } on FunctionException catch (e) {
      logger.e('FunctionException: ${e.status} ${e.reasonPhrase} ${e.details}');
      rates = [];
    }

    if (rates.isEmpty) {
      logger.e('Rates are empty');
    }

    _storeRates(rates);

    return rates;
  }

  DateTime _getStoredTimestamp() {
    final timestamp = _sharedPreferences.getString(_timestampKey);
    if (timestamp == null) {
      return DateTime(0);
    }

    return DateTime.parse(timestamp);
  }

  Future<List<Rate>?> _fetchStoredRates() async {
    final jsonString = _sharedPreferences.getString(_ratesKey);
    if (jsonString == null) {
      return null;
    }

    final json = await compute(jsonDecode, jsonString) as List<dynamic>;
    return json.map((e) => Rate.fromJson(e)).toList();
  }

  Future<void> _storeRates(List<Rate> rates) async {
    logger.d('Storing rates locally');

    final json = rates.map((e) => e.toJson()).toList();
    final jsonString = await compute(jsonEncode, json);

    await Future.wait([
      _sharedPreferences.setString(_timestampKey, DateTime.now().toIso8601String()),
      _sharedPreferences.setString(_ratesKey, jsonString),
    ]);
  }
}
