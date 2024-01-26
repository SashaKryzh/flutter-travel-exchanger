import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
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
        top: 8,
        left: 12,
        right: 12,
        bottom: 8,
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
    void onTap(Currency currency) {
      CustomAmountRoute(currencyCode: currency.code).go(context);
    }

    void onLongTap(Currency currency) {
      SelectCurrencyRoute(currencyCode: currency.code).go(context);
    }

    final between = ref.watch(exchangeBetweenProvider);
    final to2 = between.to2;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: _CurrencyButton(
            currency: between.from,
            onTap: () => onTap(between.from),
            onLongTap: () => onLongTap(between.from),
          ),
        ),
        const SizedSpacer(12),
        Expanded(
          child: _CurrencyButton(
            currency: between.to1,
            onTap: () => onTap(between.to1),
            onLongTap: () => onLongTap(between.to1),
          ),
        ),
        if (to2 != null) ...[
          const SizedSpacer(12),
          Expanded(
            child: _CurrencyButton(
              currency: to2,
              onTap: () => onTap(to2),
              onLongTap: () => onLongTap(to2),
            ),
          ),
        ],
      ],
    );
  }
}

class _CurrencyButton extends StatelessWidget {
  const _CurrencyButton({
    required this.currency,
    required this.onTap,
    required this.onLongTap,
  });

  final Currency currency;
  final VoidCallback? onTap;
  final VoidCallback? onLongTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Colors.grey[300],
        ),
        child: Center(
          child: Text(currency.name(context)),
        ),
      ),
    );
  }
}

class _SwapButtons extends ConsumerWidget {
  const _SwapButtons({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void swap(Currency from, Currency to) {
      ref.read(exchangeBetweenProvider.notifier).swap(from, to);
    }

    final between = ref.watch(exchangeBetweenProvider);

    return Row(
      mainAxisAlignment: between.isThree ? MainAxisAlignment.spaceEvenly : MainAxisAlignment.center,
      children: [
        _SwapButton(
          onTap: () => swap(between.from, between.to1),
        ),
        if (between.isThree) ...[
          _SwapButton(
            onTap: () => swap(between.to1, between.to2!),
          ),
        ],
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
