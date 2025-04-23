part of 'expense_bloc.dart';

sealed class ExpenseState extends Equatable {
  const ExpenseState();

  @override
  List<Object> get props => [];
}

final class ExpenseInitialState extends ExpenseState {
  const ExpenseInitialState();
}

final class ExpenseLoadingState extends ExpenseState {
  const ExpenseLoadingState();
}

final class ExpenseErrorState extends ExpenseState {
  final String error;
  const ExpenseErrorState(this.error);
  @override
  List<Object> get props => [error];
}

final class FetchedExpensesState extends ExpenseState {
  final List<Expense> expenses;
  const FetchedExpensesState(this.expenses);
  @override
  List<Object> get props => [expenses];
}

final class GotExpenseState extends ExpenseState {
  final Expense expense;
  const GotExpenseState(this.expense);
  @override
  List<Object> get props => [expense];
}

final class AddedExpenseState extends ExpenseState {
  const AddedExpenseState();
}

final class UpdatedExpenseState extends ExpenseState {
  const UpdatedExpenseState();
}

final class DeletedExpenseState extends ExpenseState {
  const DeletedExpenseState();
}
