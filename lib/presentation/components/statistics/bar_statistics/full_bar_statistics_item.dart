import 'package:expense_tracker/presentation/animations/custom_animated_container.dart';
import 'package:expense_tracker/presentation/components/statistics/bar_statistics/bar_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullBarStatisticsItem extends StatelessWidget {
  const FullBarStatisticsItem({
    super.key,
    required this.barIndex,
    required this.amount,
    required this.date,
    required this.label,
    required this.totalSpent,
  });
  final int barIndex;
  final double amount;
  final String date, label;
  final double totalSpent;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<BarDetailsCubit, int?>(
        builder: (context, selectedIndex) {
          return InkWell(
            onTap: () {
              if (selectedIndex == barIndex) {
                context.read<BarDetailsCubit>().select(null);
                return;
              }
              context.read<BarDetailsCubit>().select(barIndex);
            },
            child: Stack(
              //mainAxisAlignment: MainAxisAlignment.end,
              children: [
                BarStatisticsItem(
                  selected: barIndex == selectedIndex,
                  label: label,
                  endHeight: amount * 10,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Visibility(
                    visible: barIndex == selectedIndex,
                    child: Container(
                      height: 50,
                      width: 85,
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        children: [
                          Text(date),
                          Text(
                            '\$$amount',
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    });
  }
}

class BarStatisticsItem extends StatelessWidget {
  const BarStatisticsItem({
    super.key,
    required this.selected,
    required this.endHeight,
    required this.label,
  });

  final double endHeight;
  final String label;
  final bool selected;
  @override
  Widget build(BuildContext context) {
    return CustomAnimatedContainer(
      endHeight: endHeight,
      label: label,
      barWidth: 20,
      barColor: selected
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.primary.withOpacity(.59),
    );
  }
}
