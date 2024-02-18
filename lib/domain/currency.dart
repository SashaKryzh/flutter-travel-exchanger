import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:travel_exchanger/config/i18n/strings.g.dart';
import 'package:travel_exchanger/utils/logger.dart';

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

  String nameFromTranslations(Translations t);

  String displayCode([BuildContext? context]);

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

  static const usd = MoneyCurrency('USD');
  static const eur = MoneyCurrency('EUR');
  static const time = TimeCurrency();
}

class MoneyCurrency extends Currency {
  const MoneyCurrency(super.code) : super._();

  @override
  String name(BuildContext context) {
    return nameFromTranslations(context.t);
  }

  @override
  String nameFromTranslations(Translations t) {
    final name = t.currencyNames[code];
    if (name == null) {
      logger.e('Missing currency name for $code');
    }
    return name ?? displayCode();
  }

  @override
  String displayCode([BuildContext? context]) {
    return code.toUpperCase();
  }
}

class TimeCurrency extends Currency {
  const TimeCurrency() : super._(_timeKey);

  static const _timeKey = 'TIME';
  static const _yourTime = 'Your Time';

  @override
  String name(BuildContext context) {
    return _yourTime;
  }

  @override
  String displayCode([BuildContext? context]) {
    return _yourTime;
  }

  @override
  String nameFromTranslations(Translations t) {
    return _yourTime;
  }
}
