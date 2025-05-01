import 'package:expense_tracker/domain/entities/statistics/period_based_statistics.dart';

class YearStatistics extends PeriodBasedStatistics {
  const YearStatistics({
    required super.totalSpent,
    required super.items,
    required super.maxValue,
  });
}
