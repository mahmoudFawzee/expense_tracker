import 'package:expense_tracker/logic/entities/models/expense/m_expense.dart';

abstract class ExpenseRepoInterface {
  Future addExpense(ExpenseModel expense);
  Future fetchExpenses();
  Future fetchExpense(int id);
  Future updateExpense(int id, {required ExpenseModel expense});
  Future deleteExpense(int id);
}
