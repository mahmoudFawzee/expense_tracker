import 'package:expense_tracker/data/models/expense/m_expense.dart';
import 'package:expense_tracker/data/services/expense_service.dart';
import 'package:expense_tracker/logic/repositories/i_expense_repo.dart';

final class ExpenseReps implements ExpenseRepoInterface {
  final ExpenseService _expenseService;
  const ExpenseReps(ExpenseService expenseService)
      : _expenseService = expenseService;
  @override
  Future addExpense(ExpenseModel expense) async =>
      _expenseService.addExpense(expense);

  @override
  Future deleteExpense(int id) async => _expenseService.deleteExpense(id);

  @override
  Future getExpense(int id) async => _expenseService.getExpense(id);

  @override
  Future listExpenses() async => _expenseService.listExpenses();

  @override
  Future updateExpense(int id, {required ExpenseModel expense}) async =>
      _expenseService.updateExpense(id, expense: expense);
}
