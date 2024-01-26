import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';

part 'currencies_provider.g.dart';

@riverpod
List<Currency> currencies(CurrenciesRef ref) {
  final rates = ref.watch(ratesProvider);
  return (rates.map((e) => e.target).toList() + [Currency.time]).toSet().toList();
}

extension CurrenciesX on List<Currency> {
  Currency getCurrencyFromCode(String code) {
    return firstWhere((e) => e.code == code);
  }
}
