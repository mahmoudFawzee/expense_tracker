import 'package:expense_tracker/app/cubits/category_selection_cubit.dart';
import 'package:expense_tracker/app/cubits/is_logged_in_cubit.dart';
import 'package:expense_tracker/data/repositories/auth_repo.dart';
import 'package:expense_tracker/data/repositories/category_repo.dart';
import 'package:expense_tracker/data/repositories/statistics_repo.dart';
import 'package:expense_tracker/data/repositories/tokens_repo.dart';
import 'package:expense_tracker/data/repositories/user_repo.dart';
import 'package:expense_tracker/data/services/apis/auth_service.dart';
import 'package:expense_tracker/data/services/apis/category_service.dart';
import 'package:expense_tracker/data/services/apis/statistics_service.dart';
import 'package:expense_tracker/data/services/apis/user_service.dart';
import 'package:expense_tracker/data/services/local/local_user_service.dart';
import 'package:expense_tracker/data/services/local/statistics_service.dart';
import 'package:expense_tracker/data/services/local/token_service.dart';
import 'package:expense_tracker/presentation/screens/auth/auth_base.dart';
import 'package:expense_tracker/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:expense_tracker/presentation/screens/auth/login/login_screen.dart';
import 'package:expense_tracker/presentation/screens/auth/register/register_screen.dart';
import 'package:expense_tracker/presentation/screens/base.dart';
import 'package:expense_tracker/presentation/screens/expense/expenses_screen.dart';
import 'package:expense_tracker/presentation/screens/profile/bloc/user_data_bloc.dart';
import 'package:expense_tracker/presentation/screens/profile/profile_info_screen.dart';
import 'package:expense_tracker/presentation/screens/profile/profile_screen.dart';
import 'package:expense_tracker/presentation/screens/statistics/bar_statistics_cubit/bar_statistics_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/line_statistics_cubit/line_statistics_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/pie_statistics_cubit/category_statistics_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/statistics_screen.dart';
import 'package:expense_tracker/presentation/screens/start/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final _categoryRepo = CategoryRepo(CategoryService());
final _statisticsRepo = StatisticsRepo(
  remoteStatisticsService: RemoteStatisticsService(),
  localStatisticsService: LocalStatisticsService(),
);
final _authRepo = AuthRepo(AuthService());
final _userRepo = UserDataRepo(LocalUserService(), UserServiceApi());
final _tokensRepo = TokensRepo(TokensService());

final _userDataBloc = UserDataBloc(_userRepo);

final router = GoRouter(
  initialLocation: SplashScreen.pageRoute,
  routes: [
    GoRoute(
      path: SplashScreen.pageRoute,
      builder: (context, state) => BlocProvider(
        create: (context) => IsLoggedInCubit(_tokensRepo),
        child: const SplashScreen(),
      ),
    ),
    ShellRoute(
      navigatorKey: GlobalKey<NavigatorState>(),
      builder: (context, state, child) {
        return BlocProvider(
          create: (context) => AuthBloc(_authRepo, _userRepo, _tokensRepo),
          child: AuthBase(child: child),
        );
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
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => CategorySelectionCubit(),
            ),
            BlocProvider(
              create: (context) => CategoryStatisticsCubit(_categoryRepo)
                ..fetchCategoriesStatistics(),
            ),
            BlocProvider(
              create: (context) =>
                  BarStatisticsCubit(_statisticsRepo)..fetchBarWeekStatistics(),
            ),
            BlocProvider(
              create: (context) => LineStatisticsCubit(_statisticsRepo)
                ..fetchLineWeekStatistics(),
            ),
          ],
          child: HomeBase(
            child: child,
          ),
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
    GoRoute(
      path: ProfileInfoScreen.pageRoute,
      builder: (context, state) {
        return BlocProvider.value(
          value: _userDataBloc..add(const FetchUserDataEvent()),
          child: const ProfileInfoScreen(),
        );
      },
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
