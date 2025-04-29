import 'package:expense_tracker/data/models/category/m_category.dart';
import 'package:expense_tracker/data/repositories/category_repo.dart';
import 'package:expense_tracker/domain/entities/category.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  final CategoryRepo categoryRepo;
  CategoryCubit(this.categoryRepo) : super(const CategoryInitialState());
  void fetchCategory(int id) async {
    emit(const CategoryLoadingState());
    try {
      final category = await categoryRepo.fetchCategory(id);
      emit(FetchedCategoryState(category));
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }

  void fetchCategories() async {
    emit(const CategoryLoadingState());
    try {
      final categories = await categoryRepo.fetchCategories();
      emit(FetchedCategoriesState(categories));
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }

  void addCategory(CategoryModel category) async {
    emit(const CategoryLoadingState());
    try {
      await categoryRepo.addCategory(category);
      emit(const AddedCategoryState());
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }

  void deleteCategory(int id) async {
    emit(const CategoryLoadingState());
    try {
      await categoryRepo.deleteCategory(id);
      emit(const DeletedCategoryState());
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }

  void updateCategory(int id, {required CategoryModel category}) async {
    emit(const CategoryLoadingState());
    try {
      await categoryRepo.updateCategory(id, category: category);
      emit(const UpdatedCategoryState());
    } catch (e) {
      emit(CategoryErrorState(e.toString()));
    }
  }
}
