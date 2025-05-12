import 'package:expense_tracker/domain/entities/statistics/time_based_statistics.dart';
import 'package:expense_tracker/core/util/functions/functions.dart';
import 'package:flutter/material.dart';

final class LinePoint {
  final Offset offset;
  final TimeBasedStatistics statisticsItem;
  const LinePoint({
    required this.statisticsItem,
    required this.offset,
  });
//?generate labels(the very bottom text)
  static List<String> labels(List<LinePoint> items) =>
      List.generate(items.length, (index) {
        return items[index].statisticsItem.name;
      });
  //?we pass the points as list<AnimatedPoint> which contains both
  //?point offset and label but we want to generate just the offset
  //?of the points as list.
  static List<Offset> offsets(List<LinePoint> items) =>
      List.generate(items.length, (index) {
        return items[index].offset;
      });
//?generate the dates for each item
  static List<String> dates(List<LinePoint> items) =>
      List.generate(items.length, (index) {
        return handleCardDate(items[index].statisticsItem.date);
      });
//?generate the value of each item.
  static List<double> values(List<LinePoint> items) =>
      List.generate(items.length, (index) {
        return items[index].statisticsItem.amount;
      });
}
