import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/pages/custom_amount_page/custom_amount_providers.dart';
import 'package:travel_exchanger/pages/custom_amount_page/formatters/currency_input_formatter.dart';
import 'package:travel_exchanger/pages/custom_amount_page/formatters/replace_formatter.dart';
import 'package:travel_exchanger/pages/custom_amount_page/formatters/time_input_formatter.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/glass_button.dart';
import 'package:travel_exchanger/widgets/shortcut_widgets.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

late CustomAmountConverterProvider _provider;
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
    _provider = customAmountConverterProvider(code);
    _state = ref.watch(_provider);
    _notifier = ref.read(_provider.notifier);

    final between = ref.watch(exchangeBetweenProvider);
    final to2 = between.to2;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
        backgroundColor: Colors.black.withOpacity(0.6),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              VStack(
                gap: 16,
                children: [
                  _InputContainer(currency: between.from),
                  _InputContainer(currency: between.to1),
                  if (to2 != null) _InputContainer(currency: to2),
                ],
              ).center(),
              const _BottomButtons(),
            ],
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
      if (currency.isMoney) {
        controller.text = formatMoney(value, decimalDigits: decimalDigitsUsed.value);
      } else {
        if (isSelected) {
          controller.text = value.toStringAsFixed(0);
        } else {
          controller.text = formatTimeWhileNotEditing(value);
        }
      }
    } else if (!isSelected) {
      final valueChanged = prevValue?.toStringAsFixed(2) != value.toStringAsFixed(2);
      decimalDigitsUsed.value = valueChanged ? 2 : decimalDigitsUsed.value;
      if (currency.isMoney) {
        controller.text = formatMoney(value, decimalDigits: decimalDigitsUsed.value);
      } else {
        controller.text = formatTimeWhileNotEditing(value);
      }
    }

    void setAmount() {
      justReceivedFocus.value = false;
      decimalDigitsUsed.value = controller.text.contains(decimalSeparator) ? 2 : 0;
      final amount = moneyFormatter().tryParse(controller.text)?.toDouble() ?? 0;
      _notifier.setAmount(amount);
    }

    void setFrom() {
      _notifier.setFrom(currency);
      focusNode.requestFocus();
    }

    final timeFrom = switch (ref.watch(customAmountTimeContainerProvider)) {
      CustomAmountTimeFrom.minutes => 'minutes',
      CustomAmountTimeFrom.hours => 'hours',
      CustomAmountTimeFrom.days => 'days',
    };
    final titleSuffix = currency.isTime && _state.from.isTime ? ' ($timeFrom)' : '';

    return GlassSelectableContainer(
      isSelected: isSelected,
      onTap: setFrom,
      blur: kContainerBlur,
      borderRadius: kContainerBorderRadius,
      child: VStack(
        children: [
          Text(
            '${currency.displayCode(context)}$titleSuffix',
          ).textStyle(
            context.textTheme.titleLarge?.copyWith(color: Colors.white, fontSize: 20),
          ),
          const SizedSpacer(10),
          IgnorePointer(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              autofocus: isSelected,
              keyboardType: TextInputType.numberWithOptions(decimal: currency.isMoney),
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
                if (currency.isMoney)
                  const CurrencyInputFormatter()
                else
                  const TimeInputFormatter(),
              ],
            ).center(),
          ),
          const SizedSpacer(8),
        ],
      ).textStyle(const TextStyle(color: Colors.white)).padding(all: kContainerPadding),
    );
  }
}

class _BottomButtons extends ConsumerWidget {
  const _BottomButtons();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCurrency = ref.watch(_provider).from;

    void onChangeCurrencyTap() async {
      final router = GoRouter.of(context)..pop();
      Future.delayed(const Duration(milliseconds: 200), () {
        router.go(SelectCurrencyRoute(currencyCode: selectedCurrency.code).location);
      });
    }

    return Align(
      alignment: Alignment.bottomCenter,
      child: SafeArea(
        top: false,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            IgnorePointer(
              ignoring: !selectedCurrency.isMoney,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 50),
                opacity: selectedCurrency.isMoney ? 1 : 0,
                child: OutlinedButton(
                  onPressed: onChangeCurrencyTap,
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.black12,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: const Text('Change currency'),
                ),
              ),
            ).padding(b: 10),
            IgnorePointer(
              ignoring: !selectedCurrency.isTime,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 50),
                opacity: selectedCurrency.isTime ? 1 : 0,
                child: _TimeFromButtons(
                  selected: ref.watch(customAmountTimeContainerProvider),
                  onChanged: (timeFrom) =>
                      ref.read(customAmountTimeContainerProvider.notifier).setFrom(timeFrom),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeFromButtons extends StatelessWidget {
  const _TimeFromButtons({
    required this.selected,
    required this.onChanged,
  });

  final CustomAmountTimeFrom selected;
  final ValueChanged<CustomAmountTimeFrom>? onChanged;

  @override
  Widget build(BuildContext context) {
    void onTap(CustomAmountTimeFrom timeFrom) => onChanged?.call(timeFrom);

    return HStack(
      mainAxisSize: MainAxisSize.max,
      gap: 8,
      children: [
        GlassSelectableContainer(
          isSelected: selected == CustomAmountTimeFrom.minutes,
          onTap: () => onTap(CustomAmountTimeFrom.minutes),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          blur: kContainerBlur,
          borderRadius: 5,
          child: const Text('Minutes'),
        ).expanded(),
        GlassSelectableContainer(
          isSelected: selected == CustomAmountTimeFrom.hours,
          onTap: () => onTap(CustomAmountTimeFrom.hours),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          blur: kContainerBlur,
          borderRadius: 5,
          child: const Text('Hours'),
        ).expanded(),
        GlassSelectableContainer(
          isSelected: selected == CustomAmountTimeFrom.days,
          onTap: () => onTap(CustomAmountTimeFrom.days),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          blur: kContainerBlur,
          borderRadius: 5,
          child: const Text('Days'),
        ).expanded(),
      ],
    ).padding(b: 10).textStyle(const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ));
  }
}
