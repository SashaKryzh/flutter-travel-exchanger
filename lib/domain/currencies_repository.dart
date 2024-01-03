import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'currencies_repository.g.dart';

final pln = Currency(code: 'PLN', symbol: '');
final eur = Currency(code: 'EUR', symbol: '');
final uah = Currency(code: 'UAH', symbol: '');

@riverpod
CurrenciesRepository currenciesRepository(CurrenciesRepositoryRef ref) {
  return CurrenciesRepository();
}

class CurrenciesRepository {
  Future<List<Currency>> getCurrencies() async {
    return [
      pln,
      eur,
      uah,
    ];
  }
}
