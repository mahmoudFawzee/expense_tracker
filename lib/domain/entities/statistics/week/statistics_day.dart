import 'package:expense_tracker/domain/entities/statistics/time_based_statistics.dart';

class StatisticsDay extends TimeBasedStatistics {
  const StatisticsDay({
    required super.amount,
    required super.date,
    required super.name,
  });
}

