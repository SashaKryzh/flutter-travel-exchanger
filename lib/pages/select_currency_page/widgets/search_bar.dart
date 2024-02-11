import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_page_v2.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_providers.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/currency_list_item.dart';
import 'package:travel_exchanger/utils/hooks/use_listen.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

class SearchBar extends HookConsumerWidget {
  const SearchBar({
    super.key,
    this.focusNode,
    this.onFocus,
  });

  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocus;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = this.focusNode ?? useFocusNode();
    useListenable(focusNode);
    useListen(focusNode, () => onFocus?.call(focusNode.hasFocus));
    final isOpen = focusNode.hasFocus;

    final textController = useTextEditingController();
    useListenable(textController);
    final currencies = ref.watch(searchCurrenciesProvider(textController.text));

    useValueChanged(isOpen, (oldValue, oldResult) => !isOpen ? textController.text = '' : null);

    void onSelected(Currency currency) {
      swapToCurrency(ref, currency);
      focusNode.unfocus();
      textController.text = '';
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: isOpen
            ? const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              )
            : null,
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: textController,
              focusNode: focusNode,
              decoration: const InputDecoration(
                hintText: 'Search',
              ),
            ).padding(x: 18, y: 8),
            AnimatedContainer(
              duration: const Duration(milliseconds: 150),
              height: isOpen ? 250 : 0,
              padding: isOpen ? const EdgeInsets.only(top: 8) : null,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0),
                itemCount: currencies.length,
                itemBuilder: (context, index) {
                  final currency = currencies[index];
                  final metadata = ref.read(currencyMetadataProvider(currency));

                  return RegularCurrencyListItem(
                    currency: currency,
                    selected: metadata.isSelected,
                    swapableWith: metadata.swapableWith,
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                    onTap: !metadata.isSelected ? () => onSelected(currency) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: prefer-single-widget-per-file
class SearchBarWrapper extends HookWidget {
  const SearchBarWrapper({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final isOpen = useState(false);

    return Stack(
      children: [
        child,
        Positioned.fill(
          child: GestureDetector(
            onTap: () => focusNode.unfocus(),
            child: IgnorePointer(
              ignoring: !isOpen.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                color: Colors.black.withOpacity(isOpen.value ? 0.5 : 0),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: SearchBar(
            focusNode: focusNode,
            onFocus: (hasFocus) => isOpen.value = hasFocus,
          ),
        ),
      ],
    );
  }
}
