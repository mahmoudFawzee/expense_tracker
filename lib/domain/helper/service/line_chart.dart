import 'package:expense_tracker/domain/helper/interface/i_chart_type.dart';
import 'package:expense_tracker/presentation/screens/statistics/line_statistics_cubit/line_statistics_cubit.dart';

final class LineChart implements ChartTypeHelper {
  @override
  final LineStatisticsCubit statisticsCubit;
  const LineChart(this.statisticsCubit);

  @override
  void fetchWeeklyStatistics() {
    statisticsCubit.fetchLineWeekStatistics();
  }

  @override
  void fetchYearlyStatistics() {
    statisticsCubit.fetchLineYearStatistics();
  }
}
