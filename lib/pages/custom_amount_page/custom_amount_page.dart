import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/pages/custom_amount_page/formatters/currency_input_formatter.dart';
import 'package:travel_exchanger/pages/custom_amount_page/custom_amount_providers.dart';
import 'package:travel_exchanger/pages/custom_amount_page/formatters/replace_formatter.dart';
import 'package:travel_exchanger/utils/extensions.dart';
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

const kContainerPadding = 12.0;
const kContainerBorderRadius = 12.0;
const kContainerBlur = 7.0;

class _InputContainer extends HookConsumerWidget {
  const _InputContainer({
    required this.currency,
  });

  final Currency currency;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = useFocusNode();
    final controller = useTextEditingController();

    final isFirstBuild = usePrevious(false) ?? true;

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
        blur: kContainerBlur,
        borderRadius: BorderRadius.circular(kContainerBorderRadius),
        color: context.colorScheme.onBackground.withOpacity(0.15),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: const EdgeInsets.all(kContainerPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kContainerBorderRadius),
            border: Border.all(
              color: (context.isDark
                      ? context.colorScheme.tertiary
                      : context.colorScheme.tertiaryContainer)
                  .withOpacity(isSelected ? 1 : 0),
              width: 2,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                currency.displayCode(context),
              ).textStyle(
                context.textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 20),
              ),
              const SizedSpacer(10),
              IgnorePointer(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  autofocus: isSelected,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  style: context.textTheme.titleLarge?.copyWith(
                    fontSize: 24,
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
                  onEditingComplete: () => {},
                  inputFormatters: [
                    ReplaceFormatter(
                      replaceWithNextCharacter: justReceivedFocus.value,
                      onReplaced: () => justReceivedFocus.value = false,
                    ),
                    const CurrencyInputFormatter(),
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
