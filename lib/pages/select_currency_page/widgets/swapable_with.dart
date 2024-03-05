import 'package:flutter/material.dart';
import 'package:travel_exchanger/config/theme/app_icons.dart';
import 'package:travel_exchanger/domain/currency.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/shortcut_widgets.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';

class SwapableWith extends StatelessWidget {
  const SwapableWith({
    super.key,
    required this.from,
    required this.to,
  });

  final Currency from;
  final Currency to;

  @override
  Widget build(BuildContext context) {
    final textStyle = context.textTheme.bodyLarge?.copyWith(color: context.theme.disabledColor);

    return HStack(
      children: [
        Text(
          from.displayCode(context),
          style: textStyle,
        ),
        const SizedSpacer(1),
        Icon(
          AppIcons.swap,
          size: 16,
          color: context.theme.disabledColor,
        ),
        const SizedSpacer(1),
        Text(
          to.displayCode(context),
          style: textStyle,
        ),
      ],
    );
  }
}
