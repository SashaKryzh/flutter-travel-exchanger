import 'package:collection/collection.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/config/i18n/strings_providers.dart';
import 'package:travel_exchanger/domain/currencies_providers.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/popular_provider.dart';

part 'select_currency_providers.freezed.dart';
part 'select_currency_providers.g.dart';

@Riverpod(dependencies: [])
Currency selectCurrencyPageInitialCurrency(SelectCurrencyPageInitialCurrencyRef _) =>
    throw UnimplementedError();

@riverpod
List<Currency> searchCurrencies(
  SearchCurrenciesRef ref,
  String query, {
  bool Function(Currency currency)? filter,
}) {
  final popularCurrencies = ref.watch(popularCurrenciesProvider);

  var currencies = ref.watch(currenciesProvider).sortedBy((e) => e.displayCode());
  if (filter != null) {
    currencies = currencies.where(filter).toList();
  }

  query = query.trim();
  if (query.isEmpty) {
    return popularCurrencies.toList()
      ..addAll(currencies.where((e) => !popularCurrencies.contains(e)));
  }

  final t = ref.watch(tProvider);

  return currencies
      .where(
        (e) =>
            e.code.toLowerCase().contains(query.toLowerCase()) ||
            e.nameFromTranslations(t).toLowerCase().contains(query.toLowerCase()),
      )
      .toList();
}

@riverpod
List<Currency> selectCurrencyAllCurrencies(SelectCurrencyAllCurrenciesRef ref) {
  final currencies = ref.watch(currenciesProvider).where((e) => e != Currency.time).toList();
  currencies.sortBy((e) => e.code);
  return currencies;
}

typedef CurrencyMetadata = ({bool isSelected, Currency? swapableWith});

@Riverpod(dependencies: [SelectCurrencyNotifier])
CurrencyMetadata currencyMetadata(CurrencyMetadataRef ref, Currency currency) {
  final selectingFor = ref.watch(selectCurrencyNotifierProvider).selectingFor;
  final between = ref.watch(exchangeBetweenProvider);

  final isSelected = selectingFor == currency;
  final swapableWith = between.contains(currency) && !isSelected ? selectingFor : null;

  return (isSelected: isSelected, swapableWith: swapableWith);
}

@Riverpod(dependencies: [selectCurrencyPageInitialCurrency])
class SelectCurrencyNotifier extends _$SelectCurrencyNotifier {
  @override
  SelectCurrencyState build() {
    ref.listen(exchangeBetweenProvider, (prev, next) {
      if (!next.contains(state.selectingFor)) {
        state = state.copyWith(selectingFor: next.to1);
      }
    });

    final initialCurrency = ref.watch(selectCurrencyPageInitialCurrencyProvider);

    return SelectCurrencyState(selectingFor: initialCurrency);
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
