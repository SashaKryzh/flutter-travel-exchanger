import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';

part 'currencies_provider.g.dart';

@riverpod
List<Currency> currencies(CurrenciesRef ref) {
  final ratesData = ref.watch(ratesProvider);
  final currencies = ratesData.rates.map((e) => e.to).toList()..add(Currency.time);
  return currencies.toSet().toList();
}

extension CurrenciesX on List<Currency> {
  Currency getCurrencyFromCode(String code) {
    return firstWhere((e) => e.code == code);
  }
}
