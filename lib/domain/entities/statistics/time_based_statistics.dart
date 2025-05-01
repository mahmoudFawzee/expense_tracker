import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
part 'time_based_statistics.g.dart';
@JsonSerializable()
class TimeBasedStatistics extends Equatable {
  final String name;
  final double amount;
  final DateTime date;
  const TimeBasedStatistics({
    required this.amount,
    required this.date,
    required this.name,
  });
  @override
  List<Object?> get props => [name, amount, date];

  factory TimeBasedStatistics.fromJson(Map<String, dynamic> json) =>
      _$TimeBasedStatisticsFromJson(json);
}
