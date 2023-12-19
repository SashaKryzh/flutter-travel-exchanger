import 'package:flutter/material.dart';

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

  ModalRoute? get modalRoute => ModalRoute.of(this);

  FocusScopeNode get focusScope => FocusScope.of(this);

  ScaffoldState get scaffold => Scaffold.of(this);

  ScaffoldMessengerState get scaffoldMessenger => ScaffoldMessenger.of(this);
}

extension IterableExtensions<T> on Iterable<T> {
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

extension MaterialStateExtensions on Iterable<MaterialState> {
  bool get isHovered => contains(MaterialState.hovered);
  bool get isFocused => contains(MaterialState.focused);
  bool get isPressed => contains(MaterialState.pressed);
  bool get isDragged => contains(MaterialState.dragged);
  bool get isSelected => contains(MaterialState.selected);
  bool get isScrolledUnder => contains(MaterialState.scrolledUnder);
  bool get isDisabled => contains(MaterialState.disabled);
  bool get isError => contains(MaterialState.error);
}
