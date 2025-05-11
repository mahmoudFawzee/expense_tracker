import 'package:expense_tracker/presentation/theme/color_manger.dart';
import 'package:flutter/material.dart';

class UnderLayerAppBar extends StatelessWidget {
  const UnderLayerAppBar({
    super.key,
    required this.label,
    required this.actionIcon,
  });
  final String label;
  final Widget actionIcon;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      height: height * .13,
      width: double.infinity,
      decoration: const BoxDecoration(
          color: ColorsMangerLight.primaryColor,
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 63, 173, 157),
            Color.fromARGB(135, 44, 120, 109)
          ])),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
          actionIcon,
        ],
      ),
    );
  }
}
