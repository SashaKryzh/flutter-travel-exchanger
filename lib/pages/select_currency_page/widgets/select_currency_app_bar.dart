import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:travel_exchanger/config/theme/app_icons.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_providers.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/utils/hooks/use_listen.dart';

class SelectCurrencyAppBar extends HookConsumerWidget {
  const SelectCurrencyAppBar({
    super.key,
    required this.scrollController,
  });

  final ScrollController scrollController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectingFor = ref.watch(selectCurrencyNotifierProvider).selectingFor;
    final between = ref.watch(exchangeBetweenProvider);

    final showCurrencies = useState(false);
    useListen(scrollController, () {
      showCurrencies.value = scrollController.offset > 150;
    });

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
            width: 6,
            thickness: 1.5,
          ),
        );

    return SliverAppBar(
      pinned: true,
      centerTitle: true,
      title: IgnorePointer(
        ignoring: !showCurrencies.value,
        child: Row(
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
        )
            .animate(target: showCurrencies.value ? 1 : 0)
            .moveY(duration: const Duration(milliseconds: 100), begin: 15)
            .fadeIn(),
      ),
      actions: [
        IconButton(
          onPressed: between.isTwo
              ? ref.read(exchangeBetweenProvider.notifier).showThird
              : ref.read(exchangeBetweenProvider.notifier).hideThird,
          icon: Icon(AppIcons.columns(three: between.isTwo)),
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
            color: active ? context.colorScheme.primary : null,
          ),
        ),
      ),
    );
  }
}
