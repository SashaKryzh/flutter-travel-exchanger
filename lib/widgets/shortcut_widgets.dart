// ignore_for_file: prefer-match-file-name, prefer-single-widget-per-file

import 'package:flutter/material.dart';
import 'package:travel_exchanger/widgets/sized_spacer.dart';
import 'package:travel_exchanger/widgets/widget_extensions.dart';

class HStack extends StatelessWidget {
  const HStack(
    this.children, {
    super.key,
    this.gap = 0,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<Widget> children;
  final double gap;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children.separated(SizedSpacer(gap)),
    );
  }
}

class VStack extends StatelessWidget {
  const VStack(
    this.children, {
    super.key,
    this.gap = 0,
    this.mainAxisSize = MainAxisSize.min,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final List<Widget> children;
  final double gap;
  final MainAxisSize mainAxisSize;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment,
      children: children.separated(SizedSpacer(gap)),
    );
  }
}
