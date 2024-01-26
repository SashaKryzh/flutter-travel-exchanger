import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Currency extends Equatable {
  const Currency({
    required this.code,
  });

  final String code;

  String name(BuildContext context) {
    return code;
  }

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

  static const time = Currency(code: 'time');

  // For testing
  static const uah = Currency(code: 'UAH');
  static const pln = Currency(code: 'PLN');
  static const eur = Currency(code: 'EUR');
}
