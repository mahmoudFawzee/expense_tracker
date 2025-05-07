import 'package:expense_tracker/domain/helper/i_chart_type.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_item_details_cubit/statistics_item_details_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/line_statistics_cubit/line_statistics_cubit.dart';

final class LineChart implements ChartTypeHelper {
  @override
  final StatisticsItemDetailsCubit itemDetailsCubit;
  @override
  final LineStatisticsCubit statisticsCubit;
  const LineChart(this.statisticsCubit, {required this.itemDetailsCubit});

  @override
  void fetchWeeklyStatistics() {
    statisticsCubit.fetchLineWeekStatistics();
    itemDetailsCubit.deSelect();
  }

  @override
  void fetchYearlyStatistics() {
    statisticsCubit.fetchLineYearStatistics();
    itemDetailsCubit.deSelect();
  }
}
