import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'exchange_between_repository.g.dart';

@riverpod
ExchangeBetweenRepository exchangeBetweenRepository(ExchangeBetweenRepositoryRef ref) {
  throw Exception('Exchange between repository provider should be overridden');
}

class ExchangeBetweenRepository {
  static const _key = 'exchangeBetween';

  ExchangeBetweenRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  Between? _between;
  Between? get between => _between;

  Future<void> init() async {
    try {
      final string = _sharedPreferences.getString(_key);
      if (string == null) {
        return;
      }
      _between = await compute(
        (e) => Between.fromJson(jsonDecode(e) as Map<String, dynamic>),
        string,
      );
    } catch (e, stackTrace) {
      logger.e('Error fetching local exchange between', error: e, stackTrace: stackTrace);
    }
  }

  Future<void> setExchangeBetween(Between between) async {
    _between = between;
    await _sharedPreferences.setString(_key, jsonEncode(between.toJson()));
  }

  Future<void> clear() async {
    _between = null;
    await _sharedPreferences.remove(_key);
  }
}
