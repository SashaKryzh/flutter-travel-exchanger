import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' as p;
import 'package:travel_exchanger/config/theme/app_icons.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/models/feature_flags.dart';
import 'package:travel_exchanger/domain/popular_provider.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/domain/recently_used_provider.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_providers.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/currency_list_item.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/custom_rate_modal.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/custom_time_rate_modal.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/search_bar.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/select_currency_app_bar.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/swapable_with.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/bottom_safe_area.dart';
import 'package:travel_exchanger/widgets/empty_widget.dart';
import 'package:travel_exchanger/widgets/modal.dart';
import 'package:travel_exchanger/widgets/shortcut_widgets.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

const kSectionHeadingBeforePadding = 20.0;

class SelectCurrencyPage extends HookWidget {
  const SelectCurrencyPage({
    super.key,
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

    final showCustomRateToCurrency = useRef<Currency>(Currency.eur);
    final showCustomRateCallback = useRef<VoidCallback?>(null);
    final showCustomRate = useState(false);
    final showCustomRateDebounced =
        useDebounced(showCustomRate.value, const Duration(milliseconds: 500));

    final resizeToAvoidBottomInset = !showCustomRate.value && showCustomRateDebounced == false;

    void onEditRate(Currency currency, {VoidCallback? callback}) {
      showCustomRateToCurrency.value = currency;
      showCustomRateCallback.value = callback;
      showCustomRate.value = true;
    }

    void onCloseCustomRate() {
      showCustomRate.value = false;
      showCustomRateCallback.value?.call();
    }

    return Modal(
      visible: showCustomRate.value,
      onDismiss: onCloseCustomRate,
      modal: () {
        final to = showCustomRateToCurrency.value;
        return switch (to) {
          MoneyCurrency() => CustomRateModal(
              to: to,
              onClose: onCloseCustomRate,
            ),
          TimeCurrency() => CustomTimeRateModal(
              onClose: onCloseCustomRate,
            ),
        };
      }(),
      child: ProviderScope(
        overrides: [
          selectCurrencyPageInitialCurrencyProvider.overrideWithValue(Currency(currencyCode)),
        ],
        child: Consumer(
          builder: (context, ref, child) {
            ref.watch(selectCurrencyNotifierProvider);

            return p.ListenableProvider.value(
              value: scrollController,
              child: Scaffold(
                resizeToAvoidBottomInset: resizeToAvoidBottomInset,
                body: SearchBarWrapper(
                  settings: SearchSettings(
                    metadata: (currency) => ref.watch(currencyMetadataProvider(currency)),
                  ),
                  onSelected: (value) => swapToCurrency(ref, value),
                  child: CustomScrollView(
                    controller: scrollController,
                    slivers: [
                      SelectCurrencyAppBar(
                        scrollController: scrollController,
                      ),
                      _SelectedSection(
                        onEditRate: onEditRate,
                      ).sliver(),
                      if (kEnableRecentCurrencies) const _RecentSection().sliver(),
                      _PopularSection(
                        onEditRate: onEditRate,
                      ).sliver(),
                      const SizedSpacer(kSectionHeadingBeforePadding).sliver(),
                      const _SectionHeading(
                        icon: Icon(AppIcons.all),
                        title: Text('All'),
                      ).sliver(),
                      const _AllList(),
                      const BottomSafeArea(additionalHeight: 100).sliver(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _SelectedSection extends HookConsumerWidget {
  const _SelectedSection({required this.onEditRate});

  final void Function(Currency) onEditRate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectingFor = ref.watch(selectCurrencyNotifierProvider).selectingFor;
    final between = ref.watch(exchangeBetweenProvider);
    final to2 = between.to2;

    void onTap(Currency currency) {
      ref.read(selectCurrencyNotifierProvider.notifier).selectFor(currency);
    }

    void onReorder(int oldIndex, int newIndex) {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final betweenList = List.of(between.currencies);
      final item = betweenList.removeAt(oldIndex);
      betweenList.insert(newIndex, item);
      ref.read(exchangeBetweenProvider.notifier).setNewOrder(
            betweenList.elementAt(0),
            betweenList.elementAt(1),
            betweenList.elementAtOrNull(2),
          );
    }

    const padding = EdgeInsets.symmetric(horizontal: 12);

    return Column(
      children: [
        _SectionHeading(
          icon: const Icon(AppIcons.selected),
          title: const Text('Selected'),
          trailing: HStack(
            children: [
              const Text(
                'Rate',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              Opacity(
                opacity: 0,
                child: SelectedCurrencyListItem.reorderIndicator(context),
              ),
            ],
          ),
        ),
        ReorderableListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          onReorder: onReorder,
          children: [
            SelectedCurrencyListItem(
              key: ValueKey(between.from),
              currency: between.from,
              active: between.from == selectingFor,
              rate: ref.watch(rateProvider(between.from, between.from)),
              padding: padding,
              onTap: () => onTap(between.from),
              onEditRate: null,
            ),
            SelectedCurrencyListItem(
              key: ValueKey(between.to1),
              currency: between.to1,
              active: between.to1 == selectingFor,
              rate: ref.watch(rateProvider(between.from, between.to1)),
              padding: padding,
              onTap: () => onTap(between.to1),
              onEditRate: () => onEditRate(between.to1),
            ),
            if (to2 != null)
              SelectedCurrencyListItem(
                key: ValueKey(to2),
                currency: to2,
                active: to2 == selectingFor,
                rate: ref.watch(rateProvider(between.from, to2)),
                padding: padding,
                onTap: () => onTap(to2),
                onEditRate: () => onEditRate(to2),
              ),
          ],
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
        const SizedSpacer(kSectionHeadingBeforePadding),
        const _SectionHeading(
          icon: Icon(AppIcons.recent),
          title: Text('Recent'),
        ),
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
  const _PopularSection({
    required this.onEditRate,
  });

  final void Function(Currency currency, {VoidCallback? callback}) onEditRate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final popularCurrencies = ref.watch(popularCurrenciesProvider);

    return Column(
      children: [
        const SizedSpacer(kSectionHeadingBeforePadding),
        const _SectionHeading(
          icon: Icon(AppIcons.popular),
          title: Text('Popular'),
        ),
        const SizedSpacer(16),
        _YourTimePopularItem(
          onEditRate: onEditRate,
        ),
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

class _YourTimePopularItem extends HookConsumerWidget {
  const _YourTimePopularItem({required this.onEditRate});

  final void Function(Currency currency, {VoidCallback callback}) onEditRate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metadata = ref.watch(currencyMetadataProvider(Currency.time));
    final timeRateExists = ref.watch(timeRateDataProvider) != null;
    final betweenContainsTime =
        ref.watch(exchangeBetweenProvider).currencies.contains(Currency.time);

    void onTap() {
      if (timeRateExists) {
        swapToCurrency(ref, Currency.time);
      } else {
        onEditRate(
          Currency.time,
          callback: () async {
            // Await for provider to update with the latest data from Stream.
            // Without it, the data will be null.
            await Future(() => null);
            if (ref.read(timeRateDataProvider) != null) {
              swapToCurrency(ref, Currency.time);
            }
          },
        );
      }
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      decoration: BoxDecoration(
        color: betweenContainsTime
            ? Colors.grey.withOpacity(0.1)
            : context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          VStack(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Currency.time.displayCode(context),
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Text('Use your time as currency'),
            ],
          ),
          const Spacer(),
          if (timeRateExists && metadata.isSelected)
            Icon(
              AppIcons.selected,
              color: context.theme.disabledColor,
            ),
          if (!timeRateExists)
            Icon(
              AppIcons.editTimeRate,
              color: context.theme.disabledColor,
            ),
          if (metadata.swapableWith != null)
            SwapableWith(from: Currency.time, to: metadata.swapableWith!),
        ],
      ),
    ).onTap(onTap);
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
      child: VStack(
        children: [
          HStack(
            children: [
              IconTheme(
                data: IconThemeData(
                  size: 20,
                  color: context.textTheme.titleLarge?.color,
                ),
                child: icon,
              ),
              const SizedSpacer(8),
              DefaultTextStyle.merge(
                style: context.textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                child: title,
              ).expanded(),
              if (trailing != null) trailing!,
            ],
          ),
          const Divider(height: 12),
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
  if (ref.read(exchangeBetweenProvider.notifier).swap(from, currency)) {
    ref.read(selectCurrencyNotifierProvider.notifier).selectFor(currency);
  }
}
