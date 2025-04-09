import 'package:expense_tracker/data/models/expense/m_expense.dart';
import 'package:expense_tracker/data/services/expense_service.dart';
import 'package:expense_tracker/logic/repositories/i_expense_repo.dart';

final class ExpenseRepo implements ExpenseRepoInterface {
  final ExpenseService _expenseService;
  const ExpenseRepo(ExpenseService expenseService)
      : _expenseService = expenseService;
  @override
  Future addExpense(ExpenseModel expense) async =>
      await _expenseService.addExpense(expense);

  @override
  Future deleteExpense(int id) async => await _expenseService.deleteExpense(id);

  @override
  Future getExpense(int id) async => await _expenseService.getExpense(id);

  @override
  Future listExpenses() async => await _expenseService.listExpenses();

  @override
  Future updateExpense(int id, {required ExpenseModel expense}) async =>
      await _expenseService.updateExpense(id, expense: expense);
}
