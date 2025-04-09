import 'package:expense_tracker/logic/entities/category.dart';
import 'package:json_annotation/json_annotation.dart';
part 'm_category.g.dart';

@JsonSerializable()
final class CategoryModel extends Category{
  const CategoryModel(super.title);
  factory CategoryModel.fromJson(Map<String, dynamic> json) =>
      _$CategoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryModelToJson(this);
}
