import 'package:collection/collection.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/data/rates_repository.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rate.dart';
import 'package:travel_exchanger/utils/logger.dart';

part 'rates_providers.g.dart';

// TODO: watch rates updates when expired and returned new values from the API.
@riverpod
List<Rate> rates(RatesRef ref) {
  final rates = ref.watch(ratesRepositoryProvider).rates;
  return rates;
}

@riverpod
double rate(RateRef ref, Currency fromm, Currency to) {
  final rates = ref.watch(ratesProvider);

  final fromTo = rates.firstWhereOrNull((e) => e.base == fromm && e.target == to);
  if (fromTo != null) {
    return fromTo.rate;
  }

  final toFrom = rates.firstWhereOrNull((e) => e.base == to && e.target == fromm);
  if (toFrom != null) {
    return 1 / toFrom.rate;
  }

  try {
    final fromBase = rates.firstWhere((e) => e.target == fromm);
    final baseTo = rates.firstWhere((e) => e.base == fromBase.base && e.target == to);

    return 1 / fromBase.rate * baseTo.rate;
  } catch (e) {
    logger.e('Rate not found for $fromm $to');
    return 0;
  }
}
