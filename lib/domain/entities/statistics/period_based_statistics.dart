import 'package:equatable/equatable.dart';
import 'package:expense_tracker/domain/entities/statistics/time_based_statistics.dart';
import 'package:json_annotation/json_annotation.dart';
part 'period_based_statistics.g.dart';
@JsonSerializable()
class PeriodBasedStatistics extends Equatable {
  final List<TimeBasedStatistics> items;
  final double totalSpent;
  final double maxValue;
  const PeriodBasedStatistics({
    required this.totalSpent,
    required this.items,
    required this.maxValue,
  });
  @override
  List<Object?> get props => [items, totalSpent, maxValue];
  factory PeriodBasedStatistics.fromJson(Map<String, dynamic> json) =>
      _$PeriodBasedStatisticsFromJson(json);
}
