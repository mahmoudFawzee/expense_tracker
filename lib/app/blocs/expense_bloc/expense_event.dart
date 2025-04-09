part of 'expense_bloc.dart';

sealed class ExpenseEvent extends Equatable {
  const ExpenseEvent();

  @override
  List<Object> get props => [];
}

sealed class FetchExpensesEvent extends ExpenseEvent {
  const FetchExpensesEvent();
}

sealed class FetchExpenseEvent extends ExpenseEvent {
  final int id;
  const FetchExpenseEvent(this.id);
  @override
  List<Object> get props => [id];
}

sealed class AddExpenseEvent extends ExpenseEvent {
  final ExpenseModel expenseModel;
  const AddExpenseEvent(this.expenseModel);
  @override
  List<Object> get props => [expenseModel];
}

sealed class UpdateExpenseEvent extends ExpenseEvent {
  final int id;
  final ExpenseModel expenseModel;
  const UpdateExpenseEvent(this.id, {required this.expenseModel});
  @override
  List<Object> get props => [id, expenseModel];
}

sealed class DeleteExpenseEvent extends ExpenseEvent {
  final int id;
  const DeleteExpenseEvent(this.id);
  @override
  List<Object> get props => [id];
}
