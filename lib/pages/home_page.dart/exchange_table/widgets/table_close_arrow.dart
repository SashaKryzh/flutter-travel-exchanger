import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:travel_exchanger/config/theme/app_theme.dart';
import 'package:travel_exchanger/pages/home_page.dart/exchange_table/exchange_table.dart';

enum ArrowDirection {
  up,
  down,
}

class TableCloseArrow extends HookWidget {
  const TableCloseArrow({
    super.key,
    required this.opened,
    this.direction = ArrowDirection.up,
  });

  final bool opened;
  final ArrowDirection direction;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: kExchangeRowExpandAnimationDuration,
      initialValue: opened ? 1 : 0,
    );

    useEffect(() {
      if (opened) {
        controller.forward();
      } else {
        controller.reverse();
      }
      return null;
    }, [opened]);

    return Transform.flip(
      flipY: direction == ArrowDirection.down,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) => CustomPaint(
          painter: ArrowPainter(
            angle: 90 * controller.value,
            color: ColorTween(begin: context.tableTheme.borderColor, end: context.tableTheme.borderColor.withOpacity(0.5))
                    .transform(controller.value) ??
                Colors.transparent,
            strokeWidth: Tween(begin: 1.0, end: 1.3).transform(controller.value),
          ),
        ),
      ),
    );
  }
}

class ArrowPainter extends CustomPainter {
  ArrowPainter({
    required this.angle,
    this.headLength = 25.0,
    this.color = Colors.black,
    this.strokeWidth = 2.0,
  });

  /// Angle between the arrowhead sides in degrees.
  final double angle;
  final double headLength;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Arrow shaft
    final shaftStart = Offset(size.width / 2, 0);
    final shaftEnd = Offset(size.width / 2, size.height);
    canvas.drawLine(shaftStart, shaftEnd, paint);

    // Angle adjustment for the arc start and end points
    final startAngle = (90 + angle / 2).toRadians();
    final endAngle = (90 - angle / 2).toRadians();

    // Calculate points on the circle for the arrowhead
    final startPoint = Offset(
      shaftStart.dx + headLength * math.cos(startAngle),
      shaftStart.dy + headLength * math.sin(startAngle),
    );
    final endPoint = Offset(
      shaftStart.dx + headLength * math.cos(endAngle),
      shaftStart.dy + headLength * math.sin(endAngle),
    );

    canvas.drawLine(startPoint, shaftStart, paint);
    canvas.drawLine(endPoint, shaftStart, paint);
  }

  @override
  bool shouldRepaint(covariant ArrowPainter oldDelegate) =>
      oldDelegate.angle != angle ||
      oldDelegate.headLength != headLength ||
      oldDelegate.color != color ||
      oldDelegate.strokeWidth != strokeWidth;
}

extension on num {
  num toRadians() => this * math.pi / 180;
}
