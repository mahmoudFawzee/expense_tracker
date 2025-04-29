import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:expense_tracker/data/repositories/category_repo.dart';

part 'category_statistics_state.dart';

class CategoryStatisticsCubit extends Cubit<CategoryStatisticsState> {
  final CategoryRepo _categoryRepo;
  CategoryStatisticsCubit(
    this._categoryRepo,
  ) : super(const CategoriesStatisticsInitialState());

  Future fetchCategoriesStatistics() async {
    emit(const CategoriesStatisticsLoadingState());
    try {
      final categories = await _categoryRepo.fetchCategoriesStatistics();
      emit(FetchedCategoriesStatisticsState(categories));
    } catch (e) {
      emit(CategoriesStatisticsErrorState(e.toString()));
    }
  }
}
