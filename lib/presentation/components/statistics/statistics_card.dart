import 'package:flutter/material.dart';

class StatisticsCard extends StatelessWidget {
  const StatisticsCard({
    super.key,
    required this.child,
  });

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.all(10.0),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(
              Radius.circular(
                15,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 3),
                spreadRadius: 5,
                blurRadius: 10,
              )
            ]),
        child: child,
      ),
    );
  }
}
