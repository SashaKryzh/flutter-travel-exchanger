import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class Currency extends Equatable {
  const Currency._(this.code);

  factory Currency(String code) {
    if (code == Currency.time.code) {
      return Currency.time;
    } else {
      return MoneyCurrency(code);
    }
  }

  final String code;

  String name(BuildContext context);

  bool get isMoney => this is MoneyCurrency;
  bool get isTime => this is TimeCurrency;

  @override
  List<Object?> get props => [code];

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      json['code'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
      };

  static const time = TimeCurrency();

  // For testing
  static final uah = Currency('UAH');
  static final pln = Currency('PLN');
  static final eur = Currency('EUR');
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
