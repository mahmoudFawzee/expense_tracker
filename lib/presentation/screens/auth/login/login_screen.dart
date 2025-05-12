import 'dart:developer';
import 'package:expense_tracker/core/util/validators/login_validator.dart';
import 'package:expense_tracker/presentation/components/custom_elevated_button.dart';
import 'package:expense_tracker/presentation/components/custom_snack_bar.dart';
import 'package:expense_tracker/presentation/components/text_field/custom_text_from_field.dart';
import 'package:expense_tracker/presentation/resources/image_manger.dart';
import 'package:expense_tracker/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:expense_tracker/presentation/screens/auth/register/register_screen.dart';
import 'package:expense_tracker/presentation/screens/expense/expenses_screen.dart';
import 'package:expense_tracker/app/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const pageRoute = '/login_page';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _validator = LoginValidator();

  @override
  void dispose() {
    _validator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 150),
        Center(
          child: Column(
            children: [
              Image.asset(
                ImageManger.appLogo,
                height: 128,
                width: 128,
              ),
              const SizedBox(height: 30),
              Text(
                appLocalizations.logIn,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        const SizedBox(height: 32),
        Form(
          key: _validator.formKey,
          child: AutofillGroup(
            child: Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      //email
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is LoginFailureState) {
                            if(state.error!=null){
                              showSnackBar(context, value: state.error!);
                            }
                            log('login fail: $state');
                            return;
                          }
                        },
                        builder: (context, state) {
                          if (state is AuthLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: ColorsMangerLight.surface,
                              ),
                            );
                          }
                          final failure = state is LoginFailureState;
                          return Column(
                            children: [
                              CustomTextFromField(
                                controller: _validator.emailController,
                                label: appLocalizations.email,
                                errorText: failure ? state.emailError : null,
                                kbInputType: TextInputType.emailAddress,
                                validator: (value) => _validator
                                    .validateEmail(context, value: value),
                                onFieldSubmitted: (_) =>
                                    _validator.validateForm(),
                              ),
                              //password
                              CustomTextFromField(
                                controller: _validator.passwordController,
                                errorText: failure ? state.passwordError : null,
                                isPassword: true,
                                label: appLocalizations.password,
                                kbInputType: TextInputType.visiblePassword,
                                validator: (value) => _validator
                                    .validatePassword(context, value: value),
                                onFieldSubmitted: (_) =>
                                    _validator.validateForm(),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is LoginSuccessState) {
                            context.go(ExpensesScreen.pageRoute);
                          }
                        },
                        builder: (context, state) {
                          return CustomElevatedButton(
                            text: appLocalizations.logIn,
                            enabled: state is! AuthLoadingState,
                            onPressed: () {
                              log('validate');

                              if (_validator.validateForm()) {
                                context.read<AuthBloc>().add(LoginEvent(
                                      _validator.email!,
                                      _validator.password!,
                                    ));
                              }
                            },
                          );
                        },
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appLocalizations.hasNoAccount,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          InkWell(
                            onTap: () {
                              context.go(RegisterScreen.pageRoute);
                            },
                            child: Text(
                              appLocalizations.create(appLocalizations.account),
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium!
                                  .copyWith(
                                    color: ColorsMangerLight.surface,
                                    decoration: TextDecoration.underline,
                                    decorationThickness: 2,
                                    decorationColor: ColorsMangerLight.surface,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
