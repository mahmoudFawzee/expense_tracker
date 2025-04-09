import 'package:flutter/material.dart';

class HomeBase extends StatelessWidget {
  const HomeBase({
    super.key,
    required this.child,
  });
  static const pageRoute = '/home_base';
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return child;
  }
}
