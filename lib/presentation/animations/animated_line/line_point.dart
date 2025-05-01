import 'package:flutter/material.dart';

final class LinePoint {
  final String label;
  final Offset offset;
  final double value;
  const LinePoint({
    required this.label,
    required this.value,
    required this.offset,
  });
}
