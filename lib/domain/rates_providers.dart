import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/data/rates_repository.dart';
import 'package:travel_exchanger/data/time_rate_repository.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rate.dart';
import 'package:travel_exchanger/utils/logger.dart';
import 'package:travel_exchanger/utils/riverpod_extensions.dart';

part 'rates_providers.g.dart';

@riverpod
RatesData rates(RatesRef ref) {
  ref.watch(ratesStreamProvider);

  final rates = ref.watch(ratesRepositoryProvider).ratesData;
  final timeRate = ref.watch(timeRateDataProvider)?.toRate();

  final newData = rates.copyWith(
    rates: [
      ...rates.rates,
      if (timeRate != null) timeRate,
    ],
  );

  return newData;
}

@riverpod
Stream<RatesData> ratesStream(RatesStreamRef ref) {
  return ref.watch(ratesRepositoryProvider).ratesDataStream;
}

@riverpod
Future<RatesDataTimestamps> ratesDataTimestamps(RatesDataTimestampsRef ref) async {
  return ref.watch(ratesRepositoryProvider).getTimestamps();
}

@riverpod
Stream<TimeRateData?> timeRateDataStream(TimeRateDataStreamRef ref) {
  ref.cacheFor(const Duration(minutes: 5));
  return ref.watch(timeRateRepositoryProvider).timeRateDataStream;
}

@riverpod
TimeRateData? timeRateData(TimeRateDataRef ref) {
  ref.watch(timeRateDataStreamProvider);
  return ref.watch(timeRateRepositoryProvider).data;
}

@riverpod
RateForData rate(RateRef ref, Currency fromm, Currency to) {
  if (fromm == to) {
    return const RateForData(1, RateSource.api);
  }

  final ratesData = ref.watch(ratesProvider);
  final rates = ratesData.rates.sortedCustomFirst();

  // from -> to
  final fromTo = rates.fromTo(fromm, to);
  if (fromTo != null && fromTo.source.isCustom) {
    // from -> is custom
    return RateForData(fromTo.rate, fromTo.source);
  } else {
    // to -> from
    final toFrom = rates.fromTo(to, fromm);
    if (toFrom != null && toFrom.source.isCustom) {
      // to -> from is custom
      return RateForData(1 / toFrom.rate, toFrom.source);
    } else if (fromTo != null) {
      // from -> to is not null
      return RateForData(fromTo.rate, fromTo.source);
    } else if (toFrom != null) {
      // to -> from is not null
      return RateForData(1 / toFrom.rate, toFrom.source);
    }
  }

  // We should't use custom rates for indirect conversions
  rates.removeWhere((e) => e.source == RateSource.custom && !e.from.isTime);

  try {
    if ([fromm, to].contains(Currency.time)) {
      final timeRate = rates.firstWhere((e) => e.from.isTime);
      final baseTimeTo = rates.fromTo(ratesData.base, timeRate.to);

      if (fromm == Currency.time) {
        final baseTo = rates.fromTo(ratesData.base, to);
        return RateForData(
          timeRate.rate * 1 / baseTimeTo!.rate * baseTo!.rate,
          RateSource.custom,
        );
      } else {
        final baseFrom = rates.fromTo(ratesData.base, fromm);
        return RateForData(
          1 / baseFrom!.rate * baseTimeTo!.rate / timeRate.rate,
          RateSource.custom,
        );
      }
    } else {
      final baseFrom = rates.fromTo(ratesData.base, fromm);
      final baseTo = rates.fromTo(ratesData.base, to);

      return RateForData(1 / baseFrom!.rate * baseTo!.rate, RateSource.api);
    }
  } catch (e, stackTrace) {
    logger.e('Rate not found for $fromm -> $to', error: e, stackTrace: stackTrace);
    return const RateForData(0, RateSource.api);
  }
}

extension on List<Rate> {
  Rate? fromTo(Currency from, Currency to) {
    return firstWhereOrNull((e) => e.from == from && e.to == to);
  }

  List<Rate> sortedCustomFirst() {
    return [...this]..sort((a, b) => switch ((a.source, b.source)) {
          (RateSource.custom, RateSource.api) => -1,
          (RateSource.api, RateSource.custom) => 1,
          _ => 0,
        });
  }
}

class RateForData extends Equatable {
  const RateForData(this.rate, this.source);

  final double rate;
  final RateSource source;

  @override
  List<Object?> get props => [rate, source];
}
