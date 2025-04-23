import 'package:expense_tracker/logic/entities/models/expense/m_expense.dart';

abstract class ExpenseInterface {
  Future addExpense(ExpenseModel expense);
  Future fetchExpenses();
  Future getExpense(int id);
  Future updateExpense(int id, {required ExpenseModel expense});
  Future deleteExpense(int id);
}
