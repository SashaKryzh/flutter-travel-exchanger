import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/domain/converter_providers.dart';
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
      context.go('/select?currencyCode=${currency.code}');
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
        columnsCount: 2,
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 6,
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => onCurrencyTap(between.between.$1),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: valuePadding),
                      child: Text(between.between.$1.name(context)).textAlignX(
                        TextAlign.end,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => onCurrencyTap(between.between.$2),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: valuePadding),
                      child: Text(between.between.$2.name(context)).textAlignX(
                        TextAlign.start,
                      ),
                    ),
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
