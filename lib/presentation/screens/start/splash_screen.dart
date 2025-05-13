import 'package:expense_tracker/presentation/screens/start/is_logged_in_cubit/is_logged_in_cubit.dart';
import 'package:expense_tracker/config/resources/image_manger.dart';
import 'package:expense_tracker/presentation/screens/auth/login/login_screen.dart';
import 'package:expense_tracker/presentation/screens/expense/expenses_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const pageRoute = '/splash_page';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      // ignore: use_build_context_synchronously
      context.read<IsLoggedInCubit>().isLoggedIn();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<IsLoggedInCubit, bool?>(
      listener: (context, isLoggedIn) {
        if (isLoggedIn == null) {
          return;
        }
        if (!isLoggedIn) {
          context.go(LoginScreen.pageRoute);
          return;
        }
        context.go(ExpensesScreen.pageRoute);
      },
      child: Scaffold(
        body: Center(
          child: Image.asset(ImageManger.appLogo),
        ),
      ),
    );
  }
}
