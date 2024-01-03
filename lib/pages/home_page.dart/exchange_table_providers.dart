import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/converter_providers.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'exchange_table_providers.g.dart';

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
    final expanded = ref.read(exchangeTableExpandedRowsNotifierProvider).isNotEmpty;
    if (currentIndex == 0 || (expanded && currentIndex == 1)) {
      return false;
    }
    state = ExchangeValuesFrom.values[currentIndex - 1];
    return true;
  }
}

@riverpod
List<double> exchangeValues(ExchangeValuesRef ref) {
  final from = ref.watch(exchangeValuesFromNotifierProvider);
  final values = [from.value];
  for (var i = 0; i < 10; i++) {
    values.add(values.last + values.first);
  }
  return values;
}

class ExchangeTableExpandedRowId extends Equatable {
  const ExchangeTableExpandedRowId({
    required this.level,
    required this.index,
  });

  final int level;
  final int index;

  @override
  List<Object?> get props => [level, index];
}

@riverpod
class ExchangeTableExpandedRowsNotifier extends _$ExchangeTableExpandedRowsNotifier {
  @override
  Set<ExchangeTableExpandedRowId> build() {
    return {};
  }

  void expand({
    required int level,
    required int index,
  }) {
    final length = state.length;
    state = {...state, ExchangeTableExpandedRowId(level: level, index: index)};
    assert(state.length == length + 1, 'This row is already expanded');
  }

  void collapse() {
    state = state.take(state.length - 1).toSet();
  }
}

@riverpod
(double, double?) convertedValues(ConvertedValuesRef ref, double value) {
  final between = ref.watch(exchangeBetweenProvider);

  // final from = between.between.$1;
  final to1 = between.between.$2;
  final to2 = between.between.$3;

  final rate1 = (to1 as Currency).code == 'UAH' ? 9.8 : 1 / 9.8;

  final converted1 = value * rate1;
  final converted2 = to2 != null ? value * rate1 : null;

  return (converted1, converted2);
}

//
// =============================================================================
//

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
