import 'package:expense_tracker/logic/entities/models/category/m_category.dart';
import 'package:expense_tracker/data/services/category_service.dart';
import 'package:expense_tracker/logic/entities/category.dart';
import 'package:expense_tracker/logic/repositories/i_category_repo.dart';

final class CategoryRepo implements CategoryRepoInterface {
  final CategoryService _categoryService;
  const CategoryRepo(this._categoryService);

  @override
  Future addCategory(CategoryModel category) async =>
      await _categoryService.addCategory(category);

  @override
  Future deleteCategory(int id) async =>
      await _categoryService.deleteCategory(id);

  @override
  Future<Category> fetchCategory(int id) async =>
      await _categoryService.fetchCategory(id);

  @override
  Future<List<Category>> fetchCategories() async =>
      await _categoryService.fetchCategories();

  @override
  Future updateCategory(int id, {required CategoryModel category}) async =>
      await _categoryService.updateCategory(id, category: category);

  @override
  Future<Map<String, double>> fetchCategoriesStatistics() async =>
      _categoryService.fetchCategoriesStatistics();
}
