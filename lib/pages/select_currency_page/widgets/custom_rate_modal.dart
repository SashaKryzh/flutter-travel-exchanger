import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/config/theme/app_icons.dart';
import 'package:travel_exchanger/data/rates_repository.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/domain/value.dart';
import 'package:travel_exchanger/pages/custom_amount_page/formatters/currency_input_formatter.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/empty_widget.dart';
import 'package:travel_exchanger/widgets/shortcut_widgets.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

class CustomRateModal extends HookConsumerWidget {
  const CustomRateModal({
    super.key,
    required this.to,
    required this.onClose,
  });

  final MoneyCurrency to;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final from = ref.watch(exchangeBetweenProvider).from.asOrNull<MoneyCurrency>();
    if (from == null) {
      onClose();
      return const EmptyWidget();
    }

    final rate = ref.watch(rateProvider(from, to));
    final initialRight = rate.source.isCustom
        ? MoneyValue(rate.rate, to).formatM(showFullNumber: true, truncateDecimal: true)
        : null;

    final leftController = useTextEditingController(text: '1');
    final rightController = useTextEditingController(text: initialRight);

    void onSave() {
      final left = moneyFormatter().tryParse(leftController.text);
      final right = moneyFormatter().tryParse(rightController.text);
      if (left == null || right == null) {
        return;
      }
      final newRate = right / left;
      ref.read(ratesRepositoryProvider).setCustomRate(from, to, newRate);
      onClose();
    }

    void onDelete() {
      ref.read(ratesRepositoryProvider).removeCustomRateBetween(from, to);
      onClose();
    }

    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30).copyWith(
        bottom: bottomInset,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: VStack(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedSpacer(14),
            Stack(
              alignment: Alignment.center,
              children: [
                HStack(
                  children: [
                    VStack(children: [
                      _CurrencyIndicator(
                        currency: from,
                        changeable: false,
                      ),
                      TextField(
                        controller: leftController,
                        textAlign: TextAlign.center,
                        onSubmitted: (_) => onSave(),
                        style: context.textTheme.titleLarge,
                        inputFormatters: const [CurrencyInputFormatter()],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ]).expanded(),
                    const SizedSpacer(8),
                    VStack(children: [
                      _CurrencyIndicator(
                        currency: to,
                        changeable: false,
                      ),
                      TextField(
                        controller: rightController,
                        autofocus: true,
                        textAlign: TextAlign.center,
                        onSubmitted: (_) => onSave(),
                        style: context.textTheme.titleLarge,
                        inputFormatters: const [CurrencyInputFormatter()],
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      ),
                    ]).expanded(),
                  ],
                ),
                Icon(
                  AppIcons.equal,
                  color: context.theme.disabledColor,
                ),
              ],
            ),
            const SizedSpacer(16),
            HStack(
              children: [
                ElevatedButton(
                  onPressed: initialRight != null ? onDelete : null,
                  child: const Text('Delete'),
                ).expanded(),
                const SizedSpacer(8),
                ElevatedButton(
                  onPressed: onSave,
                  child: const Text('Save'),
                ).expanded(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CurrencyIndicator extends StatelessWidget {
  const _CurrencyIndicator({
    required this.currency,
    required this.changeable,
  });

  final Currency currency;
  @Deprecated('Maybe remove it')
  final bool changeable;

  @override
  Widget build(BuildContext context) {
    void onTap() {
      SearchCurrencyRoute(
        SearchCurrencyRouteExtra(
          onSelectCurrency: (value) {},
          selectedCurrency: Currency.eur,
        ),
      ).push<void>(context);
    }

    return GestureDetector(
      onTap: changeable ? onTap : null,
      child: Text(currency.displayCode(context)).textStyle(context.textTheme.titleLarge),
    );
  }
}
