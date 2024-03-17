import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/utils/logger.dart';

String get decimalSeparator => NumberFormat().symbols.DECIMAL_SEP;

NumberFormat moneyFormatter({int decimalDigits = 2}) => NumberFormat.simpleCurrency(
      name: '',
      decimalDigits: decimalDigits,
    );

String formatMoney(double value, {int decimalDigits = 2}) {
  return moneyFormatter(decimalDigits: decimalDigits).format(value);
}

class CurrencyInputFormatter extends TextInputFormatter {
  const CurrencyInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    // Intl.defaultLocale = 'uk_UA';

    logger.d(
      'CurrencyInputFormatter: oldValue = "${oldValue.text}"; newValue = "${newValue.text}"',
    );

    var newText = newValue.text;

    if (newText.isEmpty) {
      return newValue;
    }

    // Replace entered decimal separator with the default one.
    if ((newText.length == 1 || newText.length > oldValue.text.length) &&
        ',.'.contains(newText.characters.last)) {
      newText = newText.substring(0, newText.length - 1) + decimalSeparator;
    }

    // More than one decimal separator.
    if (newText.indexOf(decimalSeparator) != newText.lastIndexOf(decimalSeparator)) {
      _logNewText(oldValue.text);
      return oldValue;
    }

    // Contains space.
    if (newText.contains(' ')) {
      _logNewText(oldValue.text);
      return oldValue;
    }

    final decimalSeparatorInText = newText.contains(decimalSeparator);
    final decimalDigits =
        decimalSeparatorInText ? newText.length - newText.indexOf(decimalSeparator) - 1 : 0;

    if (newText.length == 1 && decimalSeparatorInText) {
      final zeroWithSeparatorText = '0$decimalSeparator';
      _logNewText(zeroWithSeparatorText);
      return newValue.copyWith(
        text: zeroWithSeparatorText,
        selection: const TextSelection.collapsed(offset: 2),
      );
    }

    // More than two decimal digits.
    if (decimalDigits > 2) {
      _logNewText(oldValue.text);
      return oldValue;
    }

    final value = moneyFormatter().tryParse(newText)?.toDouble();
    if (value == null) {
      _logNewText(oldValue.text);
      return oldValue;
    }
    newText = formatMoney(value, decimalDigits: decimalDigits);
    // Add decimal separator if it was removed.
    if (decimalDigits == 0 && decimalSeparatorInText) {
      newText += decimalSeparator;
    }

    _logNewText(newText);
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  void _logNewText(String newText) {
    logger.d('CurrencyInputFormatter: newText = "$newText"');
  }
}
