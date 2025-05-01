import 'package:expense_tracker/presentation/animations/animated_container/custom_animated_container.dart';
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
      return BlocBuilder<BarDetailsCubit, BarDetailsState>(
        builder: (context, state) {
          final isABarSelected = state is SelectedBarState;
          final isTheBarSelected =
              isABarSelected ? barIndex == state.selectedIndex : false;
          return InkWell(
            onTap: () {
              if (isTheBarSelected) {
                context.read<BarDetailsCubit>().deSelect();
                return;
              }
              context.read<BarDetailsCubit>().select(
                    barIndex,
                    amount: amount,
                    date: date,
                  );
            },
            child: BarStatisticsItem(
              selected: isTheBarSelected,
              label: label,
              endHeight: amount,
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
          ? Theme.of(context).colorScheme.inversePrimary
          : Theme.of(context).colorScheme.primary.withOpacity(.59),
    );
  }
}
