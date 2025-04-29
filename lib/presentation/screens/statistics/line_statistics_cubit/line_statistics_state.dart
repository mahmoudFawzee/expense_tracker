part of 'line_statistics_cubit.dart';

sealed class LineStatisticsState extends Equatable {
  const LineStatisticsState();

  @override
  List<Object> get props => [];
}

final class LineStatisticsInitial extends LineStatisticsState {
  const LineStatisticsInitial();
}

final class LineStatisticsLoading extends LineStatisticsState {
  const LineStatisticsLoading();
}

final class LineStatisticsErrorState extends LineStatisticsState {
  final String error;
  const LineStatisticsErrorState(this.error);
  @override
  List<Object> get props => [error];
}

final class FetchedLineWeekStatisticsState extends LineStatisticsState {
  final WeekStatistics weekStatistics;
  const FetchedLineWeekStatisticsState(this.weekStatistics);
  @override
  List<Object> get props => [weekStatistics];
}

final class FetchedLineYearStatisticsState extends LineStatisticsState {
  final YearStatistics statistics;
  const FetchedLineYearStatisticsState(this.statistics);
  @override
  List<Object> get props => [statistics];
}
