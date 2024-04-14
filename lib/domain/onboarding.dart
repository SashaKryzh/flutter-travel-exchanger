import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/app_events.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'onboarding.freezed.dart';
part 'onboarding.g.dart';

class Onboarding {
  static var _step = OnboardingStep.complete;

  static void guard(VoidCallback callback, {AppEvent? event, bool addEvent = true}) {
    if (event != null && addEvent) {
      $appEvents.add(event);
    }

    if (_step.requiredEvent == null) {
      callback();
    }

    if (event == null || _step.requiredEvent != event) {
      return;
    }

    callback();
  }
}

@riverpod
class OnboardingNotifier extends _$OnboardingNotifier {
  @override
  OnboardingState build() {
    ref.listen(appEventProvider, (previous, next) {
      final event = next.unwrapPrevious().valueOrNull;
      if (event != null) {
        _processAppEvent(event);
      }
    });

    return OnboardingState(
      OnboardingStep.values.first,
    );
  }

  void _processAppEvent(AppEvent event) {
    if (state.step == OnboardingStep.complete || event != state.step.requiredEvent) {
      return;
    }
    final currentIndex = OnboardingStep.values.indexOf(state.step);
    final newState = OnboardingStep.values.elementAtOrNull(currentIndex + 1);
    if (newState == null) {
      return;
    }
    state = OnboardingState(newState);
    Onboarding._step = newState;
    logDebug('New onboarding step: $newState');
  }
}

@freezed
class OnboardingState with _$OnboardingState {
  factory OnboardingState(
    OnboardingStep step,
  ) = _OnboardingState;
}

enum OnboardingStep {
  increaseValuesFrom(IncreaseValuesFromEvent()),
  decreaseValuesFrom(DecreaseValuesFromEvent()),
  expandRow(ExpandRowEvent()),
  collapseRow(CollapseRowEvent()),
  openSelectCurrencyPage(OpenSelectCurrencyPageEvent()),
  complete(null);

  const OnboardingStep(this.requiredEvent);
  final AppEvent? requiredEvent;
}
