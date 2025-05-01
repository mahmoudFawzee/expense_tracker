import 'package:expense_tracker/data/helper/interface/i_chart_type.dart';
import 'package:expense_tracker/presentation/screens/statistics/line_statistics_cubit/line_statistics_cubit.dart';

final class LineChart implements ChartTypeHelperInterface {
  @override
  final LineStatisticsCubit cubit;
  const LineChart(this.cubit);

  @override
  void fetchWeeklyStatistics() {
    cubit.fetchLineWeekStatistics();
  }

  @override
  void fetchYearlyStatistics() {
    cubit.fetchLineYearStatistics();
  }
}
