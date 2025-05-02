import 'package:expense_tracker/domain/helper/interface/i_chart_type.dart';
import 'package:expense_tracker/presentation/components/statistics/bar_statistics/bar_details_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/bar_statistics_cubit/bar_statistics_cubit.dart';

final class BarChart implements ChartTypeHelper {
  final StatisticsItemDetailsCubit barDetailsCubit;
  @override
  final BarStatisticsCubit statisticsCubit;
  const BarChart(
    this.statisticsCubit, {
    required this.barDetailsCubit,
  });
  @override
  void fetchWeeklyStatistics() {
    statisticsCubit.fetchBarWeekStatistics();
    barDetailsCubit.deSelect();
  }

  @override
  void fetchYearlyStatistics() {
    statisticsCubit.fetchBarYearStatistics();
    barDetailsCubit.deSelect();
  }
}
