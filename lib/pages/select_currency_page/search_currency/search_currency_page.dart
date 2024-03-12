import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_providers.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/currency_list_item.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/search_bar.dart';

class SearchCurrencyPage extends HookConsumerWidget {
  const SearchCurrencyPage({
    super.key,
    required this.selectedCurrency,
    required this.onSelectCurrency,
  });

  final Currency? selectedCurrency;
  final ValueChanged<Currency> onSelectCurrency;

  bool filter(Currency e) => e != Currency.time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = useState('');

    final filteredCurrencies = ref.watch(searchCurrenciesProvider(
      query.value,
      filter: filter,
    ));

    void onSelectCurrency(Currency currency) {
      context.pop();
      this.onSelectCurrency(currency);
    }

    return Scaffold(
      body: SearchBarWrapper(
        settings: SearchSettings(
          filter: filter,
          metadata: (currency) => (isSelected: currency == selectedCurrency, swapableWith: null),
        ),
        initialOpened: true,
        onSelected: onSelectCurrency,
        unfocusOnSelected: false,
        child: Scaffold(
          appBar: AppBar(),
          body: ListView(
            children: [
              ...filteredCurrencies.map(
                (e) => RegularCurrencyListItem(
                  currency: e,
                  selected: false,
                  swapableWith: null,
                  onTap: () => onSelectCurrency(e),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
