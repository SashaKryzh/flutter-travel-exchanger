import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table_background.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

class HomeAppBar extends ConsumerWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final between = ref.watch(exchangeBetweenProvider);

    void onCurrencyTap(Currency currency) {
      SelectCurrencyRoute(currencyCode: currency.code).go(context);
    }

    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1,
          ),
        ),
      ),
      child: TableColumnsBackgroundWrapper(
        columnsCount: ref.watch(exchangeBetweenProvider).length,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
            ),
            child: Row(
              children: [
                Expanded(
                  child: _ColumnHeader(
                    currency: between.from,
                    alignment: ColumnAlignment.right,
                    onTap: () => onCurrencyTap(between.from),
                  ),
                ),
                Expanded(
                  child: _ColumnHeader(
                    currency: between.to1,
                    alignment: between.isThree ? ColumnAlignment.center : ColumnAlignment.left,
                    onTap: () => onCurrencyTap(between.to1),
                  ),
                ),
                if (between.isThree)
                  Expanded(
                    child: _ColumnHeader(
                      currency: between.to2!,
                      alignment: ColumnAlignment.left,
                      onTap: () => onCurrencyTap(between.to2!),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ColumnHeader extends StatelessWidget {
  const _ColumnHeader({
    required this.currency,
    required this.alignment,
    required this.onTap,
  });

  final Currency currency;
  final ColumnAlignment alignment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textAlign = switch (alignment) {
      ColumnAlignment.left => TextAlign.start,
      ColumnAlignment.center => TextAlign.center,
      ColumnAlignment.right => TextAlign.end,
    };

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: valuePadding),
        child: Text(currency.name(context)).textAlignX(textAlign),
      ),
    );
  }
}
