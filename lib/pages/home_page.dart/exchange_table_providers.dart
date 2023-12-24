import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'exchange_table_providers.g.dart';

enum ExchangeValuesFrom {
  v01(.1),
  v1(1),
  v10(10),
  v100(100),
  v1k(1000),
  v10k(10000);

  const ExchangeValuesFrom(this.value);

  final double value;
}

@riverpod
class ExchangeValuesFromNotifier extends _$ExchangeValuesFromNotifier {
  @override
  ExchangeValuesFrom build() {
    return ExchangeValuesFrom.v1;
  }

  void increase() {
    final currentIndex = ExchangeValuesFrom.values.indexOf(state);
    if (currentIndex == ExchangeValuesFrom.values.length - 1) {
      return;
    }
    state = ExchangeValuesFrom.values[currentIndex + 1];
  }

  void decrease() {
    final currentIndex = ExchangeValuesFrom.values.indexOf(state);
    if (currentIndex == 0) {
      return;
    }
    state = ExchangeValuesFrom.values[currentIndex - 1];
  }
}

@riverpod
List<double> exchangeValues(ExchangeValuesRef ref) {
  final from = ref.watch(exchangeValuesFromNotifierProvider);
  final values = [from.value];
  for (var i = 0; i < 9; i++) {
    values.add(values.last + values.first);
  }
  return values;
}
