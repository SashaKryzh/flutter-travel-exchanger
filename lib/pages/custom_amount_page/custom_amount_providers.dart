import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/currencies_provider.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';

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
    required Currency from,
    required Values values,
  }) = _CustomAmountState;

  double get fromValue => values.$1.$1 == from
      ? values.$1.$2
      : values.$2.$1 == from
          ? values.$2.$2
          : values.$3!.$2;

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

    return CustomAmountState(
      from: from,
      values: _calculateValues(from: from, amount: 1),
    );
  }

  void setAmount(double amount) {
    state = state.copyWith(
      values: _calculateValues(amount: amount),
    );
  }

  void setFrom(Currency from) {
    state = state.copyWith(
      from: from,
      values: _calculateValues(from: from, amount: state.valueFor(from)),
    );
  }

  Values _calculateValues({Currency? from, double? amount}) {
    final between = ref.read(exchangeBetweenProvider);
    final from1 = from ?? state.from;
    final amount1 = amount ?? state.fromValue;

    double convert(Currency to) {
      if (to == from1) {
        return amount1;
      }

      final rate = ref.read(rateProvider(from1, to));
      return amount1 * rate;
    }

    final third = between.to2;

    return (
      (between.from, convert(between.from)),
      (between.to1, convert(between.to1)),
      third != null ? (third, convert(third)) : null,
    );
  }
}
