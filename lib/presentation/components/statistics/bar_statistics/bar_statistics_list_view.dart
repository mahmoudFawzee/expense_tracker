import 'dart:developer';
import 'package:expense_tracker/domain/entities/statistics/time_based_statistics.dart';
import 'package:expense_tracker/presentation/components/statistics/cubit/statistics_item_details_cubit.dart';
import 'package:expense_tracker/presentation/components/statistics/bar_statistics/full_bar_statistics_item.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_details_card.dart';
import 'package:expense_tracker/util/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BarStatisticsListView extends StatelessWidget {
  const BarStatisticsListView({
    super.key,
    required this.length,
    required this.totalSpent,
    required this.items,
  });

  final List<TimeBasedStatistics> items;
  final int length;
  final double totalSpent;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 180,
        child: Stack(
          children: [
            BlocBuilder<StatisticsItemDetailsCubit, StatisticsItemDetailsState>(
              builder: (context, state) {
                final isBarSelected = state is SelectedItemState;
                return Positioned(
                  top: 0,
                  left: isBarSelected
                      ? handleDxOffset(context, state.itemOffset.dx)
                      : 0,
                  child: Visibility(
                    visible: isBarSelected,
                    child: StatisticsDetailsCard(
                      date: isBarSelected ? state.date : '',
                      amount: isBarSelected ? '${state.amount}' : '',
                    ),
                  ),
                );
              },
            ),
            StatisticsBarView(
              items: items,
              totalSpent: totalSpent,
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsBarView extends StatelessWidget {
  const StatisticsBarView({
    super.key,
    required this.items,
    required this.totalSpent,
  });

  final List<TimeBasedStatistics> items;
  final double totalSpent;

  @override
  Widget build(BuildContext context) {
    if (items.length < 8) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: _getViewContent(items),
      );
    }
    return ListView(
      scrollDirection: Axis.horizontal,
      children: _getViewContent(items),
    );
  }

  List<Widget> _getViewContent(
    List<TimeBasedStatistics> items,
  ) {
    return items.map((item) {
      final index = items.indexOf(item);
      return FullBarStatisticsItem(
        barIndex: index,
        totalSpent: totalSpent,
        amount: item.amount,
        date: handleCardDate(item.date),
        label: item.name,
      );
    }).toList();
  }
}
