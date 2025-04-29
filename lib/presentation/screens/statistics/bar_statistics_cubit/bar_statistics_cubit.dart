import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/repositories/statistics_repo.dart';
import 'package:expense_tracker/domain/entities/statistics/week_statistics.dart';
import 'package:expense_tracker/domain/entities/statistics/year_statistics.dart';

part 'bar_statistics_state.dart';

class BarStatisticsCubit extends Cubit<BarStatisticsState> {
  BarStatisticsCubit(this._statisticsRepo)
      : super(const BarStatisticsInitial());
  final StatisticsRepo _statisticsRepo;

//?this is the week days statistics
  void fetchBarWeekStatistics() async {
    emit(const BarStatisticsLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      final statistics = await _statisticsRepo.fetchStatisticsWeek();

      emit(FetchedBarWeekStatisticsState(statistics));
    } catch (e) {
      emit(BarStatisticsErrorState(e.toString()));
    }
  }

//?this is the year months statistics
  void fetchBarYearStatistics() async {
    try {
      final statistics = await _statisticsRepo.fetchStatisticsYear();
      emit(FetchedBarYearStatisticsState(statistics));
    } catch (e) {
      emit(BarStatisticsErrorState(e.toString()));
    }
  }
}
