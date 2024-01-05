import 'package:flutter/material.dart';

sealed class Exchangeable {
  abstract final String code;

  String name(BuildContext context);
}

final class Currency extends Exchangeable {
  @override
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
  final code = 'time';

  @override
  String name(BuildContext context) {
    return 'Time';
  }
}
