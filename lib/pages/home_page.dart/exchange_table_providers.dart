import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/domain/value.dart';

part 'exchange_table_providers.g.dart';
part 'exchange_table_providers.freezed.dart';

enum ExchangeValuesFrom {
  v001(.01),
  v01(.1),
  v1(1),
  v10(10),
  v100(100),
  v1k(1000),
  v10k(10000),
  v100k(100000),
  v1m(1000000),
  v10m(10000000),
  v100m(100000000),
  v1b(1000000000),
  v10b(10000000000),
  v100b(100000000000),
  v1t(1000000000000);

  const ExchangeValuesFrom(this.value);

  final double value;

  int get maxExpandLevel {
    return ExchangeValuesFrom.values.indexOf(this) - 1;
  }

  double? step(int level) {
    final index = ExchangeValuesFrom.values.indexOf(this);
    final stepIndex = index - 1 - level;
    return stepIndex >= 0 ? ExchangeValuesFrom.values[index - 1 - level].value : null;
  }
}

@riverpod
class ExchangeValuesFromNotifier extends _$ExchangeValuesFromNotifier {
  @override
  ExchangeValuesFrom build() {
    return ExchangeValuesFrom.v1;
  }

  bool increase() {
    final currentIndex = ExchangeValuesFrom.values.indexOf(state);
    if (currentIndex == ExchangeValuesFrom.values.length - 1) {
      return false;
    }
    state = ExchangeValuesFrom.values[currentIndex + 1];
    return true;
  }

  bool decrease() {
    final currentIndex = ExchangeValuesFrom.values.indexOf(state);
    if (currentIndex == 0) {
      return false;
    }

    final expandedRowsState = ref.read(exchangeTableExpandedRowsProvider);
    final expandedLevel = expandedRowsState.rows.lastOrNull?.level ?? -1;
    final nextValuesFrom = ExchangeValuesFrom.values[currentIndex - 1];
    if (nextValuesFrom.maxExpandLevel < expandedLevel) {
      return false;
    }

    state = nextValuesFrom;
    return true;
  }
}

//
// =============================================================================
//

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
  factory ExchangeTableExpandedRowsState(
    Set<ExpandableRowState> rows,
  ) = _ExchangeTableExpandedRowsState;
}

@riverpod
class ExchangeTableExpandedRows extends _$ExchangeTableExpandedRows {
  @override
  ExchangeTableExpandedRowsState build() {
    return ExchangeTableExpandedRowsState({});
  }

  void expand({required int level, required int index}) {
    final length = state.rows.length;
    state = state.copyWith(
      rows: {...state.rows, ExpandableRowState(level: level, index: index)},
    );
    assert(state.rows.length == length + 1, 'This row is already expanded');
  }

  void collapse() {
    state = state.copyWith(
      rows: state.rows.take(state.rows.length - 1).toSet(),
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
