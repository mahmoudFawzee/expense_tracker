import 'dart:developer';

import 'package:expense_tracker/presentation/components/custom_elevated_button.dart';
import 'package:expense_tracker/presentation/components/custom_text_from_field.dart';
import 'package:expense_tracker/presentation/functions/text_field_validator.dart';
import 'package:expense_tracker/presentation/resources/image_manger.dart';
import 'package:expense_tracker/presentation/screens/auth/login_screen.dart';
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
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool validateForm() {
    final valid = _formKey.currentState?.validate();
    if (valid == null) return false;
    return valid;
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
          key: _formKey,
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
                      //first name
                      CustomTextFromField(
                        controller: firstNameController,
                        label: appLocalizations.first_name,
                        kbInputType: TextInputType.name,
                        validator: (value) => validateName(context, value),
                        onFieldSubmitted: (_) => validateForm(),
                      ),
                      //last name
                      CustomTextFromField(
                        controller: lastNameController,
                        label: appLocalizations.last_name,
                        kbInputType: TextInputType.name,
                        validator: (value) => validateName(context, value),
                        onFieldSubmitted: (_) => validateForm(),
                      ),
                      //phone number
                      CustomTextFromField(
                        controller: phoneNumberController,
                        label: appLocalizations.phone_number,
                        kbInputType: TextInputType.phone,
                        validator: (value) =>
                            validatePhoneNumber(context, value),
                        onFieldSubmitted: (_) => validateForm(),
                      ),
                      //email
                      CustomTextFromField(
                        controller: emailController,
                        label: appLocalizations.email,
                        kbInputType: TextInputType.emailAddress,
                        validator: (value) => validateEmail(context, value),
                        onFieldSubmitted: (_) => validateForm(),
                      ),
                      //password
                      CustomTextFromField(
                        controller: passwordController,
                        isPassword: true,
                        label: appLocalizations.password,
                        kbInputType: TextInputType.visiblePassword,
                        validator: (value) => validatePassword(context, value),
                        onFieldSubmitted: (_) => validateForm(),
                      ),
                      //confirm password
                      CustomTextFromField(
                        controller: confirmPasswordController,
                        isPassword: true,
                        label: appLocalizations.confirm_password,
                        kbInputType: TextInputType.visiblePassword,
                        validator: (value) => confirmPassword(
                            context, passwordController.text, value),
                        onFieldSubmitted: (_) => validateForm(),
                      ),
                      const SizedBox(height: 10),
                      CustomElevatedButton(
                        label: appLocalizations.register,
                        onPressed: () {
                          log('validate');
                          context.go(LoginScreen.pageRoute);
                          if (validateForm()) {
                            //todo call create user method.
                          }
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
