import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/currencies_provider.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'converter_providers.g.dart';

class ExchangeBetweenState extends Equatable {
  const ExchangeBetweenState(this.between);

  final (Currency, Currency, Currency?) between;

  bool get isTwo => between.$3 == null;
  bool get isThree => !isTwo;

  @override
  List<Object?> get props => [between];
}

@riverpod
class ExchangeBetween extends _$ExchangeBetween {
  @override
  ExchangeBetweenState build() {
    return ExchangeBetweenState(
      (pln, uah, null),
    );
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
  }
}
