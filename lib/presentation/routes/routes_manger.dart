import 'package:expense_tracker/presentation/screens/auth/auth_base.dart';
import 'package:expense_tracker/presentation/screens/auth/login_screen.dart';
import 'package:expense_tracker/presentation/screens/auth/register_screen.dart';
import 'package:expense_tracker/presentation/screens/home/base.dart';
import 'package:expense_tracker/presentation/screens/home/home_page.dart';
import 'package:expense_tracker/presentation/screens/home/profile_page.dart';
import 'package:expense_tracker/presentation/screens/home/statistics_page.dart';
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
          path: HomeScreen.pageRoute,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: ProfileScreen.pageRoute,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: StatisticsScreen.pageRoute,
          builder: (context, state) => const StatisticsScreen(),
        ),
      ],
    ),
  ],
);
