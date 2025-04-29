import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/models/statistics/statistics_day/m_statistics_day.dart';
 class WeekStatistics extends Equatable{
  final List<StatisticsDayModel> days;
  final double totalSpent;
  
  const WeekStatistics(this.totalSpent, this.days);
  @override  
  List<Object?> get props => [days,totalSpent];
}
