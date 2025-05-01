import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ChartTypeHelperInterface {
  Cubit get cubit;
  void fetchWeeklyStatistics();
  void fetchYearlyStatistics();
}
