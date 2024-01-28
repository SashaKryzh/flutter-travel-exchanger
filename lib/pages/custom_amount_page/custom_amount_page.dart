import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/pages/custom_amount_page/custom_amount_providers.dart';
import 'package:travel_exchanger/utils/logger.dart';
import 'package:travel_exchanger/widgets/glass_container.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

late CustomAmountState _state;
late CustomAmountConverter _notifier;

class CustomAmountPage extends ConsumerWidget {
  const CustomAmountPage({
    super.key,
    required this.code,
  });

  final String code;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _state = ref.watch(customAmountConverterProvider(code));
    _notifier = ref.read(customAmountConverterProvider(code).notifier);

    final between = ref.watch(exchangeBetweenProvider);
    final to2 = between.to2;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.6),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _InputContainer(currency: between.from),
                _InputContainer(currency: between.to1),
                if (to2 != null) _InputContainer(currency: to2),
              ].separated(const SizedSpacer(16)),
            ),
          ),
        ),
      ),
    );
  }
}

const containerPadding = 12.0;
const containerBorderRadius = 12.0;
const containerBlur = 7.0;

class _InputContainer extends HookConsumerWidget {
  const _InputContainer({
    required this.currency,
  });

  final Currency currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstBuild = usePrevious(false) ?? true;

    final focusNode = useFocusNode();
    final controller = useTextEditingController();

    final isSelected = _state.from == currency;
    final value = _state.valueFor(currency);

    final prevValue = usePrevious(value);
    final prevIsSelected = usePrevious(isSelected) ?? false;
    final justReceivedFocus = useState(isSelected);

    final decimalDigitsUsed = useRef(0);

    if (!justReceivedFocus.value) {
      justReceivedFocus.value = !prevIsSelected && isSelected;
    } else if (!isSelected) {
      justReceivedFocus.value = false;
    }

    if (isFirstBuild) {
      decimalDigitsUsed.value = isSelected ? 0 : 2;
      controller.text = formatValue(value, decimalDigits: decimalDigitsUsed.value);
    } else if (!isSelected) {
      final valueChanged = prevValue?.toStringAsFixed(2) != value.toStringAsFixed(2);
      decimalDigitsUsed.value = valueChanged ? 2 : decimalDigitsUsed.value;
      controller.text = formatValue(value, decimalDigits: decimalDigitsUsed.value);
    }

    void setAmount() {
      justReceivedFocus.value = false;
      decimalDigitsUsed.value = controller.text.contains(decimalSeparator) ? 2 : 0;
      final amount = format().tryParse(controller.text)?.toDouble() ?? 0;
      _notifier.setAmount(amount);
    }

    void setFrom() {
      _notifier.setFrom(currency);
      focusNode.requestFocus();
    }

    return GestureDetector(
      onTap: setFrom,
      child: GlassContainer(
        blur: containerBlur,
        borderRadius: BorderRadius.circular(containerBorderRadius),
        child: Container(
          padding: const EdgeInsets.all(containerPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(containerBorderRadius),
            border: Border.all(
              color: Colors.white.withOpacity(isSelected ? 1 : 0),
              width: 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(currency.name(context)),
              const SizedSpacer(10),
              IgnorePointer(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: isSelected,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white.withOpacity(justReceivedFocus.value ? 0.6 : 1),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                  ),
                  showCursor: false,
                  enableInteractiveSelection: false,
                  onChanged: (_) => setAmount(),
                  onTap: setFrom,
                  // Remove default behavior on enter.
                  onEditingComplete: () {},
                  inputFormatters: [
                    ReplaceFormatter(
                      replaceWithNextCharacter: justReceivedFocus.value,
                      onReplaced: () => justReceivedFocus.value = false,
                    ),
                    CurrencyInputFormatter(),
                  ],
                ),
              ),
              const SizedSpacer(8),
            ],
          ).textStyle(
            const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

String get decimalSeparator => NumberFormat().symbols.DECIMAL_SEP;

NumberFormat format({int decimalDigits = 2}) => NumberFormat.simpleCurrency(
      name: '',
      decimalDigits: decimalDigits,
    );

String formatValue(double value, {int decimalDigits = 2}) {
  return format(decimalDigits: decimalDigits).format(value).trim();
}

class CurrencyInputFormatter extends TextInputFormatter {
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
      final newText = '0$decimalSeparator';
      _logNewText(newText);
      return newValue.copyWith(
        text: '0$decimalSeparator',
        selection: const TextSelection.collapsed(offset: 2),
      );
    }

    // More than two decimal digits.
    if (decimalDigits > 2) {
      _logNewText(oldValue.text);
      return oldValue;
    }

    final value = format().tryParse(newText)?.toDouble();
    if (value == null) {
      _logNewText(oldValue.text);
      return oldValue;
    }
    newText = formatValue(value, decimalDigits: decimalDigits);
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
    onReplaced.call();
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
