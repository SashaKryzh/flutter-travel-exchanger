import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:travel_exchanger/config/router/router.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/widgets/shortcut_widgets.dart';

class CustomRateModal extends HookWidget {
  const CustomRateModal({
    super.key,
    required this.to,
    required this.onSubmit,
  });

  final Currency to;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();

    final bottomInset = MediaQuery.viewInsetsOf(context).bottom;

    return Container(
      margin: EdgeInsets.all(50).copyWith(
        bottom: bottomInset,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Material(
        child: VStack(
          children: [
            HStack(
              children: [
                const _CurrencyIndicator(
                  currency: Currency.usd,
                  changeable: false,
                ),
                const _CurrencyIndicator(
                  currency: Currency.eur,
                  changeable: true,
                ),
              ],
            ),
            TextField(
              autofocus: true,
              focusNode: focusNode,
              onSubmitted: (_) => onSubmit(),
              keyboardType: TextInputType.number,
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
      child: Text(currency.displayCode(context)),
    );
  }
}
