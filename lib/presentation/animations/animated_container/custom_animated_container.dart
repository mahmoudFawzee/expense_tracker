import 'package:expense_tracker/presentation/animations/animated_container/animated_container_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAnimatedContainer extends StatelessWidget {
  const CustomAnimatedContainer({
    super.key,
    required this.endHeight,
    required this.label,
    this.barWidth = 30,
    this.barColor,
  });
  final double endHeight;
  final String label;
  final double barWidth;
  final Color? barColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          BlocProvider(
            create: (context) => AnimatedContainerCubit(endHeight)..start(),
            child: Builder(builder: (context) {
              return BlocBuilder<AnimatedContainerCubit, double>(
                builder: (context, state) {
                  return AnimatedContainer(
                    height: state,
                    width: barWidth,
                    duration: const Duration(seconds: 1),
                    decoration: BoxDecoration(
                        color: barColor ?? const Color(0xA1F8CE94),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(5))),
                  );
                },
              );
            }),
          ),
          Text(
            label,
            style: TextStyle(
              color: barColor ?? Colors.white,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
