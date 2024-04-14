import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/currencies_providers.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/domain/value.dart';

part 'custom_amount_providers.freezed.dart';
part 'custom_amount_providers.g.dart';

typedef Values = (
  (Currency, double),
  (Currency, double),
  (Currency, double)?,
);

@freezed
class CustomAmountState with _$CustomAmountState {
  const CustomAmountState._();

  factory CustomAmountState({
    required int fromIndex,
    required Values values,
  }) = _CustomAmountState;

  Currency get fromCurrency => currencyFor(fromIndex);
  double get fromValue => valueFor(fromCurrency);

  Currency currencyFor(int index) {
    return index == 0
        ? values.$1.$1
        : index == 1
            ? values.$2.$1
            : values.$3!.$1;
  }

  double valueFor(Currency currency) {
    return values.$1.$1 == currency
        ? values.$1.$2
        : values.$2.$1 == currency
            ? values.$2.$2
            : values.$3!.$2;
  }
}

@riverpod
class CustomAmountConverter extends _$CustomAmountConverter {
  @override
  CustomAmountState build(String fromCode) {
    final from = ref.watch(currenciesProvider).getCurrencyFromCode(fromCode);
    var fromIndex = ref.read(exchangeBetweenProvider).currencies.indexOf(from);
    if (fromIndex == -1) {
      fromIndex = 0;
    }

    ref.listen(
      customAmountTimeContainerProvider,
      (prev, curr) {
        if (prev != curr) _recalculate();
      },
    );

    ref.listen(
      exchangeBetweenProvider,
      (prev, curr) {
        if (prev != curr) _recalculate();
      },
    );

    return CustomAmountState(
      fromIndex: fromIndex,
      values: _calculateValues(from: from, amount: 1),
    );
  }

  void setAmount(double amount) {
    state = state.copyWith(
      values: _calculateValues(amount: amount),
    );
  }

  void setFrom(int index) {
    state = state.copyWith(
      fromIndex: index,
      values: _calculateValues(
        from: state.currencyFor(index),
        amount: state.valueFor(state.currencyFor(index)),
      ),
    );
  }

  void _recalculate() {
    state = state.copyWith(
      values: _calculateValues(),
    );
  }

  Values _calculateValues({Currency? from, double? amount}) {
    final between = ref.read(exchangeBetweenProvider);
    final from1 = from ?? state.fromCurrency;
    final amount1 = amount ?? state.fromValue;

    final double amountAdjusted;
    if (from1.isTime) {
      amountAdjusted = switch (ref.read(customAmountTimeContainerProvider)) {
        CustomAmountTimeFrom.minutes => TimeValue.fromMinutes(amount1).value,
        CustomAmountTimeFrom.hours => amount1,
        CustomAmountTimeFrom.days => TimeValue.fromDays(amount1).value,
      };
    } else {
      amountAdjusted = amount1;
    }

    double convert(Currency to) {
      if (to == from1) {
        return amount1;
      }

      final rate = ref.read(rateProvider(from1, to));
      return amountAdjusted * rate.rate;
    }

    final third = between.to2;

    return (
      (between.from, convert(between.from)),
      (between.to1, convert(between.to1)),
      third != null ? (third, convert(third)) : null,
    );
  }
}

@riverpod
class CustomAmountTimeContainer extends _$CustomAmountTimeContainer {
  @override
  CustomAmountTimeFrom build() {
    return CustomAmountTimeFrom.hours;
  }

  void setFrom(CustomAmountTimeFrom from) {
    state = from;
  }
}

enum CustomAmountTimeFrom { minutes, hours, days }
