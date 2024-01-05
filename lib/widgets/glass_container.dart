import 'dart:ui';

import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  const GlassContainer({
    super.key,
    this.child,
    this.color,
    this.borderRadius,
    this.padding,
    this.blur = 5,
  });

  final Widget? child;
  final Color? color;
  final EdgeInsets? padding;
  final BorderRadius? borderRadius;
  final double blur;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.zero,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            color: color ?? Colors.grey[200]!.withOpacity(0.2),
          ),
          child: child,
        ),
      ),
    );
  }
}
