import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/config/theme/app_icons.dart';
import 'package:travel_exchanger/domain/app_events.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/onboarding.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table_background.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/empty_widget.dart';
import 'package:travel_exchanger/widgets/glass_container.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

class HomeBottomBar extends ConsumerWidget {
  static double get height => kBottomNavigationBarHeight;

  static double heightWithPadding(BuildContext context) {
    return height + MediaQuery.of(context).padding.bottom;
  }

  const HomeBottomBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ExchangeTableBackgroundWrapper(
      columnsCount: ref.watch(exchangeBetweenProvider).length,
      child: GlassContainer(
        color: context.colorScheme.surface.withOpacity(0.7),
        border: Border(
          top: BorderSide(
            color: context.colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(color: context.colorScheme.shadow.withOpacity(0.1)),
        ],
        child: const SafeArea(
          top: false,
          maintainBottomViewPadding: true,
          child: SizedBox(
            height: kBottomNavigationBarHeight,
            child: _Content(),
          ),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content();

  @override
  Widget build(BuildContext context) {
    return const Stack(
      alignment: Alignment.center,
      children: [
        _CurrencyButtons(),
        _SwapButtons(),
      ],
    );
  }
}

class _CurrencyButtons extends ConsumerWidget {
  const _CurrencyButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onTap(Currency currency) {
      HapticFeedback.lightImpact();
      Onboarding.guard(
        () => CustomAmountRoute(currencyCode: currency.code).go(context),
      );
    }

    void onLongTap(Currency currency) {
      HapticFeedback.mediumImpact();
      Onboarding.guard(
        () => SelectCurrencyRoute(currencyCode: currency.code).go(context),
        event: const OpenSelectCurrencyPageEvent(),
      );
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
          ).padding(l: 12, r: 6),
        ),
        Expanded(
          child: _CurrencyButton(
            currency: between.to1,
            onTap: () => onTap(between.to1),
            onLongTap: () => onLongTap(between.to1),
          ).padding(l: 6, r: between.isThree ? 6 : 12),
        ),
        if (to2 != null) ...[
          Expanded(
            child: _CurrencyButton(
              currency: to2,
              onTap: () => onTap(to2),
              onLongTap: () => onLongTap(to2),
            ).padding(l: 6, r: 12),
          ),
        ],
      ],
    );
  }
}

class _CurrencyButton extends StatelessWidget {
  static final _autoSizeGroup = AutoSizeGroup();

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
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(vertical: 10),
        height: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          border: Border.all(color: context.colorScheme.outlineVariant),
          color: context.colorScheme.surface,
        ),
        child: AutoSizeText(
          currency.displayCode(context),
          group: _autoSizeGroup,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyMedium?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _SwapButtons extends ConsumerWidget {
  const _SwapButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void swap(Currency from, Currency to) {
      HapticFeedback.mediumImpact();
      Onboarding.guard(
        () => ref.read(exchangeBetweenProvider.notifier).swap(from, to),
      );
    }

    final between = ref.watch(exchangeBetweenProvider);

    return Row(
      children: [
        const EmptyWidget().expanded(),
        _SwapButton(
          onTap: () => swap(between.from, between.to1),
        ),
        if (between.isThree) ...[
          const EmptyWidget().expanded(),
          _SwapButton(
            onTap: () => swap(between.to1, between.to2!),
          ),
        ],
        const EmptyWidget().expanded(),
      ],
    ).padding(x: 16);
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
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.colorScheme.surface,
          border: Border.all(
            color: context.colorScheme.outlineVariant,
          ),
        ),
        child: Icon(
          AppIcons.swap,
          color: context.colorScheme.onSurface,
          size: 20,
        ),
      ),
    );
  }
}
