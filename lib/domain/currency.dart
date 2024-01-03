import 'package:flutter/material.dart';

sealed class Exchangeable {
  String name(BuildContext context);
}

final class Currency extends Exchangeable {
  final String code;
  final String symbol;

  Currency({
    required this.code,
    required this.symbol,
  });

  @override
  String name(BuildContext context) {
    return code;
  }
}

final class Time extends Exchangeable {
  @override
  String name(BuildContext context) {
    return 'Time';
  }
}
