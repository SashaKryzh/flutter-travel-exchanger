import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'recently_used_currency_repository.g.dart';

@riverpod
RecentlyUsedCurrencyRepository recentlyUsedCurrencyRepository(RecentlyUsedCurrencyRepositoryRef _) {
  throw Exception('RecentlyUsedCurrencyRepository provider should be overridden');
}

class RecentlyUsedCurrencyRepository {
  static const _recentlyUsedKey = 'recentlyUsedKey';

  RecentlyUsedCurrencyRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  final _recentlyUsedController = StreamController<List<Currency>>.broadcast();
  Stream<List<Currency>> get recentlyUsedStream => _recentlyUsedController.stream;

  List<Currency> _recentlyUsed = [];
  List<Currency> get recentlyUsed => List.of(_recentlyUsed);

  Future<void> init() async {
    _recentlyUsed = await _fetchStored();
    _recentlyUsedController.add(_recentlyUsed);
  }

  /// Saves 10 recently used currencies.
  Future<void> add(Currency currency) async {
    final newRecentlyUsed = _recentlyUsed.where((e) => e != currency).toList();
    newRecentlyUsed.insert(0, currency);
    _recentlyUsed = newRecentlyUsed.take(10).toList();
    _recentlyUsedController.add(_recentlyUsed);
    await _store(_recentlyUsed);
  }

  Future<List<Currency>> _fetchStored() async {
    final jsonString = _sharedPreferences.getString(_recentlyUsedKey);
    if (jsonString == null) {
      return [];
    }
    try {
      return await compute(
        (message) => (jsonDecode(message) as List)
            .map((e) => Currency.fromJson(e as Map<String, dynamic>))
            .toList(),
        jsonString,
      );
    } catch (e, stackTrace) {
      logger.e('Error fetching local recently used', error: e, stackTrace: stackTrace);
      return [];
    }
  }

  Future<void> _store(List<Currency> currencies) async {
    await _sharedPreferences.setString(
      _recentlyUsedKey,
      jsonEncode(currencies.map((e) => e.toJson()).toList()),
    );
  }
}
