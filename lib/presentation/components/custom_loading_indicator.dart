import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    this.widgetHeight,
  });
  final double? widgetHeight;
  @override
  Widget build(BuildContext context) {
    if (widgetHeight == null) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    }
    return SizedBox(
      height: widgetHeight,
      child: const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
