import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ChartTypeHelper {
  Cubit get statisticsCubit;
  void fetchWeeklyStatistics();
  void fetchYearlyStatistics();
}
