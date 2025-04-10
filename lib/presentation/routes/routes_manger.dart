import 'package:expense_tracker/presentation/screens/auth/auth_base.dart';
import 'package:expense_tracker/presentation/screens/auth/login_screen.dart';
import 'package:expense_tracker/presentation/screens/auth/register_screen.dart';
import 'package:expense_tracker/presentation/screens/base.dart';
import 'package:expense_tracker/presentation/screens/expense/expenses_screen.dart';
import 'package:expense_tracker/presentation/screens/profile/profile_screen.dart';
import 'package:expense_tracker/presentation/screens/statistics/statistics_screen.dart';
import 'package:expense_tracker/presentation/screens/start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: SplashScreen.pageRoute,
  routes: [
    GoRoute(
      path: SplashScreen.pageRoute,
      builder: (context, state) => const SplashScreen(),
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return AuthBase(child: child);
      },
      routes: [
        GoRoute(
          path: RegisterScreen.pageRoute,
          builder: (context, state) {
            return const RegisterScreen();
          },
        ),
        GoRoute(
          path: LoginScreen.pageRoute,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return HomeBase(
          child: child,
        );
      },
      routes: [
        GoRoute(
          path: ExpensesScreen.pageRoute,
          pageBuilder: (context, state) {
            return _buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const ExpensesScreen(),
            );
          },
        ),
        GoRoute(
          path: ProfileScreen.pageRoute,
          pageBuilder: (context, state) {
            return _buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const ProfileScreen(),
            );
          },
        ),
        GoRoute(
          path: StatisticsScreen.pageRoute,
          pageBuilder: (context, state) {
            return _buildPageWithDefaultTransition(
              context: context,
              state: state,
              child: const StatisticsScreen(),
            );
          },
        ),
      ],
    ),
  ],
);

CustomTransitionPage _buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
