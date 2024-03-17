import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/data/time_rate_repository.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
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
    // ! TODO: Handle from the Time is FROM
    final from = ref.watch(exchangeBetweenProvider).from.asOrNull<MoneyCurrency>();
    if (from == null) {
      onClose();
      return const EmptyWidget();
    }

    final fromCurrency = useState(from);

    final initialTimeRate = useMemoized(() {
      final timeRateData = ref.read(timeRateDataProvider);
      if (timeRateData == null) return null;
      // TODO: Improve formatting.
      return timeRateData.perHour.toStringAsFixed(2);
    });
    final textController = useTextEditingController(text: initialTimeRate ?? '');

    void onSave() {
      final perHour = double.parse(textController.text);
      ref.read(timeRateRepositoryProvider).setTimeRate(fromCurrency.value, perHour: perHour);
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
          selectedCurrency: from,
          onSelectCurrency: onSelectCurrency,
        ),
      ).push<void>(context);
    }

    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 30).copyWith(
        bottom: bottomInset,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
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
            const Text('How much is 1 hour of your life worth?'),
            HStack(
              children: [
                const Text('1 hour ='),
                const SizedSpacer(4),
                Flexible(
                  child: TextField(
                    controller: textController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedSpacer(4),
                GestureDetector(
                  onTap: changeCurrency,
                  child: Text(
                    fromCurrency.value.displayCode(context),
                  ),
                ),
              ],
            ),
            const SizedSpacer(16),
            HStack(
              children: [
                ElevatedButton(
                  onPressed: initialTimeRate != null ? onDelete : null,
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
