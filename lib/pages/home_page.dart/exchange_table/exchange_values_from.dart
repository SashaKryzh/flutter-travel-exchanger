import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/app_events.dart';
import 'package:travel_exchanger/domain/onboarding.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table_providers.dart';
import 'package:travel_exchanger/utils/time_currency_utils.dart';

part 'exchange_values_from.g.dart';

enum ExchangeValuesFrom {
  v001(.01, 1 / kSecondsInHour),
  v01(.1, 10 / kSecondsInHour),
  v1(1, 1 / kMinutesInHour),
  v10(10, 10 / kMinutesInHour),
  v100(100, 1),
  v1k(1000, 10),
  v10k(10000, 1.0 * kHoursInDay),
  v100k(100000, 10.0 * kHoursInDay),
  v1m(1000000, 1.0 * kHoursInMonth),
  v10m(10000000, 10.0 * kHoursInMonth),
  v100m(100000000, 1.0 * kHoursInYear),
  v1b(1000000000, 10.0 * kHoursInYear),
  v10b(10000000000, 100.0 * kHoursInYear),
  v100b(100000000000, 1000.0 * kHoursInYear),
  v1t(1000000000000, 10000.0 * kHoursInYear);

  const ExchangeValuesFrom(this.value, this.timeValue);

  final double value;
  final double timeValue;

  int get maxExpandLevel {
    return ExchangeValuesFrom.values.indexOf(this) - 1;
  }

  double? step({required int level, required bool isTime}) {
    final index = ExchangeValuesFrom.values.indexOf(this);
    final stepIndex = index - 1 - level;
    if (stepIndex < 0) {
      return null;
    }
    final step = ExchangeValuesFrom.values[index - 1 - level];
    return isTime ? step.timeValue : step.value;
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

    var result = false;
    Onboarding.guard(
      () {
        state = newState;
        result = true;
      },
      event: const IncreaseValuesFromEvent(),
    );

    return result;
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

    var result = false;
    Onboarding.guard(
      () {
        state = nextValuesFrom;
        result = true;
      },
      event: const DecreaseValuesFromEvent(),
    );

    return result;
  }
}
