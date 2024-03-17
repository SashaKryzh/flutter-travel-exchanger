import 'package:flutter/material.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/glass_container.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

class GlassSelectableContainer extends StatelessWidget {
  const GlassSelectableContainer({
    super.key,
    required this.isSelected,
    required this.onTap,
    this.padding,
    this.blur,
    this.borderRadius,
    required this.child,
  });

  final bool isSelected;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? blur;
  final double? borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: GlassContainer(
        blur: blur ?? 5,
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        color: context.colorScheme.onBackground.withOpacity(0.15),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 100),
          padding: padding,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius ?? 0),
            border: Border.all(
              color: (context.isDark
                      ? context.colorScheme.tertiary
                      : context.colorScheme.tertiaryContainer)
                  .withOpacity(isSelected ? 1 : 0),
              width: 2,
            ),
          ),
          child: child.textAlignX(TextAlign.center),
        ),
      ),
    );
  }
}
