
import 'package:expense_tracker/domain/entities/statistics/statistics_day.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_statistics_day.g.dart';

@JsonSerializable()
final class StatisticsDayModel extends StatisticsDay {
 const StatisticsDayModel({
    required super.amount,
    required super.date,
    required super.dayName,
  });

  factory StatisticsDayModel.fromJson(Map<String, dynamic> json) =>
      _$StatisticsDayModelFromJson(json);
}
