import 'dart:developer';

import 'package:expense_tracker/presentation/components/custom_elevated_button.dart';
import 'package:expense_tracker/presentation/components/custom_text_from_field.dart';
import 'package:expense_tracker/presentation/functions/text_field_validator.dart';
import 'package:expense_tracker/presentation/resources/image_manger.dart';
import 'package:expense_tracker/presentation/screens/auth/register_screen.dart';
import 'package:expense_tracker/presentation/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const pageRoute = '/login_page';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool validateForm() {
    final valid = _formKey.currentState?.validate();
    if (valid == null) return false;
    return valid;
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
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
                      const SizedBox(height: 20),
                      CustomElevatedButton(
                        label: appLocalizations.logIn,
                        onPressed: () {
                          log('validate');
                          if (validateForm()) {
                            //todo call create user method.
                          }
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
