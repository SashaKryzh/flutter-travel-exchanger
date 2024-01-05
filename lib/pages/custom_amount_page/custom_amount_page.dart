import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/domain/converter_providers.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/pages/custom_amount_page/custom_amount_providers.dart';
import 'package:travel_exchanger/utils/hooks/use_listen.dart';
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
    final focusNode = useFocusNode();
    final controller = useTextEditingController();
    final isFirstBuild = usePrevious(false) ?? true;

    final prevFocused = usePrevious(focusNode.hasFocus) ?? false;

    useListen(controller, () {
      if (!prevFocused && focusNode.hasFocus) {
        controller.text = controller.text.characters.last;
      }
    });

    void setAmount() {
      final amount = double.tryParse(controller.text) ?? 0;
      _notifier.setAmount(amount);
    }

    void setFrom() {
      _notifier.setFrom(exchangeable);
      focusNode.requestFocus();
    }

    final isSelected = _state.from == exchangeable;
    final value = _state.valueFor(exchangeable);

    if (isFirstBuild || !isSelected) {
      controller.text = value.toString();
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
                  onTap: setFrom,
                  onChanged: (_) => setAmount(),
                  style: const TextStyle(color: Colors.white),
                  autofocus: isSelected,
                  focusNode: focusNode,
                  textAlign: TextAlign.center,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: true,
                  ),
                  showCursor: false,
                  inputFormatters: [
                    CustomNumberInputFormatter(),
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

class CustomNumberInputFormatter extends TextInputFormatter {
  final RegExp _regExp = RegExp(r'^\d*[.,]?\d{0,2}$');

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (_regExp.hasMatch(newValue.text)) {
      return newValue;
    }
    return oldValue;
  }
}
