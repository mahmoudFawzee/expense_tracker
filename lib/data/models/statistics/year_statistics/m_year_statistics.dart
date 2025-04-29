import 'package:expense_tracker/data/models/statistics/statistics_month/m_statistics_month.dart';
import 'package:expense_tracker/domain/entities/statistics/year_statistics.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_year_statistics.g.dart';

@JsonSerializable()
final class YearStatisticsModel extends YearStatistics {
  const YearStatisticsModel(super.totalSpent, super.months);
  factory YearStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$YearStatisticsModelFromJson(json);
}