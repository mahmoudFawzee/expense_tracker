import 'package:equatable/equatable.dart';

class StatisticsDay extends Equatable {
  final String dayName;
  final double amount;
  final DateTime date;
  const StatisticsDay({
    required this.amount,
    required this.date,
    required this.dayName,
  });
  @override
  List<Object?> get props => [dayName, amount, date];
}
