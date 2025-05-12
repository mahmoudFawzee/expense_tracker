import 'dart:developer';

import 'package:expense_tracker/presentation/components/custom_loading_indicator.dart';
import 'package:expense_tracker/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:expense_tracker/presentation/screens/auth/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LogoutIcon extends StatelessWidget {
  const LogoutIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        log('listener state: $state');
        if (state is LogoutSuccessState) {
          context.push(LoginScreen.pageRoute);
        }
      },
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const CustomLoadingIndicator(widgetHeight: 10);
          }
          return IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(const LogoutEvent());
            },
          );
        },
      ),
    );
  }
}
