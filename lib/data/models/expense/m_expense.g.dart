// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'm_expense.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseModel _$ExpenseModelFromJson(Map<String, dynamic> json) => ExpenseModel(
      title: json['title'] as String,
      amount: (json['amount'] as num).toDouble(),
      category:
          CategoryModel.fromJson(json['category'] as Map<String, dynamic>),
      date: DateTime.parse(json['date'] as String),
      notes: json['notes'] as String,
    );

Map<String, dynamic> _$ExpenseModelToJson(ExpenseModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'notes': instance.notes,
      'amount': instance.amount,
      'category': instance.category,
      'date': instance.date.toIso8601String(),
    };
