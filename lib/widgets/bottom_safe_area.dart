import 'package:flutter/material.dart';

/// Useful for providing safe area at the bottom of the scrollable widget (e.g. ListView).
class BottomSafeArea extends StatelessWidget {
  const BottomSafeArea({
    super.key,
    this.additionalHeight = 0,
  });

  final double additionalHeight;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.paddingOf(context).bottom + additionalHeight,
    );
  }
}
