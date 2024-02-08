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
List<Currency> recentlyUsed(RecentlyUsedRef ref) {
  // Subscribe to changes
  ref.watch(recentlyUsedStreamProvider);
  return ref.watch(recentlyUsedCurrencyRepositoryProvider).recentlyUsed;
}

/// Returns recently used currencies that are not in [exchangeBetweenProvider]
@riverpod
List<Currency> filteredRecentlyUsed(FilteredRecentlyUsedRef ref, {int? limit}) {
  assert(limit == null || limit >= 0, 'limit should be greater than 0');

  final recentlyUsed = ref.watch(recentlyUsedProvider);
  final between = ref.watch(exchangeBetweenProvider);

  var filtered = recentlyUsed.where((e) => !between.contains(e));
  if (limit != null) filtered = filtered.take(limit);

  return filtered.toList();
}
