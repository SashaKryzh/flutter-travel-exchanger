import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rate.dart';

part 'time_rate_repository.g.dart';
part 'time_rate_repository.freezed.dart';

@riverpod
TimeRateRepository timeRateRepository(TimeRateRepositoryRef ref) {
  throw Exception('Time repository provider should be overridden');
}

class TimeRateRepository {
  static const _timeRateDataKey = 'timeRateDataKey';

  TimeRateRepository(this._sharedPreferences);

  final SharedPreferences _sharedPreferences;

  final _timeRateDataStream = StreamController<TimeRateData?>.broadcast();
  Stream<TimeRateData?> get timeRateDataStream => _timeRateDataStream.stream;

  TimeRateData? _data;
  TimeRateData? get data => _data;
  set _setData(TimeRateData? data) {
    _data = data;
    _timeRateDataStream.add(data);
  }

  Future<void> init() async {
    _setData = await _load();
  }

  Future<void> setTimeRate(Currency to, double rate) async {
    final data = _data;
    if (data == null) {
      final newData = TimeRateData(
        to: to,
        rate: rate,
      );
      _setData = newData;
      await _store(newData);
    } else {
      final newData = data.copyWith(
        to: to,
        rate: rate,
      );
      _setData = newData;
      await _store(newData);
    }
  }

  Future<TimeRateData?> _load() async {
    final jsonString = _sharedPreferences.getString(_timeRateDataKey);
    if (jsonString == null) {
      return null;
    }
    final data = await compute(
      (m) => TimeRateData.fromJson(jsonDecode(m) as Map<String, dynamic>),
      jsonString,
    );
    return data;
  }

  Future<void> _store(TimeRateData data) async {
    final json = jsonEncode(data.toJson());
    await _sharedPreferences.setString(_timeRateDataKey, json);
  }
}

@freezed
class TimeRateData with _$TimeRateData {
  factory TimeRateData({
    required Currency to,
    required double rate,
  }) = _TimeRateData;

  factory TimeRateData.fromJson(Map<String, dynamic> json) => _$TimeRateDataFromJson(json);
}

extension TimeRateDataX on TimeRateData {
  Rate toRate() {
    return Rate(
      from: Currency.time,
      to: to,
      rate: rate,
      source: RateSource.custom,
    );
  }
}
