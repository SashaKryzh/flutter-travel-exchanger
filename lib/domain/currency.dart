import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class Currency extends Equatable {
  const Currency._(this.code);

  factory Currency({
    required String code,
  }) {
    if (code == Currency.time.code) {
      return Currency.time;
    } else {
      return MoneyCurrency(code);
    }
  }

  final String code;

  String name(BuildContext context);

  @override
  List<Object?> get props => [code];

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      code: json['code'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
      };

  static const time = TimeCurrency();

  // For testing
  static final uah = Currency(code: 'UAH');
  static final pln = Currency(code: 'PLN');
  static final eur = Currency(code: 'EUR');
}

class MoneyCurrency extends Currency {
  const MoneyCurrency(super.code) : super._();

  @override
  String name(BuildContext context) {
    return code;
  }

  @override
  List<Object?> get props => [code];
}

class TimeCurrency extends Currency {
  const TimeCurrency() : super._('time');

  @override
  String name(BuildContext context) {
    return 'Time';
  }
}
