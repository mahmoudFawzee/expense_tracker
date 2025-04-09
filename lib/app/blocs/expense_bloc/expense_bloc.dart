import 'package:expense_tracker/data/repositories/expense_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'expense_event.dart';
part 'expense_state.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  final ExpenseRepo expenseReps;

  ExpenseBloc(this.expenseReps) : super(ExpenseInitial()) {
    on<ExpenseEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
