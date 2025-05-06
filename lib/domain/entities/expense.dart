import 'package:expense_tracker/data/models/category/m_category.dart';
import 'package:expense_tracker/domain/entities/category.dart';

class Expense {
  //?when we create the expense object we won't need to
  //?provide an id so no problem to make it null.
  final int? _id = null;
  final String title, notes;
  final double amount;
  final CategoryModel _category;
  final DateTime date;

  const Expense({
    required this.title,
    required this.amount,
    required CategoryModel category,
    required this.date,
    required this.notes,
  }) : _category = category;
  int? get id => _id;

  Category get category => _category;
}