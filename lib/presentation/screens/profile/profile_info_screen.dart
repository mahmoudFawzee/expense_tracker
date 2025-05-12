import 'dart:developer';
import 'package:expense_tracker/domain/entities/user.dart';
import 'package:expense_tracker/presentation/animations/animated_button/animated_button.dart';
import 'package:expense_tracker/presentation/animations/animated_button/animated_button_cubit.dart';
import 'package:expense_tracker/presentation/components/app_bar/delete_account.dart';
import 'package:expense_tracker/presentation/components/app_bar/logout.dart';
import 'package:expense_tracker/presentation/components/custom_dialog.dart';
import 'package:expense_tracker/presentation/components/custom_elevated_button.dart';
import 'package:expense_tracker/presentation/components/custom_loading_indicator.dart';
import 'package:expense_tracker/presentation/components/custom_snack_bar.dart';
import 'package:expense_tracker/presentation/components/custom_text_from_field.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_card.dart';
import 'package:expense_tracker/presentation/screens/auth/base_validator.dart';
import 'package:expense_tracker/presentation/screens/base.dart';
import 'package:expense_tracker/presentation/screens/profile/user_data_bloc/user_data_bloc.dart';
import 'package:expense_tracker/presentation/screens/profile/edit_profile_info_validator.dart';
import 'package:expense_tracker/presentation/screens/profile/enable_text_field_cubit/enable_text_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});
  static const pageRoute = '/profile_info_screen';

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final validator = EditProfileInfoValidator();
  final passwordConfirmationFormValidator = BaseValidator();

  User? _getUser(UserDataState state) {
    if (state is FetchedUserDataState) return state.user;
    if (state is UpdatedUserDataState) return state.updatedUser;
    //if (state is AskEmailUpdateConfirmationState) return state.user;
    return null;
  }

  UserDateErrorState? _getErrorMessages(UserDataState state) {
    if (state is UserDateErrorState) return state;
    return null;
  }

  final _cancelButtonCubit = AnimatedButtonCubit();
  final _saveButtonCubit = AnimatedButtonCubit();
  @override
  void dispose() {
    validator.dispose();
    _cancelButtonCubit.close();
    _saveButtonCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => EnableTextFieldCubit(),
      child: Builder(builder: (context) {
        return PopScope(
          onPopInvokedWithResult: (didPop, result) {
            context.read<EnableTextFieldCubit>().disableButton();
          },
          child: HomeBase(
            pageLabel: appLocalizations.personalInfo,
            showNavBar: false,
            actionIcon: const LogoutIcon(),
            child: Form(
              key: validator.formKey,
              child: StatisticsCard(
                child: Builder(builder: (context) {
                  return BlocBuilder<EnableTextFieldCubit, bool>(
                    builder: (context, enabled) {
                      if (enabled) {
                        _saveButtonCubit.startMove(Alignment.centerRight);
                        _cancelButtonCubit.startMove(Alignment.centerLeft);
                      }
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            BlocConsumer<UserDataBloc, UserDataState>(
                              listener: (context, state) {
                                if (state is UserDateErrorState) {
                                  if (state.error != null) {
                                    showSnackBar(context, value: state.error!);
                                    return;
                                  }
                                }
                                if (state is UpdatedUserDataState) {
                                  context
                                      .read<EnableTextFieldCubit>()
                                      .disableButton();
                                  return;
                                }
                                if (state is AskEmailUpdateConfirmationState) {
                                  CustomAwesomeDialog.showDialog(
                                    context: context,
                                    title: appLocalizations.changeEmail,
                                    body: PasswordConfirmationForm(
                                      baseValidator:
                                          passwordConfirmationFormValidator,
                                    ),
                                    btnCancelOnPress: () {
                                      context.pop();
                                    },
                                    btnOkOnPress: () {
                                      final isValid =
                                          passwordConfirmationFormValidator
                                              .validateForm();
                                      if (isValid) {
                                        context.read<UserDataBloc>().add(
                                              ConfirmUpdateEmailEvent(
                                                calledFrom:
                                                    'calledFrom: btnOk: profile_info_page',
                                                state.user,
                                                passwordConfirmationFormValidator
                                                    .password!,
                                              ),
                                            );
                                        context.pop();
                                      }
                                    },
                                  );
                                }
                              },
                              buildWhen: (previous, current) {
                                log('current user data state is: $current');
                                if (current is FetchedUserDataState) {
                                  return true;
                                }
                                if (current is UpdatedUserDataState) {
                                  return true;
                                }
                                return false;
                              },
                              builder: (context, state) {
                                if (state is UserDataLoadingState) {
                                  return const CustomLoadingIndicator(
                                    widgetHeight: 150,
                                  );
                                }
                                log('user data status: $state');
                                final user = _getUser(state);
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  validator.setFieldsValues(
                                    firstName: user?.firstName,
                                    lastName: user?.lastName,
                                    email: user?.email,
                                    phoneNumber: user?.phoneNumber,
                                  );
                                });

                                return Column(
                                  children: [
                                    CustomTextFromField(
                                      label: appLocalizations.first_name,
                                      textColor: Colors.black,
                                      kbInputType: TextInputType.name,
                                      errorText: _getErrorMessages(state)
                                          ?.firstNameError,
                                      enabled: enabled,
                                      controller: validator.firstNameController,
                                      validator: (value) =>
                                          validator.validateFirstName(
                                        context,
                                        value: value,
                                      ),
                                      onFieldSubmitted: (_) =>
                                          validator.validateForm(),
                                    ),
                                    CustomTextFromField(
                                      label: appLocalizations.last_name,
                                      kbInputType: TextInputType.name,
                                      errorText: _getErrorMessages(state)
                                          ?.lastNameError,
                                      textColor: Colors.black,
                                      enabled: enabled,
                                      controller: validator.lastNameController,
                                      validator: (value) =>
                                          validator.validateLastName(
                                        context,
                                        value: value,
                                      ),
                                      onFieldSubmitted: (_) =>
                                          validator.validateForm(),
                                    ),
                                    CustomTextFromField(
                                      label: appLocalizations.phone_number,
                                      kbInputType: TextInputType.phone,
                                      textColor: Colors.black,
                                      errorText: _getErrorMessages(state)
                                          ?.phoneNumberError,
                                      enabled: enabled,
                                      controller:
                                          validator.phoneNumberController,
                                      validator: (value) =>
                                          validator.validatePhoneNumber(
                                        context,
                                        value: value,
                                      ),
                                      onFieldSubmitted: (_) =>
                                          validator.validateForm(),
                                    ),
                                    CustomTextFromField(
                                      label: appLocalizations.email,
                                      kbInputType: TextInputType.emailAddress,
                                      textColor: Colors.black,
                                      errorText:
                                          _getErrorMessages(state)?.emailError,
                                      enabled: enabled,
                                      controller: validator.emailController,
                                      validator: (value) =>
                                          validator.validateEmail(
                                        context,
                                        value: value,
                                      ),
                                      onFieldSubmitted: (_) =>
                                          validator.validateForm(),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 50),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 50,
                              ),
                              child: Stack(
                                children: [
                                  if (enabled)
                                    BlocProvider.value(
                                      value: _cancelButtonCubit,
                                      child: Builder(
                                        builder: (context) {
                                          return BlocBuilder<
                                              AnimatedButtonCubit, Alignment>(
                                            builder:
                                                (context, cancelButtonState) {
                                              return AnimatedButton(
                                                alignment: cancelButtonState,
                                                child: CustomElevatedButton(
                                                  text: appLocalizations.cancel,
                                                  btnColor: Colors.red,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    context
                                                        .read<
                                                            EnableTextFieldCubit>()
                                                        .disableButton();
                                                    _saveButtonCubit.startMove(
                                                        Alignment.center);
                                                  },
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                  BlocProvider.value(
                                    value: _saveButtonCubit,
                                    child: Builder(builder: (context) {
                                      return BlocBuilder<AnimatedButtonCubit,
                                          Alignment>(
                                        builder: (context, saveButtonState) {
                                          return AnimatedButton(
                                            alignment: saveButtonState,
                                            child: CustomElevatedButton(
                                              text: enabled
                                                  ? appLocalizations.save
                                                  : appLocalizations.edit,
                                              onPressed: () {
                                                FocusManager
                                                    .instance.primaryFocus
                                                    ?.unfocus();
                                                if (enabled) {
                                                  //?now we already will update data.
                                                  //?we call the user bloc to update user data event.
                                                  final isValid =
                                                      validator.validateForm();
                                                  if (isValid) {
                                                    validator.setFieldsValues(
                                                      firstName:
                                                          validator.firstName ??
                                                              '',
                                                      lastName:
                                                          validator.lastName ??
                                                              '',
                                                      phoneNumber: validator
                                                              .phoneNumber ??
                                                          '',
                                                      email:
                                                          validator.email ?? '',
                                                    );
                                                    context
                                                        .read<UserDataBloc>()
                                                        .add(
                                                          UpdateUserDateEvent(
                                                            calledFrom:
                                                                'calledFrom: update button: profile_info_page',
                                                            firstName: validator
                                                                    .firstName ??
                                                                '',
                                                            lastName: validator
                                                                    .lastName ??
                                                                '',
                                                            phoneNumber: validator
                                                                    .phoneNumber ??
                                                                '',
                                                            email: validator
                                                                    .email ??
                                                                '',
                                                          ),
                                                        );
                                                  }

                                                  return;
                                                }
                                                context
                                                    .read<
                                                        EnableTextFieldCubit>()
                                                    .enableButton();
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ),
        );
      }),
    );
  }
}
