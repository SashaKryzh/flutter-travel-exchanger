import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' as p;
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/popular_provider.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/domain/recently_used_provider.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_providers.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/currency_list_item.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/search_bar.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/bottom_safe_area.dart';
import 'package:travel_exchanger/widgets/empty_widget.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

class SelectCurrencyPageV2 extends HookWidget {
  const SelectCurrencyPageV2({
    super.key,
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    return ProviderScope(
      overrides: [
        selectCurrencyPageInitialCurrencyProvider.overrideWithValue(Currency(currencyCode)),
      ],
      child: Consumer(
        builder: (context, ref, child) {
          ref.watch(selectCurrencyNotifierProvider);

          return p.ListenableProvider.value(
            value: scrollController,
            child: Scaffold(
              body: SearchBarWrapper(
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    const _AppBar(),
                    const _SelectedSection().sliver(),
                    const _RecentSection().sliver(),
                    const _PopularSection().sliver(),
                    const SizedSpacer(16).sliver(),
                    const _SectionHeading(
                      icon: Icon(Icons.list),
                      title: Text('All'),
                    ).sliver(),
                    const _AllList(),
                    const BottomSafeArea().sliver(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AppBar extends ConsumerWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectingFor = ref.watch(selectCurrencyNotifierProvider).selectingFor;
    final between = ref.watch(exchangeBetweenProvider);

    void onTap(Currency currency) {
      if (currency == selectingFor) {
        context
            .read<ScrollController>()
            .animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeInOut);
      } else {
        ref.read(selectCurrencyNotifierProvider.notifier).selectFor(currency);
      }
    }

    Widget divider() => const SizedBox(
          height: 24,
          child: VerticalDivider(
            color: Colors.black,
            width: 6,
            thickness: 1.5,
          ),
        );

    return SliverAppBar(
      pinned: true,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _CurrencyItem(
            currency: between.from,
            active: between.from == selectingFor,
            onTap: () => onTap(between.from),
          ),
          divider(),
          _CurrencyItem(
            currency: between.to1,
            active: between.to1 == selectingFor,
            onTap: () => onTap(between.to1),
          ),
          if (between.isThree) ...[
            divider(),
            _CurrencyItem(
              currency: between.to2!,
              active: between.to2! == selectingFor,
              onTap: () => onTap(between.to2!),
            ),
          ],
        ],
      ),
      actions: [
        IconButton(
          onPressed: between.isTwo
              ? ref.read(exchangeBetweenProvider.notifier).showThird
              : ref.read(exchangeBetweenProvider.notifier).hideThird,
          icon: Icon(between.isTwo ? Icons.add : Icons.remove),
        ),
      ],
    );
  }
}

class _CurrencyItem extends StatelessWidget {
  const _CurrencyItem({
    required this.currency,
    required this.active,
    required this.onTap,
  });

  final Currency currency;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        child: Text(
          currency.displayCode(context),
          style: TextStyle(
            color: active ? context.theme.primaryColor : null,
          ),
        ),
      ),
    );
  }
}

class _SelectedSection extends ConsumerWidget {
  const _SelectedSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectingFor = ref.watch(selectCurrencyNotifierProvider).selectingFor;
    final between = ref.watch(exchangeBetweenProvider);
    final to2 = between.to2;

    void onTap(Currency currency) {
      ref.read(selectCurrencyNotifierProvider.notifier).selectFor(currency);
    }

    return Column(
      children: [
        const _SectionHeading(
          icon: Icon(Icons.check),
          title: Text('Selected'),
          trailing: Text('Rate'),
        ),
        SelectedCurrencyListItem(
          currency: between.from,
          active: between.from == selectingFor,
          rate: ref.watch(rateProvider(between.from, between.from)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          onTap: () => onTap(between.from),
        ),
        SelectedCurrencyListItem(
          currency: between.to1,
          active: between.to1 == selectingFor,
          rate: ref.watch(rateProvider(between.from, between.to1)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          onTap: () => onTap(between.to1),
        ),
        if (to2 != null)
          SelectedCurrencyListItem(
            currency: to2,
            active: to2 == selectingFor,
            rate: ref.watch(rateProvider(between.from, to2)),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            onTap: () => onTap(to2),
          ),
      ],
    );
  }
}

class _RecentSection extends ConsumerWidget {
  const _RecentSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectingFor = ref.watch(selectCurrencyNotifierProvider).selectingFor;
    final recentlyUsed = ref.watch(filteredRecentlyUsedProvider(limit: 3));

    if (recentlyUsed.isEmpty) {
      return const EmptyWidget();
    }

    return Column(
      children: [
        const SizedSpacer(16),
        const _SectionHeading(
          icon: Icon(Icons.replay),
          title: Text('Recent'),
        ),
        const SizedSpacer(16),
        for (final currency in recentlyUsed)
          RegularCurrencyListItem(
            currency: currency,
            swapableWith: null,
            selected: currency == selectingFor,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            onTap: () => swapToCurrency(ref, currency),
          ),
      ],
    );
  }
}

class _PopularSection extends ConsumerWidget {
  const _PopularSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularCurrencies = ref.watch(popularCurrenciesProvider);

    return Column(
      children: [
        const SizedSpacer(16),
        const _SectionHeading(
          icon: Icon(Icons.star),
          title: Text('Popular'),
        ),
        const SizedSpacer(16),
        const Text('Your Time'),
        const SizedSpacer(12),
        for (final currency in popularCurrencies)
          () {
            final metadata = ref.watch(currencyMetadataProvider(currency));

            return RegularCurrencyListItem(
              currency: currency,
              selected: metadata.isSelected,
              swapableWith: metadata.swapableWith,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              onTap: () => swapToCurrency(ref, currency),
            );
          }(),
      ],
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading({
    required this.icon,
    required this.title,
    this.trailing,
  });

  final Widget icon;
  final Widget title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          icon,
          const SizedSpacer(8),
          DefaultTextStyle.merge(
            style: context.textTheme.headlineSmall,
            child: title,
          ).expanded(),
          if (trailing != null) trailing!,
        ],
      ),
    );
  }
}

class _AllList extends ConsumerWidget {
  const _AllList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencies = ref.watch(selectCurrencyAllCurrenciesProvider);

    return SliverList.builder(
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        final currency = currencies[index];
        final metadata = ref.watch(currencyMetadataProvider(currency));

        return RegularCurrencyListItem(
          currency: currency,
          selected: metadata.isSelected,
          swapableWith: metadata.swapableWith,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          onTap: () => swapToCurrency(ref, currency),
        );
      },
    );
  }
}

/// Swaps to currency in the ExchangeBetween and also updates selectingFor in the SelectCurrencyNotifier.
void swapToCurrency(WidgetRef ref, Currency currency) {
  final from = ref.read(selectCurrencyNotifierProvider).selectingFor;
  ref.read(selectCurrencyNotifierProvider.notifier).selectFor(currency);
  ref.read(exchangeBetweenProvider.notifier).swap(from, currency);
}
