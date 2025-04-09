import 'package:expense_tracker/data/models/category/m_category.dart';
import 'package:expense_tracker/data/services/category_service.dart';
import 'package:expense_tracker/logic/repositories/i_category_repo.dart';

final class CategoryRepo implements CategoryRepoInterface {
  final CategoryService _categoryService;
  const CategoryRepo(this._categoryService);

  @override
  Future addCategory(CategoryModel category) {
    // TODO: implement addCategory
    throw UnimplementedError();
  }

  @override
  Future deleteCategory(int id) {
    // TODO: implement deleteCategory
    throw UnimplementedError();
  }

  @override
  Future getCategory(int id) {
    // TODO: implement getCategory
    throw UnimplementedError();
  }

  @override
  Future listCategories() {
    // TODO: implement listCategories
    throw UnimplementedError();
  }

  @override
  Future updateCategory(int id, {required CategoryModel category}) {
    // TODO: implement updateCategory
    throw UnimplementedError();
  }
  }
