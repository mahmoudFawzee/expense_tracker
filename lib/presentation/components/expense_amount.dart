import 'package:flutter/material.dart';

class BalanceTextWidget extends StatelessWidget {
  const BalanceTextWidget({
    super.key,
    required this.balance,
    this.color = Colors.white,
    this.fontSize = 28,
  });
  final double balance;
  final Color color;
  final double fontSize;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontSize: fontSize,
              color: color,
            ),
        children: [
          const TextSpan(text: '\$', style: TextStyle(fontSize: 15)),
          TextSpan(
            text: '$balance',
          ),
        ],
      ),
    );
  }
}
