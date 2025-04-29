import 'package:expense_tracker/data/models/expense/m_expense.dart';
import 'package:expense_tracker/data/repositories/expense_repo.dart';
import 'package:expense_tracker/domain/entities/expense.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepo expenseReps;

  ExpenseBloc(this.expenseReps) : super(const ExpenseInitialState()) {
    on<FetchExpenseEvent>((event, emit) async {
      emit(const ExpenseLoadingState());
      try {
        final expenses = await expenseReps.fetchExpenses();
        emit(FetchedExpensesState(expenses));
      } catch (e) {
        emit(ExpenseErrorState(e.toString()));
      }
    });

    on<FetchExpenseEvent>((event, emit) async {
      emit(const ExpenseLoadingState());
      try {
        final expense = await expenseReps.fetchExpense(event.id);
        emit(FetchedExpensesState(expense));
      } catch (e) {
        emit(ExpenseErrorState(e.toString()));
      }
    });
    on<AddExpenseEvent>((event, emit) async {
      emit(const ExpenseLoadingState());
      try {
        await expenseReps.addExpense(event.expenseModel);
        emit(const AddedExpenseState());
      } catch (e) {
        emit(ExpenseErrorState(e.toString()));
      }
    });

    on<UpdateExpenseEvent>((event, emit) async {
      emit(const ExpenseLoadingState());
      try {
        await expenseReps.updateExpense(event.id, expense: event.expenseModel);
        emit(const UpdatedExpenseState());
      } catch (e) {
        emit(ExpenseErrorState(e.toString()));
      }
    });

    on<DeleteExpenseEvent>((event, emit) async {
      emit(const ExpenseLoadingState());
      try {
        await expenseReps.deleteExpense(event.id);
        emit(const DeletedExpenseState());
      } catch (e) {
        emit(ExpenseErrorState(e.toString()));
      }
    });
  }
}
