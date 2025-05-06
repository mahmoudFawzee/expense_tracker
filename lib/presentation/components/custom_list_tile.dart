import 'package:expense_tracker/presentation/theme/color_manger.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.label,
    required this.leadingIcon,
    this.trailing,
    required this.onTap,
  });
  final String label;
  final IconData leadingIcon;
  final Widget? trailing;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 75,
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: borderGrey,
              width: 1.5,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  leadingIcon,
                  color: Theme.of(context).primaryColor,
                  size: 35,
                ),
                const SizedBox(width: 10),
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            _handleTrailing(context),
          ],
        ),
      ),
    );
  }

  Widget _handleTrailing(BuildContext context) {
    if (trailing != null) return trailing!;
    return Icon(
      Icons.arrow_forward_ios_rounded,
      color: Theme.of(context).primaryColor,
      size: 30,
    );
  }
}
