
import 'package:expense_tracker/domain/entities/statistics/year/statistics_month.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_statistics_month.g.dart';

@JsonSerializable()
final class StatisticsMonthModel extends StatisticsMonth {
  const StatisticsMonthModel({
    required super.amount,
    required super.date,
    required super.name,
  });

  factory StatisticsMonthModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticsMonthModelFromJson(json);
}
