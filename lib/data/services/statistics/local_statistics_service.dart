import 'package:expense_tracker/data/models/statistics/statistics_day/m_statistics_day.dart';
import 'package:expense_tracker/data/models/statistics/statistics_month/m_statistics_month.dart';
import 'package:expense_tracker/domain/entities/statistics/week/week_statistics.dart';
import 'package:expense_tracker/domain/entities/statistics/year/year_statistics.dart';

import 'package:expense_tracker/domain/services/statistics/i_local_statistics.dart';
import 'package:expense_tracker/core/util/maps/maps.dart';

final class LocalStatisticsService implements LocalStatisticsServiceInterface {
  @override
  Future<WeekStatistics?> fetchStatisticsWeek() async {
    // TODO: implement fetchStatisticsWeek
    double totalSpent = 100;
    final date = DateTime.now();
    final days = [
      StatisticsDayModel(amount: 15, date: date, name: 'Sat'),
      StatisticsDayModel(amount: 20, date: date, name: 'Sun'),
      StatisticsDayModel(amount: 10, date: date, name: 'Mon'),
      StatisticsDayModel(amount: 10, date: date, name: 'Tus'),
      StatisticsDayModel(amount: 5, date: date, name: 'Wen'),
      StatisticsDayModel(amount: 15, date: date, name: 'Thu'),
      StatisticsDayModel(amount: 25, date: date, name: 'Fri'),
    ];
    final List<double> amounts = days.map((item) {
      return item.amount;
    }).toList()..sort();
    return WeekStatistics(
      totalSpent: totalSpent,
      items: days,
      maxValue: amounts.last,
    );
  }

  @override
  Future<YearStatistics?> fetchStatisticsYear() async {
    // TODO: implement fetchStatisticsYear
    double totalSpent = 2626;
    final List<StatisticsMonthModel> months = [
      StatisticsMonthModel(
          amount: 15, date: DateTime.now(), name: monthsName[1] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 20, date: DateTime.now(), name: monthsName[2] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 10, date: DateTime.now(), name: monthsName[3] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 289, date: DateTime.now(), name: monthsName[4] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 850, date: DateTime.now(), name: monthsName[5] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 170, date: DateTime.now(), name: monthsName[6] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 25, date: DateTime.now(), name: monthsName[7] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 652, date: DateTime.now(), name: monthsName[8] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 30, date: DateTime.now(), name: monthsName[9] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 25, date: DateTime.now(), name: monthsName[10] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 500, date: DateTime.now(), name: monthsName[11] ?? 'Jan'),
      StatisticsMonthModel(
          amount: 400, date: DateTime.now(), name: monthsName[12] ?? 'Jan'),
    ];
final List<double> amounts = months.map((item) {
      return item.amount;
    }).toList()
      ..sort();
    return YearStatistics(
      totalSpent: totalSpent,
      items: months,
      maxValue: amounts.last,
    );
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
