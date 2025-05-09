import 'package:expense_tracker/presentation/components/custom_elevated_button.dart';
import 'package:expense_tracker/presentation/components/custom_loading_indicator.dart';
import 'package:expense_tracker/presentation/components/custom_text_from_field.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_card.dart';
import 'package:expense_tracker/presentation/screens/base.dart';
import 'package:expense_tracker/presentation/screens/profile/bloc/user_data_bloc.dart';
import 'package:expense_tracker/presentation/screens/profile/edit_profile_info_validator.dart';
import 'package:expense_tracker/presentation/screens/profile/enable_text_field_cubit/enable_text_field_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfileInfoScreen extends StatefulWidget {
  const ProfileInfoScreen({super.key});
  static const pageRoute = '/profile_info_screen';

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  final validator = EditProfileInfoValidator();

  @override
  void dispose() {
    validator.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (context) => EnableTextFieldCubit(),
      child: HomeBase(
        pageLabel: appLocalizations.personalInfo,
        child: Form(
          key: validator.formKey,
          child: StatisticsCard(
            child: Builder(builder: (context) {
              return BlocBuilder<EnableTextFieldCubit, bool>(
                builder: (context, enabled) {
                  return Column(
                    children: [
                      BlocBuilder<UserDataBloc, UserDataState>(
                        builder: (context, state) {
                          if (state is UserDataLoadingState) {
                            return const CustomLoadingIndicator(
                                widgetHeight: 150);
                          }
                          return Column(
                            children: [
                              CustomTextFromField(
                                label: appLocalizations.first_name,
                                kbInputType: TextInputType.name,
                                enabled: enabled,
                                initialValue: 'name',
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
                                enabled: enabled,
                                initialValue: 'name',
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
                                enabled: enabled,
                                initialValue: '+201064551051',
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
                                enabled: enabled,
                                initialValue: 'name',
                                validator: (value) => validator.validateEmail(
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
                      CustomElevatedButton(
                        label: appLocalizations.update,
                        onPressed: () {
                          if (enabled) {
                            context.read<EnableTextFieldCubit>().changeState();
                            //?now we already will update data.
                            //?we call the user bloc to update user data event.
                            return;
                          }
                          context.read<EnableTextFieldCubit>().changeState();
                        },
                      ),
                    ],
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
