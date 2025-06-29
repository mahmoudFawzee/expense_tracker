import 'package:expense_tracker/data/services/statistics/local_statistics_service.dart';
import 'package:expense_tracker/data/services/statistics/statistics_service.dart';

import 'package:expense_tracker/domain/entities/statistics/week/week_statistics.dart';
import 'package:expense_tracker/domain/entities/statistics/year/year_statistics.dart';
import 'package:expense_tracker/domain/repositories/i_statistics_repo.dart';

final class StatisticsRepo implements StatisticsRepoInterface {
  final RemoteStatisticsService _remoteStatisticsService;
  final LocalStatisticsService _localStatisticsService;
  const StatisticsRepo({
    required RemoteStatisticsService remoteStatisticsService,
    required LocalStatisticsService localStatisticsService,
  })  : _localStatisticsService = localStatisticsService,
        _remoteStatisticsService = remoteStatisticsService;

  @override
  Future<WeekStatistics> fetchStatisticsWeek() async {
    final localData = await _localStatisticsService.fetchStatisticsWeek();
    return localData ?? await _remoteStatisticsService.fetchStatisticsWeek();
  }

  @override
  Future<YearStatistics> fetchStatisticsYear() async {
    final localData = await _localStatisticsService.fetchStatisticsYear();
    return localData ?? await _remoteStatisticsService.fetchStatisticsYear();
  }
}
