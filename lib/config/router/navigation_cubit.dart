import 'package:expense_tracker/presentation/screens/expense/expenses_screen.dart';
import 'package:expense_tracker/presentation/screens/profile/profile_screen.dart';
import 'package:expense_tracker/presentation/screens/statistics/statistics_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  static const _routes = [
    StatisticsScreen.pageRoute,
    ExpensesScreen.pageRoute,
    ProfileScreen.pageRoute,
  ];
  static List<String> get routes => _routes;
  NavigationCubit() : super(1);

  navigateTo(int index) => emit(index);
}
