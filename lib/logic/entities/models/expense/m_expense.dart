import 'package:expense_tracker/logic/entities/models/category/m_category.dart';
import 'package:expense_tracker/logic/entities/expense.dart';
import 'package:json_annotation/json_annotation.dart';


part 'm_expense.g.dart';

@JsonSerializable()
final class ExpenseModel extends Expense {
  const ExpenseModel({
    required super.title,
    required super.amount,
    required super.category,
    required super.date,
    required super.notes,
  });
  factory ExpenseModel.fromJson(Map<String, dynamic> json) =>
      _$ExpenseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseModelToJson(this);
}
