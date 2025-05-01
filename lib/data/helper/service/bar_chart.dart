import 'package:expense_tracker/data/helper/interface/i_chart_type.dart';
import 'package:expense_tracker/presentation/screens/statistics/bar_statistics_cubit/bar_statistics_cubit.dart';

final class BarChart implements ChartTypeHelperInterface {
  @override
  final BarStatisticsCubit cubit;
  const BarChart(this.cubit);
  @override
  void fetchWeeklyStatistics() {
    cubit.fetchBarWeekStatistics();
  }

  @override
  void fetchYearlyStatistics() {
    cubit.fetchBarYearStatistics();
  }
}
