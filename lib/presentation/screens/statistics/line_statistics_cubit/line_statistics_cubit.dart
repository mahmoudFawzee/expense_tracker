import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/repositories/statistics_repo.dart';
import 'package:expense_tracker/domain/entities/statistics/week_statistics.dart';
import 'package:expense_tracker/domain/entities/statistics/year_statistics.dart';

part 'line_statistics_state.dart';

class LineStatisticsCubit extends Cubit<LineStatisticsState> {
  LineStatisticsCubit(this._statisticsRepo)
      : super(const LineStatisticsInitial());
  final StatisticsRepo _statisticsRepo;

  //?this is the week days statistics
  void fetchLineWeekStatistics() async {
    try {
      final statistics = await _statisticsRepo.fetchStatisticsWeek();
      emit(FetchedLineWeekStatisticsState(statistics));
    } catch (e) {
      emit(LineStatisticsErrorState(e.toString()));
    }
  }

//?this is the year months statistics
  void fetchLineYearStatistics() async {
    try {
      final statistics = await _statisticsRepo.fetchStatisticsYear();
      emit(FetchedLineYearStatisticsState(statistics));
    } catch (e) {
      emit(LineStatisticsErrorState(e.toString()));
    }
  }
}
