import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:travel_exchanger/domain/converter_providers.dart';
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
    required this.exchangeableCode,
  });

  final String exchangeableCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _state = ref.watch(customAmountConverterProvider(exchangeableCode));
    _notifier = ref.read(customAmountConverterProvider(exchangeableCode).notifier);

    final between = ref.watch(exchangeBetweenProvider).between;
    final third = between.$3;

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
                _InputContainer(exchangeable: between.$1),
                _InputContainer(exchangeable: between.$2),
                if (third != null) _InputContainer(exchangeable: third),
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
    required this.exchangeable,
  });

  final Exchangeable exchangeable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFirstBuild = usePrevious(false) ?? true;

    final focusNode = useFocusNode();
    final controller = useTextEditingController();

    final isSelected = _state.from == exchangeable;
    final value = _state.valueFor(exchangeable);

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
      _notifier.setFrom(exchangeable);
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
              Text(exchangeable.name(context)),
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
                    ReplaceFormatter(justReceivedFocus.value),
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

    var newText = newValue.text;

    logger.d('oldValue: "${oldValue.text}"; newValue: "$newText"');

    if (newText.isEmpty) {
      return newValue;
    }

    // Replace entered decimal separator with the default one.
    if (newText.length > oldValue.text.length && ',.'.contains(newText.characters.last)) {
      newText = newText.substring(0, newText.length - 1) + decimalSeparator;
    }

    // More than one decimal separator.
    if (newText.indexOf(decimalSeparator) != newText.lastIndexOf(decimalSeparator)) {
      return oldValue;
    }

    // Contains space.
    if (newText.contains(' ')) {
      return oldValue;
    }

    final decimalSeparatorInText = newText.contains(decimalSeparator);
    final decimalDigits =
        decimalSeparatorInText ? newText.length - newText.indexOf(decimalSeparator) - 1 : 0;

    if (newText.length == 1 && decimalSeparatorInText) {
      return newValue.copyWith(
        text: '0$decimalSeparator',
        selection: const TextSelection.collapsed(offset: 2),
      );
    }

    // More than two decimal digits.
    if (decimalDigits > 2) {
      return oldValue;
    }

    final value = format().tryParse(newText)?.toDouble();
    if (value == null) {
      return oldValue;
    }
    newText = formatValue(value, decimalDigits: decimalDigits);
    // Add decimal separator if it was removed.
    if (decimalDigits == 0 && decimalSeparatorInText) {
      newText += decimalSeparator;
    }

    logger.d('oldValue: "${oldValue.text}"; Updated to newText: "$newText"');

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}

class ReplaceFormatter extends TextInputFormatter {
  ReplaceFormatter(this.replaceWithNextCharacter);

  final bool replaceWithNextCharacter;

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (!replaceWithNextCharacter) {
      return newValue;
    }

    var newText = newValue.text;
    final diff = newText.length - oldValue.text.length;
    if (diff > 0) {
      newText = newText.characters.last;
    } else if (diff < 0) {
      newText = '';
    }

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
