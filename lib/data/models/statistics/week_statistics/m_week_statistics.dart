import 'package:expense_tracker/domain/entities/statistics/time_based_statistics.dart';
import 'package:expense_tracker/domain/entities/statistics/week/week_statistics.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_week_statistics.g.dart';

@JsonSerializable()
final class WeekStatisticsModel extends WeekStatistics {
  const WeekStatisticsModel({
    required super.totalSpent,
    required super.items,
    required super.maxValue,
  });

  factory WeekStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$WeekStatisticsModelFromJson(json);
}
