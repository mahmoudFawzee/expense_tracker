import 'package:expense_tracker/presentation/components/custom_dialog.dart';
import 'package:expense_tracker/presentation/components/custom_text_from_field.dart';
import 'package:expense_tracker/presentation/screens/auth/base_validator.dart';
import 'package:expense_tracker/presentation/screens/profile/bloc/user_data_bloc.dart';
import 'package:flutter/material.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});
  static final _baseValidator = BaseValidator();
  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return IconButton(
      icon: const Icon(Icons.delete_sharp),
      onPressed: () {
        CustomAwesomeDialog.showDialog(
          context: context,
          title: appLocalization.deleteAccount,
          body: PasswordConfirmationForm(
            baseValidator: _baseValidator,
          ),
          btnCancelOnPress: () {},
          btnOkOnPress: () {
            final isValid = _baseValidator.validateForm();
            if (isValid) {
              context.read<UserDataBloc>().add(
                    DeleteAccountEvent(
                      _baseValidator.password!,
                    ),
                  );
              return;
            }
          },
        );
      },
    );
  }
}

class PasswordConfirmationForm extends StatelessWidget {
  const PasswordConfirmationForm({
    super.key,
    required BaseValidator baseValidator,
  }) : _baseValidator = baseValidator;

  final BaseValidator _baseValidator;

  @override
  Widget build(BuildContext context) {
    final appLocalization = AppLocalizations.of(context)!;
    return Column(
      children: [
        Text(appLocalization.passwordRequired),
        const SizedBox(
          height: 10,
        ),
        Form(
          key: _baseValidator.formKey,
          child: CustomTextFromField(
            label: appLocalization.password,
            kbInputType: TextInputType.visiblePassword,
            validator: (value) => _baseValidator.validatePassword(
              context,
              value: value,
            ),
            onFieldSubmitted: (_) => _baseValidator.validateForm(),
            
          ),
        ),
      ],
    );
  }
}
