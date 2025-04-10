import 'dart:developer';

import 'package:expense_tracker/presentation/animations/animated_container_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAnimatedContainer extends StatelessWidget {
  const CustomAnimatedContainer({
    super.key,
    required this.endHeight,
    required this.label,
  });
  // TODO: ?how to handle end height?
  // TODO: we will get the amount of money the category took.
  // TODO: then we will calculate it.
  // TODO: then pass it here as a ratio of 100
  final double endHeight;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocProvider(
          create: (context) => AnimatedContainerCubit(endHeight)..start(),
          child: Builder(builder: (context) {
            return BlocBuilder<AnimatedContainerCubit, double>(
              builder: (context, state) {
                log('container height $state');
                return AnimatedContainer(
                  height: state,
                  width: 30,
                  duration: const Duration(seconds: 1),
                  decoration: const BoxDecoration(
                      color: Color(0xA1F8CE94),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                );
              },
            );
          }),
        ),
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
