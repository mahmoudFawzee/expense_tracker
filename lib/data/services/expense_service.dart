import 'package:expense_tracker/data/models/expense/m_expense.dart';
import 'package:expense_tracker/logic/services/i_expense.dart';

final class ExpenseService implements ExpenseInterface {
  @override
  Future addExpense(ExpenseModel expense) {
    // TODO: implement addExpense
    throw UnimplementedError();
  }

  @override
  Future deleteExpense(int id) {
    // TODO: implement deleteExpense
    throw UnimplementedError();
  }

  @override
  Future getExpense(int id) {
    // TODO: implement getExpense
    throw UnimplementedError();
  }

  @override
  Future listExpenses() {
    // TODO: implement listExpenses
    throw UnimplementedError();
  }

  @override
  Future updateExpense(int id, {required ExpenseModel expense}) {
    // TODO: implement updateExpense
    throw UnimplementedError();
  }
}