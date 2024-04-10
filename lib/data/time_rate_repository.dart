import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rate.dart';
import 'package:travel_exchanger/utils/analytics/analytics.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'time_rate_repository.freezed.dart';
part 'time_rate_repository.g.dart';

@riverpod
TimeRateRepository timeRateRepository(TimeRateRepositoryRef _) {
  throw Exception('Time repository provider should be overridden');
}

/// Time rate repository
///
/// Rate is stored as units of currency per hour.
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

  Future<void> setTimeRate(MoneyCurrency to, {required double perHour}) async {
    final newData = data?.copyWith(
          to: to,
          perHour: perHour,
        ) ??
        TimeRateData(
          to: to,
          perHour: perHour,
        );

    analyticsVar.logCustomTimeRate(to, perHour);
    _setData = newData;
    await _store(newData);
  }

  Future<void> removeTimeRate() async {
    _setData = null;
    await _clear();
  }

  Future<TimeRateData?> _load() async {
    try {
      final jsonString = _sharedPreferences.getString(_timeRateDataKey);
      if (jsonString == null) {
        return null;
      }
      final data = await compute(
        (m) => TimeRateData.fromJson(jsonDecode(m) as Map<String, dynamic>),
        jsonString,
      );
      return data;
    } catch (e, stackTrace) {
      logger.e('Failed to load time rate data', error: e, stackTrace: stackTrace);
      await _clear();
      return null;
    }
  }

  Future<void> _store(TimeRateData data) async {
    final json = jsonEncode(data.toJson());
    await _sharedPreferences.setString(_timeRateDataKey, json);
  }

  Future<void> _clear() async {
    await _sharedPreferences.remove(_timeRateDataKey);
  }
}

@freezed
class TimeRateData with _$TimeRateData {
  factory TimeRateData({
    // TODO: Change to MoneyCurrency, this is temporary fix for freezed generation.
    required Currency to,
    required double perHour,
  }) = _TimeRateData;

  factory TimeRateData.fromJson(Map<String, dynamic> json) => _$TimeRateDataFromJson(json);
}

extension TimeRateDataX on TimeRateData {
  Rate toRate() {
    return Rate(
      from: Currency.time,
      to: to,
      rate: perHour,
      source: RateSource.custom,
    );
  }
}
