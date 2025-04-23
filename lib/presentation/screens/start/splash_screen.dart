import 'package:expense_tracker/presentation/screens/auth/register/register_screen.dart';
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
    Future.delayed(const Duration(microseconds: 100), () {
      // ignore: use_build_context_synchronously
      context.go(RegisterScreen.pageRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
