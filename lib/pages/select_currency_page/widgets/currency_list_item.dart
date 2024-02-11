// ignore_for_file: prefer-match-file-name, prefer-single-widget-per-file

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/domain/rates_providers.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/min_size_widget.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

// TODO: Handle time as a currency in both selected and regular items.

class RegularCurrencyListItem extends StatelessWidget {
  const RegularCurrencyListItem({
    super.key,
    required this.currency,
    required this.swapableWith,
    required this.selected,
    required this.padding,
    required this.onTap,
  });

  final Currency currency;
  final Currency? swapableWith;
  final bool selected;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    Widget? trailing;

    if (selected) {
      trailing = const Icon(Icons.check);
    } else if (swapableWith != null) {
      trailing = Row(
        children: [
          Text(
            currency.code,
            style: context.textTheme.bodyLarge?.copyWith(color: context.theme.disabledColor),
          ),
          const SizedSpacer(1),
          Icon(Icons.swap_horiz, color: context.theme.disabledColor),
          const SizedSpacer(1),
          Text(
            swapableWith!.code,
            style: context.textTheme.bodyLarge?.copyWith(color: context.theme.disabledColor),
          ),
        ],
      );
    }

    return DefaultTextStyle.merge(
      style: selected ? TextStyle(color: context.theme.disabledColor) : null,
      child: IconTheme.merge(
        data: IconThemeData(
          color: selected ? context.theme.disabledColor : null,
        ),
        child: _Row(
          code: Text(currency.code),
          // TODO: Provide real currency names.
          title: Text(currency.name(context)),
          trailing: trailing,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 8,
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}

class SelectedCurrencyListItem extends StatelessWidget {
  const SelectedCurrencyListItem({
    super.key,
    required this.currency,
    required this.active,
    required this.rate,
    required this.padding,
    required this.onTap,
  });

  final Currency currency;
  final bool active;
  final RateForData rate;
  final EdgeInsets padding;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final activeHighlightColor = active ? context.colorScheme.primary : null;

    return _Row(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      code: Text(
        currency.code,
        style: TextStyle(
          color: activeHighlightColor,
        ),
      ),
      title: Text(
        currency.name(context),
        style: TextStyle(
          color: activeHighlightColor,
        ),
      ),
      trailing: Row(
        children: [
          Text(
            rate.rate.toStringAsFixed(2),
            style: context.textTheme.bodyLarge?.copyWith(
              color: rate.source.isApi ? context.theme.disabledColor : Colors.orange[200],
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends HookWidget {
  const _Row({
    required this.code,
    required this.title,
    this.trailing,
    this.padding = EdgeInsets.zero,
    this.onTap,
  });

  final Widget code;
  final Widget title;
  final Widget? trailing;
  final EdgeInsets padding;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final tapped = useState(false);

    void onPointerChanged(bool down) {
      if (onTap == null) {
        return;
      }
      tapped.value = down;
    }

    return Listener(
      onPointerDown: (_) => onPointerChanged(true),
      onPointerUp: (_) => onPointerChanged(false),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          color: tapped.value ? Colors.black.withOpacity(0.1) : Colors.transparent,
          padding: padding,
          child: Row(
            children: [
              DefaultTextStyle.merge(
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.defaultTextStyle.style.color,
                  fontWeight: FontWeight.bold,
                ),
                child: MinSizeWidget(
                  alignment: Alignment.centerLeft,
                  minSizeWidget: const Text('AAAA'),
                  child: code,
                ),
              ),
              DefaultTextStyle.merge(
                style: context.textTheme.bodyLarge?.copyWith(
                  color: context.defaultTextStyle.style.color,
                ),
                child: title,
              ).expanded(),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
