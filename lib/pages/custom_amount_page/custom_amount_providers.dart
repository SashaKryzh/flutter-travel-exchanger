import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/converter_providers.dart';
import 'package:travel_exchanger/domain/currencies_repository.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'custom_amount_providers.freezed.dart';
part 'custom_amount_providers.g.dart';

typedef Values = (
  (Exchangeable, double),
  (Exchangeable, double),
  (Exchangeable, double)?,
);

@freezed
class CustomAmountState with _$CustomAmountState {
  const CustomAmountState._();

  factory CustomAmountState({
    required Exchangeable from,
    required Values values,
  }) = _CustomAmountState;

  double get fromValue => values.$1.$1 == from
      ? values.$1.$2
      : values.$2.$1 == from
          ? values.$2.$2
          : values.$3!.$2;

  double valueFor(Exchangeable exchangeable) {
    return values.$1.$1 == exchangeable
        ? values.$1.$2
        : values.$2.$1 == exchangeable
            ? values.$2.$2
            : values.$3!.$2;
  }
}

@riverpod
class CustomAmountConverter extends _$CustomAmountConverter {
  @override
  CustomAmountState build(String fromCode) {
    final from = ref.watch(currenciesRepositoryProvider).getCurrencyFromCode(fromCode);

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

  void setFrom(Exchangeable from) {
    state = state.copyWith(
      from: from,
      values: _calculateValues(from: from, amount: state.valueFor(from)),
    );
  }

  Values _calculateValues({Exchangeable? from, double? amount}) {
    final between = ref.read(exchangeBetweenProvider).between;
    final from1 = from ?? state.from;
    final amount1 = amount ?? state.fromValue;

    double convert(Exchangeable to) {
      if (to == from1) {
        return amount1;
      }

      final rate = (to as Currency).code == 'UAH' ? 9.8 : 1 / 9.8;
      return amount1 * rate;
    }

    final third = between.$3;

    return (
      (between.$1, convert(between.$1)),
      (between.$2, convert(between.$2)),
      third != null ? (third, convert(third)) : null,
    );
  }
}
