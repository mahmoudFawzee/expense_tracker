import 'package:expense_tracker/data/models/category/m_category.dart';
import 'package:expense_tracker/data/services/category_service.dart';
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
  Future getCategory(int id) async => await _categoryService.getCategory(id);

  @override
  Future listCategories() async => await _categoryService.listCategories();

  @override
  Future updateCategory(int id, {required CategoryModel category}) async =>
      await _categoryService.updateCategory(id, category: category);
}
