import 'package:flutter/material.dart';

/// Useful for providing safe area at the bottom of the scrollable widget (e.g. ListView).
class BottomSafeArea extends StatelessWidget {
  const BottomSafeArea({
    super.key,
    this.resize = true,
    this.additionalHeight = 0,
  });

  final bool resize;
  final double additionalHeight;

  @override
  Widget build(BuildContext context) {
    final padding =
        resize ? MediaQuery.paddingOf(context).bottom : MediaQuery.viewPaddingOf(context).bottom;

    return SizedBox(
      height: padding + additionalHeight,
    );
  }
}
