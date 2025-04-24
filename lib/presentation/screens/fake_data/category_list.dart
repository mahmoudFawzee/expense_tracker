import 'package:expense_tracker/logic/entities/category.dart';
import 'package:expense_tracker/presentation/resources/image_manger.dart';

const List<Category> categoriesList = [
  Category(
    id: 1,
    title: 'food',
    spendMony: 35,
    imgUrl: ImageManger.appLogo,
  ),
  Category(
    id: 2,
    title: 'shopping',
    spendMony: 15,
    imgUrl: ImageManger.appLogo,
  ),
  Category(
    id: 3,
    title: 'transport',
    spendMony: 10,
    imgUrl: ImageManger.appLogo,
  ),
  Category(
    id: 4,
    title: 'clothes',
    spendMony: 13,
    imgUrl: ImageManger.appLogo,
  ),
  Category(
    id: 5,
    title: 'sports',
    spendMony: 20,
    imgUrl: ImageManger.appLogo,
  ),
];

List<Category> handleCategories(List<Category> backEndCategories) {
  return [
    const Category(
      id: null,
      title: 'all',
      spendMony: 50,
      imgUrl: ImageManger.appLogo,
    ),
    ...backEndCategories,
  ];
}
