import 'package:expense_tracker/data/models/category/m_category.dart';

abstract class CategoryRepoInterface {
  Future fetchCategories();
  Future fetchCategory(int id);
  Future addCategory(CategoryModel category);
  Future updateCategory(int id, {required CategoryModel category});
  Future deleteCategory(int id);
}
