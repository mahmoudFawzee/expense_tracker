import 'dart:developer';

import 'package:expense_tracker/data/models/statistics/statistics_day/m_statistics_day.dart';
import 'package:expense_tracker/data/models/statistics/statistics_month/m_statistics_month.dart';
import 'package:expense_tracker/domain/entities/statistics/week_statistics.dart';
import 'package:expense_tracker/domain/entities/statistics/year_statistics.dart';

import 'package:expense_tracker/domain/services/statistics/i_local_statistics.dart';
import 'package:expense_tracker/util/maps/maps.dart';

final class LocalStatisticsService implements LocalStatisticsServiceInterface {
  @override
  Future<WeekStatistics?> fetchStatisticsWeek() async {
    // TODO: implement fetchStatisticsWeek
    double totalSpent = 0;
    final days = List.generate(7, (index) {
      totalSpent += index * 10;

      return StatisticsDayModel(
        amount: double.tryParse('$index')??20,
        date: DateTime.now(),
        dayName: dayPerWeekName[index + 1] ?? 'Sat',
      );
    });
    log('total spent $totalSpent');
    return WeekStatistics(totalSpent, days);
  }

  @override
  Future<YearStatistics?> fetchStatisticsYear() async {
    // TODO: implement fetchStatisticsYear
    double totalSpent = 0;
    final months = List.generate(12, (index) {
      totalSpent += index * 10;
      return StatisticsMonthModel(
        amount: double.tryParse('$index') ?? 20,
        date: DateTime.now(),
        monthName: monthsName[index + 1] ?? 'Apr',
      );
    });

    return YearStatistics(totalSpent, months);
  }

  @override
  Future storeMonthData() {
    // TODO: implement storeMonthData
    throw UnimplementedError();
  }

  @override
  Future storeWeekData() {
    // TODO: implement storeWeekData
    throw UnimplementedError();
  }
}
