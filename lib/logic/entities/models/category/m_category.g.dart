// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryModel _$CategoryModelFromJson(Map<String, dynamic> json) =>
    CategoryModel(
      spendMony: (json['spendMony'] as num).toDouble(),
      title: json['title'] as String,
      imgUrl: json['imgUrl'] as String,
    );

Map<String, dynamic> _$CategoryModelToJson(CategoryModel instance) =>
    <String, dynamic>{
      'imgUrl': instance.imgUrl,
      'title': instance.title,
      'spendMony': instance.spendMony,
    };
