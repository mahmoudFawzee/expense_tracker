import 'package:expense_tracker/logic/entities/category.dart';
import 'package:expense_tracker/logic/entities/models/category/m_category.dart';

abstract class CategoryInterface {
  Future<List<Category>> fetchCategories();
  Future<Map<String,double>> fetchCategoriesStatistics();
  Future fetchCategory(int id);
  Future addCategory(CategoryModel category);
  Future updateCategory(int id, {required CategoryModel category});
  Future deleteCategory(int id);
}
