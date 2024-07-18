import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:travel_exchanger/config/theme/font_size.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/pages/home_page.dart/home_bottom_bar.dart';
import 'package:travel_exchanger/pages/select_currency_page/select_currency_providers.dart';
import 'package:travel_exchanger/pages/select_currency_page/widgets/currency_list_item.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/utils/hooks/use_listen.dart';
import 'package:travel_exchanger/widgets/glass_container.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

class SearchBar extends HookConsumerWidget {
  const SearchBar({
    super.key,
    required this.settings,
    this.focusNode,
    this.onFocus,
    this.initialOpen = false,
    required this.onSelected,
    this.unfocusOnSelected = true,
  });

  final SearchSettings settings;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocus;
  final bool initialOpen;
  final ValueChanged<Currency> onSelected;
  final bool unfocusOnSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final focusNode = this.focusNode ?? useFocusNode();
    final isOpen = useState(initialOpen);
    useListen(focusNode, () {
      isOpen.value = focusNode.hasFocus;
      onFocus?.call(focusNode.hasFocus);
    });

    final textController = useTextEditingController();
    useListenable(textController);
    final currencies =
        ref.watch(searchCurrenciesProvider(textController.text, filter: settings.filter));

    useValueChanged(isOpen.value, (_, __) => !isOpen.value ? textController.text = '' : null);

    void onSelected(Currency currency) {
      if (unfocusOnSelected) focusNode.unfocus();
      textController.text = '';
      this.onSelected(currency);
    }

    final borderRadius = isOpen.value
        ? const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          )
        : BorderRadius.zero;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colorScheme.outlineVariant,
          width: 1,
          strokeAlign: BorderSide.strokeAlignOutside,
        ),
        borderRadius: borderRadius,
      ),
      child: GlassContainer(
        borderRadius: borderRadius,
        color: context.colorScheme.surface.withOpacity(0.7),
        child: SafeArea(
          maintainBottomViewPadding: true,
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: HomeBottomBar.height,
                child: TextField(
                  controller: textController,
                  focusNode: focusNode,
                  autofocus: initialOpen,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(fontSize: FontSize.s18),
                  ),
                  style: const TextStyle(fontSize: FontSize.s18),
                ).padding(x: 12),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                height: isOpen.value ? 250 : 0,
                padding: isOpen.value ? const EdgeInsets.only(top: 8) : null,
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: currencies.length,
                  itemBuilder: (context, index) {
                    final currency = currencies[index];
                    final metadata = settings.metadata?.call(currency);

                    return RegularCurrencyListItem(
                      currency: currency,
                      selected: metadata?.isSelected ?? false,
                      swapableWith: metadata?.swapableWith,
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                      onTap: metadata?.isSelected != true ? () => onSelected(currency) : null,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchSettings {
  const SearchSettings({
    this.metadata,
    this.filter,
  });

  final CurrencyMetadata? Function(Currency currency)? metadata;
  final bool Function(Currency currency)? filter;
}

// ignore: prefer-single-widget-per-file
class SearchBarWrapper extends HookWidget {
  const SearchBarWrapper({
    super.key,
    required this.settings,
    this.initialOpened = false,
    required this.onSelected,
    this.unfocusOnSelected = true,
    required this.child,
  });

  final SearchSettings settings;
  final bool initialOpened;
  final ValueChanged<Currency> onSelected;
  final bool unfocusOnSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final isOpen = useState(initialOpened);

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
            settings: settings,
            focusNode: focusNode,
            onFocus: (hasFocus) => isOpen.value = hasFocus,
            initialOpen: initialOpened,
            onSelected: onSelected,
            unfocusOnSelected: unfocusOnSelected,
          ),
        ),
      ],
    );
  }
}
