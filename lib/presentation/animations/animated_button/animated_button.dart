import 'package:flutter/material.dart';
class AnimatedButton extends StatelessWidget {
  const AnimatedButton({
    super.key,
    required this.alignment,
    required this.child,
  });
  final Widget child;
  final Alignment alignment;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      alignment: alignment,
      duration: const Duration(
        milliseconds: 250,
      ),
      child: child,
    );
  }
}
