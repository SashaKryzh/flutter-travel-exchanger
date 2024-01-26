import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/data/rates_repository.dart';
import 'package:travel_exchanger/domain/exchange_between.dart';
import 'package:travel_exchanger/domain/currencies_provider.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_providers.dart';
import 'package:travel_exchanger/utils/extensions.dart';

class SelectCurrencyPage extends HookConsumerWidget {
  const SelectCurrencyPage({
    super.key,
    required this.currencyCode,
  });

  final String currencyCode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCurrencies = ref.watch(currenciesProvider);
    final exchangeBetween = ref.read(exchangeBetweenProvider);
    final exchangeBetweenNotifier = ref.read(exchangeBetweenProvider.notifier);
    final selectedCurrency = allCurrencies.getCurrencyFromCode(currencyCode);

    final query = useState('');
    final filteredCurrencies = ref.watch(searchCurrenciesProvider(query.value));

    void selectCurrency(Currency newSelectedCurrency) {
      ref.read(exchangeBetweenProvider.notifier).swap(selectedCurrency, newSelectedCurrency);
      context.pop();
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              exchangeBetween.isTwo
                  ? exchangeBetweenNotifier.showThird()
                  : exchangeBetweenNotifier.hideThird();
              context.pop();
            },
            child: Text(exchangeBetween.isTwo ? 'Show third currency' : 'Hide third currency'),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SafeArea(
              bottom: false,
              child: ListView(
                children: [
                  if (filteredCurrencies.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Center(
                        child: Text('No results'),
                      ),
                    )
                  else ...[
                    TimeListTile(
                      onTap: () => selectCurrency(Currency.time),
                      selected: selectedCurrency == Currency.time,
                      swapable: exchangeBetween.contains(Currency.time) &&
                          Currency.time != selectedCurrency,
                    ),
                    ...filteredCurrencies
                        .map<Widget>(
                          (e) => CurrencyListTile(
                            currency: e,
                            onTap: () => selectCurrency(e),
                            selected: e == selectedCurrency,
                            swapable: exchangeBetween.contains(e) && e != selectedCurrency,
                          ),
                        )
                        .insertBetween(const Divider(
                          height: 0,
                        ))
                  ],
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.black,
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: TextField(
                  autofocus: true,
                  onChanged: (text) => query.value = text,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyListTile extends StatelessWidget {
  const CurrencyListTile({
    super.key,
    required this.currency,
    required this.onTap,
    required this.selected,
    required this.swapable,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  }) : assert(!selected || !swapable);

  final Currency currency;
  final VoidCallback onTap;
  final bool selected;
  final bool swapable;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: padding,
        child: Row(
          children: [
            Expanded(
              child: Text(
                currency.code,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (selected) const Icon(Icons.check),
            if (swapable) const Icon(Icons.swap_horiz),
          ],
        ),
      ),
    );
  }
}

class TimeListTile extends ConsumerWidget {
  const TimeListTile({
    super.key,
    required this.onTap,
    required this.selected,
    required this.swapable,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  });

  final VoidCallback onTap;
  final bool selected;
  final bool swapable;
  final EdgeInsets padding;

  Currency get _currency => Currency.time;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onSettingsTap() async {
      var _text = '';

      Future<void> setTimeRate() async {
        final hourRate = double.tryParse(_text) ?? 0;
        final secondRate = convertHourlyRateToSecondlyRate(hourRate);
        await ref
            .read(ratesRepositoryProvider)
            .setCustomRate(Currency.time, Currency.pln, secondRate);
        context.pop();
      }

      await showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Row(
              children: [
                const Flexible(
                  child: Text('1 hour = '),
                ),
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (text) => _text = text,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: context.pop,
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: setTimeRate,
                child: const Text('Save'),
              ),
            ],
          );
        },
      );
    }

    final currentRate =
        ref.watch(ratesProvider).rates.where((e) => e.base == _currency).firstOrNull;

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Container(
        padding: padding,
        child: Row(
          children: [
            Expanded(
              child: Text(
                '${_currency.code} (${convertSecondlyRateToHourly(currentRate?.rate ?? 0)})',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (selected) const Icon(Icons.check),
            if (swapable) const Icon(Icons.swap_horiz),
            IconButton(
              onPressed: onSettingsTap,
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
      ),
    );
  }
}

const secondsInHour = 3600;

double convertHourlyRateToSecondlyRate(double hourRate) {
  return hourRate / secondsInHour;
}

double convertSecondlyRateToHourly(double hourRate) {
  return hourRate / secondsInHour;
}
