import 'package:expense_tracker/domain/entities/statistics/week/week_statistics.dart';
import 'package:expense_tracker/domain/entities/statistics/year/year_statistics.dart';
import 'package:expense_tracker/domain/services/statistics/i_statistics.dart';

final class RemoteStatisticsService implements StatisticsServiceInterface {
  @override
  Future<WeekStatistics> fetchStatisticsWeek() {
    // TODO: implement fetchStatisticsWeek
    throw UnimplementedError();
  }

  @override
  Future<YearStatistics> fetchStatisticsYear() {
    // TODO: implement fetchStatisticsYear
    throw UnimplementedError();
  }
}
