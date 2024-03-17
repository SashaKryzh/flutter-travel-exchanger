import 'package:flutter/services.dart';
import 'package:travel_exchanger/domain/value.dart';
import 'package:travel_exchanger/utils/logger.dart';

String formatTimeWhileNotEditing(double value) {
  return TimeValue(value).format();
}

class TimeInputFormatter extends TextInputFormatter {
  const TimeInputFormatter();

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    logger.d(
      'TimeInputFormatter: oldValue = "${oldValue.text}"; newValue = "${newValue.text}"',
    );

    var newText = newValue.text;

    if (newText.isEmpty) {
      return newValue;
    }

    // Text contains anything but digits.
    if (newText.contains(RegExp(r'[^0-9]'))) {
      return oldValue;
    }

    return newValue;
  }
}
