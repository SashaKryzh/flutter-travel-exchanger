import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/domain/converter_providers.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';

class HomeBottomBar extends ConsumerWidget {
  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: const SafeArea(
        top: false,
        maintainBottomViewPadding: true,
        child: _Content(),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 6,
        left: 12,
        right: 12,
        bottom: 6,
      ),
      child: const Stack(
        alignment: Alignment.center,
        children: [
          _CurrencyButtons(),
          _SwapButtons(),
        ],
      ),
    );
  }
}

class _CurrencyButtons extends ConsumerWidget {
  const _CurrencyButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onTap(Exchangeable exchangeable) {
      context.go('/${exchangeable.code}');
    }

    final between = ref.watch(exchangeBetweenProvider);
    final e3 = between.between.$3;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _CurrencyButton(
            exchangeable: between.between.$1,
            onTap: () => onTap(between.between.$1),
          ),
        ),
        const SizedSpacer(12),
        Expanded(
          child: _CurrencyButton(
            exchangeable: between.between.$2,
            onTap: () => onTap(between.between.$2),
          ),
        ),
        if (e3 != null) ...[
          const SizedSpacer(12),
          Expanded(
            child: _CurrencyButton(
              exchangeable: e3,
              onTap: () => onTap(e3),
            ),
          ),
        ],
      ],
    );
  }
}

class _CurrencyButton extends StatelessWidget {
  const _CurrencyButton({
    required this.exchangeable,
    required this.onTap,
  });

  final Exchangeable exchangeable;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.grey[300],
        ),
        child: Center(
          child: Text(exchangeable.name(context)),
        ),
      ),
    );
  }
}

class _SwapButtons extends ConsumerWidget {
  const _SwapButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void swap(Exchangeable from, Exchangeable to) {
      ref.read(exchangeBetweenProvider.notifier).swap(from, to);
    }

    final between = ref.watch(exchangeBetweenProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _SwapButton(
          onTap: () => swap(between.between.$1, between.between.$2),
        ),
      ],
    );
  }
}

class _SwapButton extends StatelessWidget {
  const _SwapButton({
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
        ),
        child: const Icon(Icons.swap_horiz),
      ),
    );
  }
}
