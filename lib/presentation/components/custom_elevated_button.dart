import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.text,
    this.btnColor,
    this.textColor,
    this.enabled = true,
    required this.onPressed,
  });
  final String text;
  final Color? textColor;
  final bool enabled;
  final Color? btnColor;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: Theme.of(context).elevatedButtonTheme.style!.copyWith(
            backgroundColor: WidgetStatePropertyAll(btnColor),
          ),
      onPressed: enabled ? onPressed : null,
      child: Text(
        text,
        style:
            Theme.of(context).textTheme.labelLarge!.copyWith(color: textColor),
      ),
    );
  }
}
