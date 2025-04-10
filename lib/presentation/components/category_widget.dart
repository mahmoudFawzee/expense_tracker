import 'package:flutter/material.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.label,
    this.selected = false,
    required this.onTap,
  });
  final String label;
  final bool selected;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xA1F8CE94)
              : Theme.of(context).colorScheme.primary,
          borderRadius: const BorderRadius.all(Radius.circular(15)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}

