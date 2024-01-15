import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/currencies_provider.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'select_currency_providers.g.dart';

@riverpod
List<Currency> searchCurrencies(SearchCurrenciesRef ref, String query) {
  final currencies = ref.watch(currenciesProvider);

  query = query.trim();

  if (query.isEmpty) {
    return currencies;
  }

  return currencies.where((e) => e.code.toLowerCase().contains(query.toLowerCase())).toList();
}
