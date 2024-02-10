// ignore_for_file: prefer-single-widget-per-file

import 'package:flutter/material.dart';

class ExchangeTableBackground extends StatelessWidget {
  const ExchangeTableBackground({
    super.key,
    required this.columnsCount,
  });

  final int columnsCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            color: Colors.grey,
          ),
        ),
        for (var i = 1; i < columnsCount; i++) ...[
          const VerticalDivider(
            width: 1,
            color: Colors.black,
          ),
          Expanded(
            child: Container(
              color: Colors.grey[300],
            ),
          ),
        ],
      ],
    );
  }
}

class ExchangeTableBackgroundWrapper extends StatelessWidget {
  const ExchangeTableBackgroundWrapper({
    super.key,
    required this.child,
    required this.columnsCount,
  });

  final Widget child;
  final int columnsCount;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ExchangeTableBackground(
            columnsCount: columnsCount,
          ),
        ),
        child,
      ],
    );
  }
}
