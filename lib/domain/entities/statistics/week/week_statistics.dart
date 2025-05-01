import 'package:expense_tracker/domain/entities/statistics/period_based_statistics.dart';

class WeekStatistics extends PeriodBasedStatistics {
  const WeekStatistics({
    required super.totalSpent,
    required super.items,
    required super.maxValue,
  });
}
