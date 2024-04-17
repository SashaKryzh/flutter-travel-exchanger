import 'package:auto_size_text/auto_size_text.dart';
import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/app_events.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/onboarding.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/domain/value.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_values_from.dart';

part 'exchange_table_providers.g.dart';
part 'exchange_table_providers.freezed.dart';

@riverpod
List<double> exchangeValues(ExchangeValuesRef ref) {
  final from = ref.watch(exchangeValuesFromNotifierProvider);
  final values = [from.value];
  for (var i = 0; i < 10; i++) {
    values.add(values.last + values.first);
  }
  return values;
}

List<double>? betweenValues(ExchangeValuesFrom from, double value, int level) {
  final step = from.step(level);

  if (step == null) {
    return null;
  }

  final values = [value + step];
  for (var i = 0; i < 8; i++) {
    values.add(values.last + step);
  }

  return values;
}

//
// =============================================================================
//

class ExpandableRowState extends Equatable {
  const ExpandableRowState({
    required this.level,
    required this.index,
  });

  final int level;
  final int index;

  @override
  List<Object?> get props => [level, index];

  ExpandableRowState copyWith({
    int? level,
    int? index,
  }) {
    return ExpandableRowState(
      level: level ?? this.level,
      index: index ?? this.index,
    );
  }
}

@freezed
class ExchangeTableExpandedRowsState with _$ExchangeTableExpandedRowsState {
  const ExchangeTableExpandedRowsState._();
  factory ExchangeTableExpandedRowsState(
    Set<ExpandableRowState> rows,
  ) = _ExchangeTableExpandedRowsState;

  int? get lastExpandedLevel {
    return rows.lastOrNull?.level;
  }

  int get lastShownLevel {
    return rows.isNotEmpty ? rows.last.level + 1 : 0;
  }
}

@riverpod
class ExchangeTableExpandedRows extends _$ExchangeTableExpandedRows {
  @override
  ExchangeTableExpandedRowsState build() {
    return ExchangeTableExpandedRowsState({});
  }

  void expand({required int level, required int index}) {
    Onboarding.guard(
      () {
        final length = state.rows.length;
        state = state.copyWith(
          rows: {...state.rows, ExpandableRowState(level: level, index: index)},
        );
        assert(state.rows.length == length + 1, 'This row is already expanded');
      },
      event: const ExpandRowEvent(),
    );
  }

  void collapse() {
    Onboarding.guard(
      () {
        state = state.copyWith(
          rows: state.rows.take(state.rows.length - 1).toSet(),
        );
      },
      event: const CollapseRowEvent(),
    );
  }

  void collapseAll() {
    state = state.copyWith(
      rows: {},
    );
  }
}

//
// =============================================================================
//

@riverpod
(Value, Value?) convertedValues(ConvertedValuesRef ref, double value) {
  final between = ref.watch(exchangeBetweenProvider);

  final from = between.from;
  final to1 = between.to1;
  final to2 = between.to2;

  final rate1 = ref.watch(rateProvider(from, to1));
  final rate2 = to2 != null ? ref.watch(rateProvider(from, to2)) : null;

  final converted1 = value * rate1.rate;
  final converted2 = rate2 != null ? value * rate2.rate : null;

  return (
    Value(converted1, to1),
    converted2 != null ? Value(converted2, to2!) : null,
  );
}

//
// =============================================================================
//

@riverpod
AutoSizeGroup autoSizeGroup(AutoSizeGroupRef ref, int level) {
  return AutoSizeGroup();
}
