import 'package:flutter/material.dart';

class LineShape extends CustomPainter {
  const LineShape(this.start, this.end);
  final Offset start;
  final Offset end;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 3.0;

    canvas.drawLine(
      start,
      end,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
