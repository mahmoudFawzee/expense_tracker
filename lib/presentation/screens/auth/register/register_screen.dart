import 'dart:developer';
import 'package:expense_tracker/data/models/user/m_user.dart';
import 'package:expense_tracker/presentation/screens/auth/auth_base.dart';
import 'package:expense_tracker/presentation/screens/auth/bloc/auth_bloc.dart';
import 'package:expense_tracker/presentation/screens/expense/expenses_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expense_tracker/presentation/components/custom_elevated_button.dart';
import 'package:expense_tracker/presentation/components/custom_text_from_field.dart';
import 'package:expense_tracker/presentation/resources/image_manger.dart';
import 'package:expense_tracker/presentation/screens/auth/login/login_screen.dart';
import 'package:expense_tracker/presentation/screens/auth/register/register_validator.dart';
import 'package:expense_tracker/presentation/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static const pageRoute = '/register';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final validator = RegisterValidator();

  @override
  void dispose() {
    validator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 50),
        Column(
          children: [
            Image.asset(
              ImageManger.appLogo,
              height: 128,
              width: 128,
            ),
            const SizedBox(height: 30),
            Text(
              appLocalizations.register,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ],
        ),
        const SizedBox(height: 32),
        Form(
          key: validator.formKey,
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
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthLoadingState) {
                            return const Center(
                              child: CircularProgressIndicator.adaptive(
                                backgroundColor: ColorsMangerLight.surface,
                              ),
                            );
                          }
                          final failure = state is RegisterFailure;
                          return Column(
                            children: [
                              //first name
                              CustomTextFromField(
                                controller: validator.firstNameController,
                                errorText: failure ? state.error : null,
                                label: appLocalizations.first_name,
                                kbInputType: TextInputType.name,
                                validator: (value) => validator
                                    .validateFirstName(context, value: value),
                                onFieldSubmitted: (_) =>
                                    validator.validateForm(),
                              ),
                              //last name
                              CustomTextFromField(
                                controller: validator.lastNameController,
                                errorText: failure ? state.error : null,
                                label: appLocalizations.last_name,
                                kbInputType: TextInputType.name,
                                validator: (value) => validator
                                    .validateLastName(context, value: value),
                                onFieldSubmitted: (_) =>
                                    validator.validateForm(),
                              ),
                              //phone number
                              CustomTextFromField(
                                controller: validator.phoneNumberController,
                                errorText: failure ? state.error : null,
                                label: appLocalizations.phone_number,
                                kbInputType: TextInputType.phone,
                                validator: (value) => validator
                                    .validatePhoneNumber(context, value: value),
                                onFieldSubmitted: (_) =>
                                    validator.validateForm(),
                              ),
                              //email
                              CustomTextFromField(
                                controller: validator.emailController,
                                label: appLocalizations.email,
                                errorText: failure ? state.error : null,
                                kbInputType: TextInputType.emailAddress,
                                validator: (value) => validator
                                    .validateEmail(context, value: value),
                                onFieldSubmitted: (_) =>
                                    validator.validateForm(),
                              ),
                              //password
                              CustomTextFromField(
                                controller: validator.passwordController,
                                errorText: failure ? state.error : null,
                                isPassword: true,
                                label: appLocalizations.password,
                                kbInputType: TextInputType.visiblePassword,
                                validator: (value) => validator
                                    .validatePassword(context, value: value),
                                onFieldSubmitted: (_) =>
                                    validator.validateForm(),
                              ),
                              //confirm password
                              CustomTextFromField(
                                controller: validator.confirmPasswordController,
                                errorText: failure ? state.error : null,
                                isPassword: true,
                                label: appLocalizations.confirm_password,
                                kbInputType: TextInputType.visiblePassword,
                                validator: (value) => validator
                                    .validateConfirmPassword(context, value),
                                onFieldSubmitted: (_) =>
                                    validator.validateForm(),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      BlocConsumer<AuthBloc, AuthState>(
                        listener: (context, state) {
                          if (state is RegisterSuccessState) {
                            //TODO this must be handled with the backend
                            //?we will get access token and refresh token and save it in the secure storage
                            //?we will save the user data in the shared preferences
                            //?then we will navigate to the expenses screen
                            context.go(ExpensesScreen.pageRoute);
                          }
                        },
                        builder: (context, state) {
                          return CustomElevatedButton(
                            label: appLocalizations.register,
                            enabled: state is! AuthLoadingState,
                            onPressed: () {
                              log('validate');

                              if (validator.validateForm()) {
                                final user = UserModel(
                                  firstName: validator.firstName!,
                                  lastName: validator.lastName!,
                                  phoneNumber: validator.phoneNumber!,
                                  email: validator.email!,
                                );
                                context.read<AuthBloc>().add(
                                      RegisterEvent(
                                        user,
                                        validator.password!,
                                        validator.confirmedPassword!,
                                      ),
                                    );
                              }
                            },
                          );
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            appLocalizations.hasAccount,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          InkWell(
                            onTap: () {
                              context.go(LoginScreen.pageRoute);
                            },
                            child: Text(
                              appLocalizations.logIn,
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
