import 'package:flutter/material.dart';

class TableColumnsBackground extends StatelessWidget {
  const TableColumnsBackground({
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

class TableColumnsBackgroundWrapper extends StatelessWidget {
  const TableColumnsBackgroundWrapper({
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
          child: TableColumnsBackground(
            columnsCount: columnsCount,
          ),
        ),
        child,
      ],
    );
  }
}
