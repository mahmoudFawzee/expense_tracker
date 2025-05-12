import 'package:expense_tracker/presentation/screens/categories/category_selection_cubit.dart';
import 'package:expense_tracker/app/cubits/is_logged_in_cubit.dart';
import 'package:expense_tracker/data/repositories/auth_repo.dart';
import 'package:expense_tracker/data/repositories/category_repo.dart';
import 'package:expense_tracker/data/repositories/statistics_repo.dart';
import 'package:expense_tracker/data/repositories/tokens_repo.dart';
import 'package:expense_tracker/data/repositories/user/local_user_repo_impl.dart';
import 'package:expense_tracker/data/repositories/user/remote_user_repo_impl.dart';
import 'package:expense_tracker/data/repositories/user/user_repo.dart';
import 'package:expense_tracker/data/services/auth/auth_service.dart';
import 'package:expense_tracker/data/services/expenses/category_service.dart';
import 'package:expense_tracker/data/services/statistics/local_statistics_service.dart';
import 'package:expense_tracker/data/services/statistics/statistics_service.dart';
import 'package:expense_tracker/data/services/user/remote_user_service_impl.dart';
import 'package:expense_tracker/data/services/user/local_user_service_impl.dart';
import 'package:expense_tracker/data/services/auth/token_service.dart';
import 'package:expense_tracker/presentation/components/app_bar/logout.dart';
import 'package:expense_tracker/presentation/components/app_bar/notifications.dart';
import 'package:expense_tracker/presentation/screens/auth/auth_base.dart';
import 'package:expense_tracker/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:expense_tracker/presentation/screens/auth/login/login_screen.dart';
import 'package:expense_tracker/presentation/screens/auth/register/register_screen.dart';
import 'package:expense_tracker/presentation/screens/base.dart';
import 'package:expense_tracker/presentation/screens/expense/expenses_screen.dart';
import 'package:expense_tracker/presentation/screens/profile/change_password_cubit/change_password_cubit.dart';
import 'package:expense_tracker/presentation/screens/profile/change_password_screen.dart';
import 'package:expense_tracker/presentation/screens/profile/user_data_bloc/user_data_bloc.dart';
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
final _tokensRepo = TokensRepo(TokensService());
final _localUserRepo = LocalUserRepoImpl(LocalUserServiceImpl());
final _remoteUserRepo =
    RemoteUserRepoImpl(RemoteUserServiceImpl(), _tokensRepo);
final _authRepo = AuthRepo(AuthService());
final _userRepo = UserDataRepo(_localUserRepo, _remoteUserRepo);

final _userDataBloc = UserDataBloc(_userRepo);
final _authBloc = AuthBloc(_authRepo, _userRepo, _tokensRepo);

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
        return BlocProvider.value(
          value: _authBloc,
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
        final path = state.fullPath;
        Widget actionIcon = const NotificationsIcon();
        if (path.toString() == ProfileScreen.pageRoute) {
          actionIcon = const LogoutIcon();
        }
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
            BlocProvider.value(value: _userDataBloc),
            BlocProvider.value(value: _authBloc),
          ],
          child: HomeBase(
            actionIcon: actionIcon,
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
          value: _userDataBloc,
          child: const ProfileInfoScreen(),
        );
      },
    ),
    GoRoute(
      path: ChangePasswordScreen.pageRoute,
      builder: (context, state) {
        return BlocProvider(
          create: (context) => ChangePasswordCubit(_userRepo),
          child: const ChangePasswordScreen(),
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
