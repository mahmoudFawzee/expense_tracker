import 'package:expense_tracker/domain/entities/category.dart';
import 'package:expense_tracker/data/models/category/m_category.dart';
import 'package:expense_tracker/domain/services/category/i_category.dart';

final class CategoryService implements CategoryServiceInterface {
  @override
  Future addCategory(CategoryModel category) async {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future deleteCategory(int id) async {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future fetchCategory(int id) async {
    // TODO: implement getCategory
    throw UnimplementedError();
  }

  @override
  Future<List<Category>> fetchCategories() async {
    return [
      const Category(
        title: 'food',
        imgUrl: '',
        spendMony: 50,
      ),
      const Category(
        title: 'Transport',
        imgUrl: '',
        spendMony: 16,
      ),
      const Category(
        title: 'Rents',
        imgUrl: '',
        spendMony: 24,
      ),
      const Category(
        title: 'Learning',
        imgUrl: '',
        spendMony: 10,
      ),
    ];
  }

  @override
  Future updateCategory(int id, {required CategoryModel category}) async {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }

  @override
  Future<Map<String, double>> fetchCategoriesStatistics() async {
    // TODO: implement fetchCategoriesStatistics
    final Map<String, double> result = {
      'food': 5000,
      'Transport': 1600,
      'Rents': 2400,
      'Learning': 100,
    };
    return result;
  }
}
