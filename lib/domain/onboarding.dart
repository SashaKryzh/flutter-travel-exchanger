import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/data/onboarding_repository.dart';
import 'package:travel_exchanger/domain/app_events.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'onboarding.freezed.dart';
part 'onboarding.g.dart';

class Onboarding {
  static OnboardingStep? _step;

  static void guard(VoidCallback callback, {AppEvent? event, bool addEvent = true}) {
    if (event != null && addEvent) {
      $appEvents.add(event);
    }

    final step = _step;
    if (step == null || step.requiredEvent == null) {
      callback();
      return;
    }

    if (event == null || step.requiredEvent != event) {
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

    return OnboardingState(OnboardingStep.complete);
  }

  Future<bool> isOnboardingComplete() async {
    return ref.read(onboardingRepositoryProvider).isOnboardingComplete();
  }

  void start() {
    Onboarding._step = OnboardingStep.values.first;
    state = OnboardingState(OnboardingStep.values.first);
  }

  Future<void> complete() async {
    await ref.read(onboardingRepositoryProvider).storeOnboardingComplete();
    Onboarding._step = OnboardingStep.complete;
    state = OnboardingState(OnboardingStep.complete);
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
  thanks(_ImpossibleToCompleteEvent()),
  complete(null);

  const OnboardingStep(this.requiredEvent);
  final AppEvent? requiredEvent;
}

final class _ImpossibleToCompleteEvent extends AppEvent {
  const _ImpossibleToCompleteEvent();
}
