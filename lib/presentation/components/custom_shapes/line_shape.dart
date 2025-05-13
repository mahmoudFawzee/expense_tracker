import 'package:expense_tracker/config/theme/color_manger.dart';
import 'package:flutter/material.dart';

class AnimatedLinePainter extends CustomPainter {
  final double progress;
  final List<Offset> points;
  AnimatedLinePainter({
    required this.points,
    required this.progress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ColorsMangerDark.primaryColor
      ..strokeWidth = 4.0;

    // Total number of segments
    final totalSegments = points.length - 1;

    // Compute how far we should go
    double totalProgress = progress * totalSegments;

    for (int i = 0; i < totalSegments; i++) {
      final start = points[i];
      final end = points[i + 1];

      if (totalProgress >= i + 1) {
        // Draw full segment
        canvas.drawLine(start, end, paint);
      } else if (totalProgress > i) {
        // Partial segment
        double localProgress = totalProgress - i;
        final current = Offset.lerp(start, end, localProgress)!;
        canvas.drawLine(start, current, paint);
        break; // Stop drawing after this
      } else {
        break; // Not reached this segment yet
      }
    }
  }

  @override
  bool shouldRepaint(covariant AnimatedLinePainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
