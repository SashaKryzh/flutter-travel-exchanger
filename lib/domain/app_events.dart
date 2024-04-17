import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'app_events.g.dart';

@riverpod
Stream<AppEvent> appEvent(AppEventRef ref) {
  return $appEvents.events;
}

final $appEvents = AppEvents();

final class AppEvents {
  final _streamController = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get events => _streamController.stream;

  void add(AppEvent event) {
    logDebug('AppEvents.add: $event');
    _streamController.add(event);
  }
}

base class AppEvent {
  const AppEvent();
}

final class DecreaseValuesFromEvent extends AppEvent {
  const DecreaseValuesFromEvent();
}

final class IncreaseValuesFromEvent extends AppEvent {
  const IncreaseValuesFromEvent();
}

final class ExpandRowEvent extends AppEvent {
  const ExpandRowEvent();
}

final class CollapseRowEvent extends AppEvent {
  const CollapseRowEvent();
}

final class OpenSelectCurrencyPageEvent extends AppEvent {
  const OpenSelectCurrencyPageEvent();
}
