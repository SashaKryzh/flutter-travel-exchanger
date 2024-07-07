import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  bool get isLight => theme.brightness == Brightness.light;
  bool get isDark => !isLight;

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  ModalRoute<Object>? get modalRoute => ModalRoute.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}

extension IterableX<T> on Iterable<T> {
  bool containsAny(Iterable<Object?> other) => other.any(contains);

  int get lastIndex => length - 1;

  Iterable<T> insertBetween(T separator) {
    if (isEmpty) return [];

    final result = <T>[];

    for (var i = 0; i < length; i++) {
      result.add(elementAt(i));

      if (i != lastIndex) {
        result.add(separator);
      }
    }

    return result;
  }
}

extension MaterialStateX on Iterable<WidgetState> {
  bool get isHovered => contains(WidgetState.hovered);
  bool get isFocused => contains(WidgetState.focused);
  bool get isPressed => contains(WidgetState.pressed);
  bool get isDragged => contains(WidgetState.dragged);
  bool get isSelected => contains(WidgetState.selected);
  bool get isScrolledUnder => contains(WidgetState.scrolledUnder);
  bool get isDisabled => contains(WidgetState.disabled);
  bool get isError => contains(WidgetState.error);
}

extension AnimationControllerX on AnimationController {
  void reforward() {
    reset();
    forward();
  }
}

extension NumberFormatX on NumberFormat {
  num? tryParse(String text) {
    try {
      return parse(text);
    } on FormatException {
      return null;
    }
  }
}

// ignore: avoid-dynamic
extension DynamicX on dynamic {
  T? asOrNull<T>() => this is T ? this as T : null;
}
