import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'exchange_table_theme.tailor.dart';

@TailorMixin()
class ExchangeTableTheme extends ThemeExtension<ExchangeTableTheme>
    with _$ExchangeTableThemeTailorMixin {
  const ExchangeTableTheme({
    required this.borderColor,
    required this.fromColor,
    required this.toColor,
  });

  final Color borderColor;
  final Color fromColor;
  final Color toColor;
}
