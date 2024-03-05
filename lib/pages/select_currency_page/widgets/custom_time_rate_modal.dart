import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/empty_widget.dart';
import 'package:travel_exchanger/widgets/shortcut_widgets.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';

class CustomTimeRateModal extends HookConsumerWidget {
  const CustomTimeRateModal({
    super.key,
    required this.onClose,
  });

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final from = ref.watch(exchangeBetweenProvider).from.asOrNull<MoneyCurrency>();
    if (from == null) {
      onClose();
      return const EmptyWidget();
    }

    final fromCurrency = useState(from);

    void onSelectCurrency(Currency currency) {
      if (currency is MoneyCurrency) {
        fromCurrency.value = currency;
      }
    }

    void changeCurrency() {
      SearchCurrencyV2Route(
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
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: Material(
        child: VStack(
          children: [
            Text('How much is 1 hour of your life worth?'),
            HStack(
              children: [
                Text('1 hour ='),
                const SizedSpacer(4),
                Flexible(
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
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
          ],
        ),
      ),
    );
  }
}
