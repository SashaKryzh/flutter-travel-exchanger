import 'package:equatable/equatable.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:travel_exchanger/domain/currencies_repository.dart';
import 'package:travel_exchanger/domain/currency.dart';

part 'converter_providers.g.dart';

class ExchangeBetweenState extends Equatable {
  const ExchangeBetweenState(this.between);

  final (Exchangeable, Exchangeable, Exchangeable?) between;

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

  void swap(Exchangeable from, Exchangeable to) {
    Exchangeable getNew(Exchangeable current) {
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
