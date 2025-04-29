import 'package:equatable/equatable.dart';

class StatisticsMonth extends Equatable {
  final String monthName;
  final double amount;
  final DateTime date;
  const StatisticsMonth({
    required this.amount,
    required this.date,
    required this.monthName,
  });
  @override
  List<Object?> get props => [monthName, amount, date];
}
