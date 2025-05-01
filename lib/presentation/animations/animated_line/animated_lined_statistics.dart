import 'package:expense_tracker/presentation/animations/animated_line/line_point.dart';
import 'package:expense_tracker/presentation/theme/color_manger.dart';
import 'package:flutter/material.dart';

class AnimatedLinedStatistics extends StatelessWidget {
  const AnimatedLinedStatistics({
    super.key,
    required this.points,
    required this.width,
    required this.height,
  });
  final List<LinePoint> points;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      //?we need to center the content in the center of the widget.
      margin: const EdgeInsets.only(left: 5, top: 10),
      child: Column(
        children: [
          Container(
            //?we need to put the point exactly above the center of its label
            margin: const EdgeInsets.only(left: 5),
            child: AnimatedLineWidget(
              //?we pass the points as list<AnimatedPoint> which contains both
              //?point offset and label but we want to generate just the offset
              //?of the points as list.
              points: List.generate(points.length, (index) {
                return points[index].offset;
              }),
              label: List.generate(points.length, (index) {
                return points[index].label;
              }),
              width: width,
              height: height,
            ),
          ),
          SizedBox(
            height: 25,
            child: Stack(
              fit: StackFit.loose,
              children: List.generate(points.length, (index) {
                return Positioned(
                  left: points[index].offset.dx,
                  //?we want to put the labels in the bottom of the widget
                  bottom: 0,
                  child: Text(
                    points[index].label,
                    style: TextStyle(
                      fontSize: points.length > 8 ? 10 : 14,
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedLineWidget extends StatefulWidget {
  const AnimatedLineWidget({
    super.key,
    required this.points,
    required this.label,
    required this.width,
    required this.height,
  });
  final List<Offset> points;
  final List<String> label;
  final double width, height;

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedLineWidgetState createState() => _AnimatedLineWidgetState();
}

class _AnimatedLineWidgetState extends State<AnimatedLineWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return SizedBox(
          //?here we need to show the max value point so we increase box size by 5
          height: widget.height + 5,
          child: Stack(
            children: [
              //?we make it on positioned widget with (top,left)=>(3,3) to make the line in the points.
              Positioned(
                top: 3,
                left: 3,
                child: CustomPaint(
                  size: Size(widget.width, widget.height),
                  painter: AnimatedLinePainter(
                    points: widget.points,
                    progress: _animation.value,
                  ),
                ),
              ),
              //?here we can draw the points of each offset.
              ...List.generate(widget.points.length, (index) {
                //?not that positioned starts as (bottom,left)=>)(dy,dx)
                //?not that drawn points using line painter starts as (top,left)=>(dy,dx)
                final bottom = widget.height - widget.points[index].dy;
                final left = widget.points[index].dx;
                return Positioned(
                  bottom: bottom,
                  left: left,
                  child: Container(
                    height: 5,
                    width: 5,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

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
