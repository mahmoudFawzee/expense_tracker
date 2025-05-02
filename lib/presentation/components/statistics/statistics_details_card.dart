import 'package:flutter/material.dart';

class StatisticsDetailsCard extends StatelessWidget {
  const StatisticsDetailsCard({
    super.key,
    required this.date,
    required this.amount,
  });

  final String date;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 85,
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondaryContainer,
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          Text(date),
          Text(amount),
        ],
      ),
    );
  }
}
