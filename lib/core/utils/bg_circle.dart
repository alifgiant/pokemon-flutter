import 'package:flutter/material.dart';

class BgCircle extends StatelessWidget {
  const BgCircle({
    required this.radius,
    this.color = Colors.white,
    super.key,
  });

  final double radius;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HolePainter(radius, color),
    );
  }
}

class HolePainter extends CustomPainter {
  const HolePainter(this.radius, this.color);

  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color.withOpacity(0.4);

    // circle with empty circle inside
    final Path path = Path()
      ..fillType = PathFillType.evenOdd
      ..addOval(Rect.fromCircle(center: Offset.zero, radius: radius))
      ..addOval(Rect.fromCircle(center: Offset.zero, radius: radius / 2.7));
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
