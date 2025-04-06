import 'package:expense_tracker/logic/cubits/cubit/password_cubit.dart';
import 'package:expense_tracker/view/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomTextFromField extends StatelessWidget {
  const CustomTextFromField({
    super.key,
    this.maxLines = 1,
    this.isPassword = false,
    required this.label,
    required this.kbInputType,
    required this.controller,
    required this.validator,
    required this.onFieldSubmitted,
  });
  final int maxLines;
  final bool isPassword;
  final String label;
  final TextInputType kbInputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PasswordCubit(),
      child: Builder(builder: (context) {
        return Column(
          children: [
            const SizedBox(height: 10),
            BlocBuilder<PasswordCubit, bool>(
              builder: (context, hidePassword) {
                return TextFormField(
                  controller: controller,
                  validator: validator,
                  maxLines: maxLines,
                  obscureText: isPassword && hidePassword,
                  keyboardType: kbInputType,
                  autofillHints: _autoFillHints(kbInputType),
                  autocorrect: true,
                  autofocus: false,
                  textCapitalization: TextCapitalization.words,
                  onFieldSubmitted: onFieldSubmitted,

                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: ColorsMangerLight.surface),
                  //?focus on the next field.
                  textInputAction: maxLines < 2
                      ? TextInputAction.next
                      : TextInputAction.newline,
                  decoration: InputDecoration(
                    suffixIcon: isPassword
                        ? IconButton(
                            onPressed: () {
                              context.read<PasswordCubit>().changeVisibility();
                            },
                            icon: Icon(hidePassword
                                ? Icons.visibility
                                : Icons.visibility_off),
                            color: Theme.of(context).colorScheme.surface,
                            iconSize: 18,
                          )
                        : null,

                    label: Text(label),
                    labelStyle:
                        Theme.of(context).textTheme.labelMedium!.copyWith(
                              color: ColorsMangerLight.surface,
                            ),
                    //?default border
                    border: _border(),
                    //?border when the field is enabled
                    enabledBorder: _border(),
                    //?when we focus to write in the field
                    focusedBorder: _border(color: Colors.white),
                    //?when error and not focused
                    errorBorder: _border(),
                    //?when the field not enabled
                    disabledBorder: _border(),
                    //?focused and error.
                    focusedErrorBorder: _border(),
                  ),
                );
              },
            ),
          ],
        );
      }),
    );
  }

  InputBorder _border({
    Color color = ColorsMangerLight.onSurface,
  }) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
    );
  }

  List<String> _autoFillHints(TextInputType kbType) {
    switch (kbType) {
      case TextInputType.visiblePassword:
        return [AutofillHints.password];
      case TextInputType.emailAddress:
        return [AutofillHints.email];
      case TextInputType.phone:
        return [AutofillHints.telephoneNumber];

      default:
        return [AutofillHints.name];
    }
  }
}
