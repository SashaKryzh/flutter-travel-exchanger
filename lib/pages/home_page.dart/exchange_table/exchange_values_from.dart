import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table_providers.dart';

part 'exchange_values_from.g.dart';

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
    return ExchangeValuesFrom.v10;
  }

  bool increase() {
    final currentIndex = ExchangeValuesFrom.values.indexOf(state);
    if (currentIndex == ExchangeValuesFrom.values.length - 1) {
      return false;
    }
    final newState = ExchangeValuesFrom.values.elementAtOrNull(currentIndex + 1);
    if (newState == null) {
      return false;
    }
    state = newState;
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
