import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'popular_provider.g.dart';

@riverpod
List<Currency> popularCurrencies(PopularCurrenciesRef ref) {
  return const [
    MoneyCurrency('EUR'),
    MoneyCurrency('USD'),
    MoneyCurrency('GBP'),
    MoneyCurrency('JPY'),
    MoneyCurrency('CNY'),
  ];
}
