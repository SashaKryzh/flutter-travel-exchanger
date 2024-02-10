import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/data/exchange_between_repository.dart';
import 'package:travel_exchanger/data/recently_used_currency_repository.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/popular_provider.dart';
import 'package:travel_exchanger/domain/recently_used_provider.dart';

part 'exchange_between.freezed.dart';
part 'exchange_between.g.dart';

@riverpod
class ExchangeBetween extends _$ExchangeBetween {
  @override
  Between build() {
    ref.listenSelf((previous, next) {
      if (previous != next) {
        _storeBetween(next);
        if (previous != null) {
          _storeRecentlyUsed(previous, next);
        }
      }
    });

    final storedBetween = ref.read(exchangeBetweenRepositoryProvider).between;

    final initialBetween = storedBetween ??
        Between(
          Currency.pln,
          Currency.uah,
          null,
          showTo2: false,
        );

    return initialBetween;
  }

  void showThird([Currency? currency]) {
    currency ??= state.to2;

    if (currency == null || state.contains(currency)) {
      currency = ref.read(recentlyUsedProvider).firstWhereOrNull((e) => !state.contains(e));
      currency ??= ref.read(popularCurrenciesProvider).firstWhereOrNull((e) => !state.contains(e));
      currency ??= Currency.eur;
    }

    state = state.copyWith(to2_: currency, showTo2: true);
  }

  void hideThird() {
    state = state.copyWith(showTo2: false);
  }

  void swap(Currency from, Currency to) {
    Currency getNew(Currency current) {
      return current == from
          ? to
          : current == to
              ? from
              : current;
    }

    var to2 = state.to2;
    if (state.showTo2 && to2 != null) {
      to2 = getNew(to2);
    }

    state = state.copyWith(
      from: getNew(state.from),
      to1: getNew(state.to1),
      to2_: to2,
    );
  }

  Future<void> _storeBetween(Between between) async {
    await ref.read(exchangeBetweenRepositoryProvider).setExchangeBetween(between);
  }

  Future<void> _storeRecentlyUsed(Between prev, Between next) async {
    final prevCurrencies = [...prev.currencies];
    prevCurrencies.removeWhere((e) => next.contains(e));
    final currency = prevCurrencies.firstOrNull;
    if (currency != null) {
      await ref.read(recentlyUsedCurrencyRepositoryProvider).add(currency);
    }
  }
}

@freezed
class Between with _$Between {
  const Between._();

  factory Between(
    Currency from,
    Currency to1,
    @protected Currency? to2_, {
    required bool showTo2,
  }) = _Between;

  factory Between.fromJson(Map<String, dynamic> json) => _$BetweenFromJson(json);

  Currency? get to2 => showTo2 ? to2_ : null;

  bool get isTwo => to2 == null;
  bool get isThree => !isTwo;

  List<Currency> get currencies => [from, to1, if (to2 != null) to2!];
  int get length => currencies.length;

  bool contains(Currency currency) => currencies.contains(currency);
}
