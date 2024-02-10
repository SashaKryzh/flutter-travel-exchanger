import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/currencies_providers.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';

part 'select_currency_providers.freezed.dart';
part 'select_currency_providers.g.dart';

@riverpod
List<Currency> searchCurrencies(
  SearchCurrenciesRef ref,
  String query, {
  bool Function(Currency currency)? filter,
}) {
  var currencies = ref.watch(currenciesProvider);
  if (filter != null) {
    currencies = currencies.where(filter).toList();
  }

  query = query.trim();
  if (query.isEmpty) {
    return currencies;
  }

  return currencies.where((e) => e.code.toLowerCase().contains(query.toLowerCase())).toList();
}

@riverpod
List<Currency> selectCurrencyAllCurrencies(SelectCurrencyAllCurrenciesRef ref) {
  final currencies = ref.watch(currenciesProvider);
  currencies.remove(Currency.time);
  currencies.sortBy((e) => e.code);
  return currencies;
}

@riverpod
class SelectCurrencyNotifier extends _$SelectCurrencyNotifier {
  @override
  SelectCurrencyState build(Currency selectingFor) {
    ref.listen(exchangeBetweenProvider, (prev, next) {
      if (!next.contains(state.selectingFor)) {
        state = state.copyWith(selectingFor: next.to1);
      }
    });

    return SelectCurrencyState(selectingFor: selectingFor);
  }

  void selectFor(Currency currency) {
    state = SelectCurrencyState(selectingFor: currency);
  }
}

@freezed
class SelectCurrencyState with _$SelectCurrencyState {
  factory SelectCurrencyState({
    required Currency selectingFor,
  }) = _SelectCurrencyState;
}
