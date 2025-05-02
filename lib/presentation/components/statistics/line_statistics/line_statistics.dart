import 'dart:developer';

import 'package:expense_tracker/domain/entities/statistics/time_based_statistics.dart';
import 'package:expense_tracker/presentation/animations/animated_line/animated_lined_statistics.dart';
import 'package:expense_tracker/presentation/animations/animated_line/line_point.dart';
import 'package:flutter/material.dart';

class LineStatisticsWidget extends StatelessWidget {
  const LineStatisticsWidget({
    super.key,
    required this.maxValue,
    required this.items,
  });

  final double maxValue;
  final List<TimeBasedStatistics> items;

  @override
  Widget build(BuildContext context) {
    //?40 is the padding.
    final width = MediaQuery.of(context).size.width - 40;
    return Center(
      child: AnimatedLinedStatistics(
        //?this is the number of items it can be 7 if week or 12 if year.
        width: width,
        //?this actually set the height of the y axis.
        height: 150,
        points: List.generate(items.length, (index) {
          final dx = (width / items.length) * index;
          //?this be sure that the point dy won't pass the maximum yD value(150).
          final dy = ((maxValue - items[index].amount) / maxValue) * 150;
          log('state offset: Offset($dx,$dy)');
          return LinePoint(
            //?actual value if the represented item
            value: items[index].amount,
            //?the label on the x axis with yd=>0
            label: items[index].name,
            //?the position of the point in the xy demotions
            offset: Offset(dx, dy),
          );
        }),
      ),
    );
  }
}
