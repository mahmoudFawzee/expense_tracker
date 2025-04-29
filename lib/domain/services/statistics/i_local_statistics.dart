import 'package:expense_tracker/domain/services/statistics/i_statistics.dart';

abstract class LocalStatisticsServiceInterface
    extends StatisticsServiceInterface {
  Future storeWeekData();
  Future storeMonthData();
}
