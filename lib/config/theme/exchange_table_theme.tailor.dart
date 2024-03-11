// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element, unnecessary_cast

part of 'exchange_table_theme.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ExchangeTableThemeTailorMixin on ThemeExtension<ExchangeTableTheme> {
  Color get borderColor;
  Color get fromColor;
  Color get toColor;

  @override
  ExchangeTableTheme copyWith({
    Color? borderColor,
    Color? fromColor,
    Color? toColor,
  }) {
    return ExchangeTableTheme(
      borderColor: borderColor ?? this.borderColor,
      fromColor: fromColor ?? this.fromColor,
      toColor: toColor ?? this.toColor,
    );
  }

  @override
  ExchangeTableTheme lerp(
      covariant ThemeExtension<ExchangeTableTheme>? other, double t) {
    if (other is! ExchangeTableTheme) return this as ExchangeTableTheme;
    return ExchangeTableTheme(
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      fromColor: Color.lerp(fromColor, other.fromColor, t)!,
      toColor: Color.lerp(toColor, other.toColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExchangeTableTheme &&
            const DeepCollectionEquality()
                .equals(borderColor, other.borderColor) &&
            const DeepCollectionEquality().equals(fromColor, other.fromColor) &&
            const DeepCollectionEquality().equals(toColor, other.toColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(borderColor),
      const DeepCollectionEquality().hash(fromColor),
      const DeepCollectionEquality().hash(toColor),
    );
  }
}

extension ExchangeTableThemeBuildContextProps on BuildContext {
  ExchangeTableTheme get exchangeTableTheme =>
      Theme.of(this).extension<ExchangeTableTheme>()!;
  Color get borderColor => exchangeTableTheme.borderColor;
  Color get fromColor => exchangeTableTheme.fromColor;
  Color get toColor => exchangeTableTheme.toColor;
}
