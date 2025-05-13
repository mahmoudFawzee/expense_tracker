import 'package:expense_tracker/config/theme/color_manger.dart';
import 'package:flutter/material.dart';

class StatisticsOptionButton extends StatelessWidget {
  const StatisticsOptionButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;

  final bool selected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selected ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected
              ? const Color.fromARGB(152, 44, 120, 109)
              : ColorsMangerDark.primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
