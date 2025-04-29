part of 'bar_statistics_cubit.dart';

sealed class BarStatisticsState extends Equatable {
  const BarStatisticsState();

  @override
  List<Object> get props => [];
}

final class BarStatisticsInitial extends BarStatisticsState {
  const BarStatisticsInitial();
}

final class BarStatisticsLoading extends BarStatisticsState {
  const BarStatisticsLoading();
}

final class BarStatisticsErrorState extends BarStatisticsState {
  final String error;
  const BarStatisticsErrorState(this.error);
  @override
  List<Object> get props => [error];
}

final class FetchedBarWeekStatisticsState extends BarStatisticsState {
  final WeekStatistics statistics;
  const FetchedBarWeekStatisticsState(this.statistics);
  @override
  List<Object> get props => [statistics];
}

final class FetchedBarYearStatisticsState extends BarStatisticsState {
  final YearStatistics statistics;
  const FetchedBarYearStatisticsState(this.statistics);
  @override
  List<Object> get props => [statistics];
}
