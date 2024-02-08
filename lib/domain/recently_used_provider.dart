import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/data/recently_used_currency_repository.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';

part 'recently_used_provider.g.dart';

@riverpod
Stream<List<Currency>> recentlyUsedStream(RecentlyUsedStreamRef ref) {
  return ref.watch(recentlyUsedCurrencyRepositoryProvider).recentlyUsedStream;
}

@riverpod
List<Currency> recentlyUsed(RecentlyUsedRef ref, {int limit = 5}) {
  assert(limit > 0, 'limit should be greater than 0');

  // Subscribe to changes
  ref.watch(recentlyUsedStreamProvider);

  final recentlyUsed = ref.watch(recentlyUsedCurrencyRepositoryProvider).recentlyUsed;
  final between = ref.watch(exchangeBetweenProvider);

  final filtered = recentlyUsed.where((e) => !between.contains(e)).take(limit).toList();

  return filtered;
}
