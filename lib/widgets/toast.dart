import 'package:flutter/material.dart';
import 'package:travel_exchanger/utils/extensions.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

Widget topCenterToastBuilder(BuildContext context, Widget child) {
  return Positioned(
    top: 20,
    left: 0,
    right: 0,
    child: Center(
      child: SafeArea(
        child: child,
      ),
    ),
  );
}

class ToastContainer extends StatelessWidget {
  const ToastContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: context.colorScheme.tertiaryContainer,
        borderRadius: const BorderRadius.all(Radius.circular(9999)),
      ),
      child: child.textStyle(TextStyle(color: context.colorScheme.onTertiaryContainer)),
    );
  }
}
