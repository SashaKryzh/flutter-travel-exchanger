import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_exchanger/utils/logger.dart';

class ReplaceFormatter extends TextInputFormatter {
  const ReplaceFormatter({
    required this.replaceWithNextCharacter,
    required this.onReplaced,
  });

  final bool replaceWithNextCharacter;
  final VoidCallback onReplaced;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!replaceWithNextCharacter) {
      return newValue;
    }

    var newText = newValue.text;
    final diff = newText.length - oldValue.text.length;

    if (diff > 0) {
      // Entered character
      newText = newText.characters.last;
    } else if (diff < 0) {
      // Deleted character
      newText = '';
    }

    logger.d('ReplaceFormatter: newText = "$newText"');
    onReplaced();
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
