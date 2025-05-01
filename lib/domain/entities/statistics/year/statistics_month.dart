import 'package:expense_tracker/domain/entities/statistics/time_based_statistics.dart';

class StatisticsMonth extends TimeBasedStatistics {
  const StatisticsMonth({
    required super.amount,
    required super.date,
    required super.name,
  });
}
