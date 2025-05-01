import 'package:expense_tracker/domain/entities/statistics/time_based_statistics.dart';
import 'package:expense_tracker/domain/entities/statistics/year/year_statistics.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_year_statistics.g.dart';

@JsonSerializable()
final class YearStatisticsModel extends YearStatistics {
  const YearStatisticsModel({
    required super.totalSpent,
    required super.items,
    required super.maxValue,
  });
  factory YearStatisticsModel.fromJson(Map<String, dynamic> json) =>
      _$YearStatisticsModelFromJson(json);
}
