import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/statistics/statistics_month/m_statistics_month.dart';



 class YearStatistics extends Equatable{
  final List<StatisticsMonthModel> months;
  final double totalSpent;
  const YearStatistics(this.totalSpent, this.months);
  @override  
  List<Object?> get props => [months,totalSpent];
}
