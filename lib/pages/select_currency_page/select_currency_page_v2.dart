import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/domain/recently_used_provider.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_providers.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/currency_list_item.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/utils/logger.dart';
import 'package:travel_exchanger/widgets/bottom_safe_area.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

late SelectCurrencyState _selectCurrencyState;

Currency get _selectingFor => _selectCurrencyState.selectingFor;

class SelectCurrencyPageV2 extends ConsumerWidget {
  const SelectCurrencyPageV2({
    super.key,
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _selectCurrencyState = ref.watch(selectCurrencyNotifierProvider(Currency(currencyCode)));

    return Scaffold(
      body: CustomScrollView(
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
    );
  }
}

class _AppBar extends ConsumerWidget {
  const _AppBar();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final between = ref.watch(exchangeBetweenProvider);

    return SliverAppBar(
      pinned: true,
      title: Text(
        '${between.from.code} | ${between.to1.code}${between.isThree ? ' | ${between.to2!.code}' : ''}',
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

class _SelectedSection extends ConsumerWidget {
  const _SelectedSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final between = ref.watch(exchangeBetweenProvider);

    final to2 = between.to2;

    return Column(
      children: [
        const _SectionHeading(
          icon: Icon(Icons.check),
          title: Text('Selected'),
          trailing: Text('Rate'),
        ),
        SelectedCurrencyListItem(
          currency: between.from,
          active: between.from == _selectingFor,
          rate: ref.watch(rateProvider(between.from, between.from)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          onTap: () {},
        ),
        SelectedCurrencyListItem(
          currency: between.to1,
          active: between.to1 == _selectingFor,
          rate: ref.watch(rateProvider(between.from, between.to1)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          onTap: () {},
        ),
        if (to2 != null)
          SelectedCurrencyListItem(
            currency: to2,
            active: to2 == _selectingFor,
            rate: ref.watch(rateProvider(between.from, to2)),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            onTap: () {},
          ),
      ],
    );
  }
}

class _RecentSection extends ConsumerWidget {
  const _RecentSection();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentlyUsed = ref.watch(recentlyUsedProvider());

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
            selected: currency == _selectingFor,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            onTap: () {
              logger.d('Tap: $currency');
            },
          ),
      ],
    );
  }
}

class _PopularSection extends ConsumerWidget {
  const _PopularSection();

  static final _popularCurrencies = [
    Currency('EUR'),
    Currency('USD'),
    Currency('GBP'),
    Currency('JPY'),
    Currency('CNY'),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final between = ref.watch(exchangeBetweenProvider);

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
        for (final currency in _popularCurrencies)
          () {
            final isSelected = _selectingFor == currency;
            final swapableWith =
                between.contains(currency) && currency != _selectingFor ? _selectingFor : null;

            return RegularCurrencyListItem(
              currency: currency,
              selected: isSelected,
              swapableWith: swapableWith,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              onTap: () {
                logger.d('Tap: $currency');
              },
            );
          }()
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
    final between = ref.watch(exchangeBetweenProvider);

    return SliverList.builder(
      itemCount: currencies.length,
      itemBuilder: (context, index) {
        final currency = currencies[index];

        final isSelected = _selectingFor == currency;
        final swapableWith =
            between.contains(currency) && currency != _selectingFor ? _selectingFor : null;

        return RegularCurrencyListItem(
          currency: currency,
          selected: isSelected,
          swapableWith: swapableWith,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          onTap: () {
            logger.d('Tap: $currency');
          },
        );
      },
    );
  }
}
