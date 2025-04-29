import 'package:expense_tracker/data/models/statistics/statistics_day/m_statistics_day.dart';
import 'package:expense_tracker/domain/entities/statistics/week_statistics.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_week_statistics.g.dart';

@JsonSerializable()
final class WeekStatisticsModel extends WeekStatistics {
  const WeekStatisticsModel(super.totalSpent, super.days);

  factory WeekStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$WeekStatisticsModelFromJson(json);
}
