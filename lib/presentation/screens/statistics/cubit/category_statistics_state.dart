part of 'category_statistics_cubit.dart';

sealed class CategoryStatisticsState extends Equatable {
  const CategoryStatisticsState();

  @override
  List<Object> get props => [];
}

final class CategoriesStatisticsInitialState extends CategoryStatisticsState {
  const CategoriesStatisticsInitialState();
}

final class CategoriesStatisticsLoadingState extends CategoryStatisticsState {
  const CategoriesStatisticsLoadingState();
}

final class CategoriesStatisticsErrorState extends CategoryStatisticsState {
  final String error;
  const CategoriesStatisticsErrorState(this.error);
  @override
  List<Object> get props => [error];
}

final class FetchedCategoriesStatisticsState extends CategoryStatisticsState {
  final Map<String,double> categoriesStatistics;
  const FetchedCategoriesStatisticsState(this.categoriesStatistics);
  @override
  List<Object> get props => [categoriesStatistics];
}
