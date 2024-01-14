import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';

part 'currencies_provider.g.dart';

final pln = Currency(code: 'PLN');
final uah = Currency(code: 'UAH');

@riverpod
List<Currency> currencies(CurrenciesRef ref) {
  final rates = ref.watch(ratesProvider);
  return rates.map((e) => Currency(code: e.target)).toSet().toList();
}

extension CurrenciesX on List<Currency> {
  Currency getCurrencyFromCode(String code) {
    return firstWhere((e) => e.code == code);
  }
}
