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
}
