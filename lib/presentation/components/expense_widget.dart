import 'package:expense_tracker/domain/entities/category.dart';
import 'package:expense_tracker/presentation/components/expense_amount.dart';
import 'package:flutter/material.dart';

class ExpenseWidget extends StatelessWidget {
  const ExpenseWidget({
    super.key,
    required this.title,
    required this.category,
    required this.amount,
    required this.date,
  });
  final String title;
  final Category category;
  final double amount;
  final String date;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(category.imgUrl),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    category.title,
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: Colors.grey,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BalanceTextWidget(
                balance: amount,
                color: Colors.black,
                fontSize: 15,
              ),
              Text(
                date,
                style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      color: Colors.grey,
                    ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
