import 'package:expense_tracker/domain/entities/statistics/week/week_statistics.dart';
import 'package:expense_tracker/domain/entities/statistics/year/year_statistics.dart';

abstract class StatisticsServiceInterface {
  Future<WeekStatistics?> fetchStatisticsWeek();
  Future<YearStatistics?> fetchStatisticsYear();
}
