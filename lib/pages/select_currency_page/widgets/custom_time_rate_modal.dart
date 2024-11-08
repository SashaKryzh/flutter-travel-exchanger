import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/config/theme/font_size.dart';
import 'package:travel_exchanger/data/time_rate_repository.dart';
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

class CustomTimeRateModal extends HookConsumerWidget {
  const CustomTimeRateModal({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final globalFrom = ref.watch(exchangeBetweenProvider).from.asOrNull<MoneyCurrency>();
    // This case is impossible, but just in case
    if (globalFrom == null) {
      onClose();
      return const EmptyWidget();
    }

    final initialTimeRateData = useMemoized(() {
      return ref.read(timeRateDataProvider);
    });

    final fromCurrency = useState(initialTimeRateData?.to.asOrNull<MoneyCurrency>() ?? globalFrom);
    final textController = useTextEditingController(
      text: initialTimeRateData != null
          ? MoneyValue(initialTimeRateData.perHour, fromCurrency.value)
              .formatM(showFullNumber: true, truncateDecimal: true)
          : null,
    );

    void onSave() {
      var perHour = moneyFormatter().tryParse(textController.text);
      if (perHour == null) {
        return;
      }
      ref
          .read(timeRateRepositoryProvider)
          .setTimeRate(fromCurrency.value, perHour: perHour.toDouble());
      onClose();
    }

    void onDelete() {
      ref.read(timeRateRepositoryProvider).removeTimeRate();
      onClose();
    }

    void onSelectCurrency(Currency currency) {
      if (currency is MoneyCurrency) {
        fromCurrency.value = currency;
      }
    }

    void changeCurrency() {
      SearchCurrencyRoute(
        SearchCurrencyRouteExtra(
          selectedCurrency: fromCurrency.value,
          onSelectCurrency: onSelectCurrency,
        ),
      ).push<void>(context);
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
          children: [
            AutoSizeText.rich(
              const TextSpan(
                text: 'How much is ',
                children: [
                  TextSpan(
                    text: '1 hour',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: ' of your life worth?',
                  ),
                ],
              ),
              style: context.textTheme.titleMedium?.copyWith(
                fontSize: FontSize.s20,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
            HStack(
              children: [
                Flexible(
                  child: TextField(
                    controller: textController,
                    autofocus: true,
                    inputFormatters: const [CurrencyInputFormatter()],
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: context.textTheme.titleLarge,
                    textAlign: TextAlign.center,
                    onSubmitted: (_) => onSave(),
                  ),
                ),
                const Gap(4),
                GestureDetector(
                  onTap: changeCurrency,
                  child: Text(
                    fromCurrency.value.displayCode(context),
                    style: context.textTheme.titleLarge,
                  ).padding(x: 8, y: 4),
                ),
              ],
            ),
            const SizedSpacer(16),
            HStack(
              children: [
                ElevatedButton(
                  onPressed: initialTimeRateData != null ? onDelete : null,
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
