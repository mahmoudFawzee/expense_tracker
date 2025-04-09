import 'package:expense_tracker/data/models/expense/m_expense.dart';

abstract class ExpenseInterface {
  Future addExpense(ExpenseModel expense);
  Future listExpenses();
  Future getExpense(int id);
  Future updateExpense(int id, {required ExpenseModel expense});
  Future deleteExpense(int id);
}
