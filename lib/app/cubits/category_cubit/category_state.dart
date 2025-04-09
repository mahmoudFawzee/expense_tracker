part of 'category_cubit.dart';

sealed class CategoryState extends Equatable {
  const CategoryState();

  @override
  List<Object> get props => [];
}

final class CategoryInitialState extends CategoryState {
  const CategoryInitialState();
}

final class CategoryLoadingState extends CategoryState {
  const CategoryLoadingState();
}

final class CategoryErrorState extends CategoryState {
  final String error;
  const CategoryErrorState(this.error);
  @override
  List<Object> get props => [error];
}

final class FetchedCategoriesState extends CategoryState {
  final List<Category> categories;
  const FetchedCategoriesState(this.categories);
  @override
  List<Object> get props => [categories];
}

final class FetchedCategoryState extends CategoryState {
  final Category category;
  const FetchedCategoryState(this.category);
  @override
  List<Object> get props => [category];
}

final class AddedCategoryState extends CategoryState {
  const AddedCategoryState();
}

final class UpdatedCategoryState extends CategoryState {
  const UpdatedCategoryState();
}

final class DeletedCategoryState extends CategoryState {
  const DeletedCategoryState();
}
