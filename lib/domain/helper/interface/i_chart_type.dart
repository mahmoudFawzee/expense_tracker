import 'package:expense_tracker/presentation/components/statistics/cubit/statistics_item_details_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ChartTypeHelper {
  Cubit get statisticsCubit;
  StatisticsItemDetailsCubit get itemDetailsCubit;
  void fetchWeeklyStatistics();
  void fetchYearlyStatistics();
}
