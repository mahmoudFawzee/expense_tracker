import 'package:expense_tracker/domain/helper/interface/i_chart_type.dart';
import 'package:expense_tracker/presentation/components/statistics/cubit/statistics_item_details_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/bar_statistics_cubit/bar_statistics_cubit.dart';

final class BarChart implements ChartTypeHelper {
  @override
  final StatisticsItemDetailsCubit itemDetailsCubit;
  @override
  final BarStatisticsCubit statisticsCubit;
  const BarChart(
    this.statisticsCubit, {
    required this.itemDetailsCubit,
  });
  @override
  void fetchWeeklyStatistics() {
    statisticsCubit.fetchBarWeekStatistics();
    itemDetailsCubit.deSelect();
  }

  @override
  void fetchYearlyStatistics() {
    statisticsCubit.fetchBarYearStatistics();
    itemDetailsCubit.deSelect();
  }
}
