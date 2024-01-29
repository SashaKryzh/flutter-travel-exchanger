import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DebugContainer extends StatelessWidget {
  const DebugContainer({
    super.key,
    required this.child,
    this.showBorder = true,
  });

  final Widget child;
  final bool showBorder;

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) {
      return child;
    }

    return Container(
      decoration: BoxDecoration(
        border: showBorder ? Border.all(color: Colors.red) : null,
      ),
      child: child,
    );
  }
}
