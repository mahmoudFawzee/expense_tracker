import 'package:expense_tracker/data/models/expense/m_expense.dart';
import 'package:expense_tracker/domain/entities/expense.dart';
import 'package:expense_tracker/domain/services/expense/i_expense.dart';

final class ExpenseService implements ExpenseServiceInterface {
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
  Future<List<Expense>> fetchExpenses() {
    // TODO: implement listExpenses
    throw UnimplementedError();
  }

  @override
  Future updateExpense(int id, {required ExpenseModel expense}) {
    // TODO: implement updateExpense
    throw UnimplementedError();
  }
}
