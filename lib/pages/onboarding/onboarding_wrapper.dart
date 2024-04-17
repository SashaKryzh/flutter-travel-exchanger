import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/domain/onboarding.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/empty_widget.dart';
import 'package:travel_exchanger/widgets/shortcut_widgets.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

class OnboardingWrapper extends HookConsumerWidget {
  const OnboardingWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(onboardingNotifierProvider);
    final isComplete = state.step == OnboardingStep.complete;

    void onComplete() {
      if (ref.read(routerProvider).canPop()) {
        ref.read(routerProvider).pop();
      }
      ref.read(onboardingNotifierProvider.notifier).complete();
    }

    return Stack(
      children: [
        child,
        AnimatedSwitcher(
          duration: kThemeAnimationDuration,
          child: !isComplete
              ? IgnorePointer(
                  ignoring: state.step != OnboardingStep.thanks,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    body: Container(
                      color: Colors.black.withOpacity(0.6),
                      alignment: Alignment.center,
                      child: _DescriptionFromStep(
                        step: state.step,
                        onComplete: onComplete,
                      ),
                    ),
                  ),
                )
              : const EmptyWidget(),
        ),
      ],
    );
  }
}

class _DescriptionFromStep extends StatelessWidget {
  const _DescriptionFromStep({
    required this.step,
    required this.onComplete,
  });

  final OnboardingStep step;
  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return switch (step) {
      OnboardingStep.increaseValuesFrom => const _StepDescription(
          description: Text('Swipe left to increase values'),
        ),
      OnboardingStep.decreaseValuesFrom => const _StepDescription(
          description: Text('Swipe right to decrease values'),
        ),
      OnboardingStep.expandRow => const _StepDescription(
          description: Text('Tap on a row to expand it'),
        ),
      OnboardingStep.collapseRow => const _StepDescription(
          description: Text('Tap on the first or last row to collapse it'),
        ),
      OnboardingStep.openSelectCurrencyPage => const _StepDescription(
          description: Text(
            'Tap the currency in the header\nOR\nLong-press in the bottom bar',
          ),
        ),
      OnboardingStep.thanks => _StepDescription(
          description: _ThanksStepDescription(onComplete: onComplete),
        ),
      OnboardingStep.complete => const EmptyWidget(),
    };
  }
}

class _ThanksStepDescription extends StatelessWidget {
  const _ThanksStepDescription({required this.onComplete});

  final VoidCallback onComplete;

  @override
  Widget build(BuildContext context) {
    return VStack(
      children: [
        const Text("That's all\nThank you for using the app!"),
        const Gap(8),
        OutlinedButton(
          style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
          onPressed: onComplete,
          child: const Text('Complete'),
        ),
      ],
    );
  }
}

class _StepDescription extends StatelessWidget {
  const _StepDescription({
    required this.description,
  });

  final Widget description;

  @override
  Widget build(BuildContext context) {
    return description
        .textStyle(
          context.textTheme.headlineSmall?.copyWith(color: Colors.white),
          align: TextAlign.center,
        )
        .padding(x: 10);
  }
}
