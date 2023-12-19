import 'package:flutter/material.dart';

class SizedSpacer extends StatelessWidget {
  const SizedSpacer(
    this.size, {
    super.key,
  });

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildLayout(
      delegate: _SizedSpacerLayoutDelegate(size: size),
    );
  }
}

class _SizedSpacerLayoutDelegate extends SingleChildLayoutDelegate {
  const _SizedSpacerLayoutDelegate({
    required this.size,
  });

  final double size;

  @override
  Size getSize(BoxConstraints constraints) {
    return Size(
      constraints.maxWidth == double.infinity ? size : 0,
      constraints.maxHeight == double.infinity ? size : 0,
    );
  }

  @override
  bool shouldRelayout(covariant _SizedSpacerLayoutDelegate oldDelegate) {
    return size != oldDelegate.size;
  }
}
