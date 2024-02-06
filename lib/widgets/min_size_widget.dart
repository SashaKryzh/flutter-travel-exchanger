import 'package:flutter/material.dart';

/// Will be of size [minSizeWidget] if [child] is smaller, otherwise will be of size [child].
///
/// Puts [minSizeWidget] behind [child] in Stack and sets [opacity] to 0.
class MinSizeWidget extends StatelessWidget {
  const MinSizeWidget({
    super.key,
    this.alignment = Alignment.center,
    required this.minSizeWidget,
    required this.child,
  });

  final Widget child;
  final Widget minSizeWidget;
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: alignment,
      children: [
        IgnorePointer(
          child: Opacity(
            opacity: 0,
            child: minSizeWidget,
          ),
        ),
        child,
      ],
    );
  }
}
