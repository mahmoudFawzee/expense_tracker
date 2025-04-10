import 'package:expense_tracker/logic/entities/category.dart';
import 'package:expense_tracker/presentation/resources/image_manger.dart';

const List<Category> categoriesList = [
  Category(id: 1, title: 'food', imgUrl: ImageManger.appLogo),
  Category(
    id: 2,
    title: 'shopping',
    imgUrl: ImageManger.appLogo,
  ),
  Category(
    id: 3,
    title: 'transport',
    imgUrl: ImageManger.appLogo,
  ),
  Category(
    id: 4,
    title: 'clothes',
    imgUrl: ImageManger.appLogo,
  ),
  Category(
    id: 5,
    title: 'sports',
    imgUrl: ImageManger.appLogo,
  ),
];

List<Category> handleCategories(List<Category> backEndCategories) {
  return [
    const Category(
      id: null,
      title: 'all',
      imgUrl: ImageManger.appLogo,
    ),
    ...backEndCategories,
  ];
}
