import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/data/exchange_between_repository.dart';
import 'package:travel_exchanger/domain/currencies_provider.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'converter_providers.g.dart';

typedef Between = (Currency, Currency, Currency?);

class ExchangeBetweenState extends Equatable {
  const ExchangeBetweenState(this.between);

  final Between between;

  bool get isTwo => between.$3 == null;
  bool get isThree => !isTwo;
  int get length => isTwo ? 2 : 3;

  bool contains(Currency currency) =>
      between.$1 == currency || between.$2 == currency || between.$3 == currency;

  @override
  List<Object?> get props => [between];
}

@riverpod
class ExchangeBetween extends _$ExchangeBetween {
  @override
  ExchangeBetweenState build() {
    final storedBetween = ref.read(exchangeBetweenRepositoryProvider).getExchangeBetween();

    final initialBetween = storedBetween ?? (pln, uah, eur);

    return ExchangeBetweenState(initialBetween);
  }

  void addThird([Currency? currency]) {
    currency ??= eur;
    state = ExchangeBetweenState((state.between.$1, state.between.$2, currency));
    ref.read(exchangeBetweenRepositoryProvider).setExchangeBetween(state.between);
  }

  void removeThird() {
    state = ExchangeBetweenState((state.between.$1, state.between.$2, null));
    ref.read(exchangeBetweenRepositoryProvider).setExchangeBetween(state.between);
  }

  void swap(Currency from, Currency to) {
    Currency getNew(Currency current) {
      return current == from
          ? to
          : current == to
              ? from
              : current;
    }

    final c = state.between.$3;

    state = ExchangeBetweenState(
      (
        getNew(state.between.$1),
        getNew(state.between.$2),
        c != null ? getNew(c) : null,
      ),
    );

    ref.read(exchangeBetweenRepositoryProvider).setExchangeBetween(state.between);
  }
}
