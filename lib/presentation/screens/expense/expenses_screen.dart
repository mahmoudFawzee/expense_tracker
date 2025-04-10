import 'package:expense_tracker/presentation/components/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatelessWidget {
  const ExpensesScreen({super.key});
  static const pageRoute = '/expenses_page';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.amber,
      appBar: CustomAppBar(
        title: 'expenses',
      ),
    );
  }
}
