import 'dart:developer';

import 'package:expense_tracker/core/util/validators/change_pass_validator.dart';
import 'package:expense_tracker/presentation/components/custom_elevated_button.dart';
import 'package:expense_tracker/presentation/components/custom_loading_indicator.dart';
import 'package:expense_tracker/presentation/components/custom_snack_bar.dart';
import 'package:expense_tracker/presentation/components/screens/success_screen.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_card.dart';
import 'package:expense_tracker/presentation/components/text_field/custom_text_from_field.dart';
import 'package:expense_tracker/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:expense_tracker/presentation/screens/auth/login/login_screen.dart';
import 'package:expense_tracker/presentation/screens/base.dart';
import 'package:expense_tracker/presentation/screens/profile/change_password_cubit/change_password_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});
  static const pageRoute = '/change-password_page';

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _validator = ChangePasswordValidator();
  @override
  void dispose() {
    _validator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {},
      child: HomeBase(
        pageLabel: appLocalizations.changePassword,
        child: Form(
          key: _validator.formKey,
          child: StatisticsCard(
            child: SingleChildScrollView(
              child: BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
                listener: (context, state) {
                  log('change pass state: $state');
                  if (state is ChangePasswordFailed) {
                    if (state.globalError != null) {
                      showSnackBar(
                        context,
                        value: state.globalError!,
                      );
                      return;
                    }
                  } //ChangePasswordSucceeded
                  if (state is ChangePasswordSucceeded) {
                    context.read<AuthBloc>().add(const LogoutEvent());
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SuccessScreen(
                          btnLabel: appLocalizations.logIn,
                          onTap: () {
                            context.push(LoginScreen.pageRoute);
                          },
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  final isFailed = state is ChangePasswordFailed;
                  if (state is ChangePasswordLoadingState) {
                    return const CustomLoadingIndicator();
                  }
                  return Column(
                    children: [
                      Column(
                        children: [
                          CustomTextFromField(
                            label: appLocalizations.oldPassword,
                            textColor: Colors.black,
                            kbInputType: TextInputType.visiblePassword,
                            controller: _validator.oldPassController,
                            errorText: isFailed ? state.oldPasswordError : null,
                            isPassword: true,
                            validator: (value) =>
                                _validator.validateOldPassword(context, value),
                            onFieldSubmitted: (value) =>
                                _validator.validateForm(),
                          ),
                          CustomTextFromField(
                            label: appLocalizations.newPassword,
                            kbInputType: TextInputType.visiblePassword,
                            textColor: Colors.black,
                            controller: _validator.newPassController,
                            errorText: isFailed ? state.newPasswordError : null,
                            isPassword: true,
                            validator: (value) =>
                                _validator.validateNewPassword(context, value),
                            onFieldSubmitted: (value) =>
                                _validator.validateForm(),
                          ),
                          CustomTextFromField(
                            label: appLocalizations.confirmNewPassword,
                            kbInputType: TextInputType.visiblePassword,
                            textColor: Colors.black,
                            controller: _validator.confirmNewPassController,
                            errorText: isFailed
                                ? state.newPasswordConfirmationError
                                : null,
                            isPassword: true,
                            validator: (value) => _validator
                                .validateConfirmNewPassword(context, value),
                            onFieldSubmitted: (value) =>
                                _validator.validateForm(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 100),
                      CustomElevatedButton(
                        text: appLocalizations.changePassword,
                        onPressed: () {
                          final isValid = _validator.validateForm();
                          log('change password valid: $isValid');
                          if (isValid) {
                            context.read<ChangePasswordCubit>().changePassword(
                                  oldPassword: _validator.oldPassword!,
                                  newPassword: _validator.newPassword!,
                                  confirmNewPassword:
                                      _validator.confirmNewPassword!,
                                );
                            return;
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
