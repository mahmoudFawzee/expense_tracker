import 'package:expense_tracker/presentation/animations/animated_line/animated_line_widget.dart';
import 'package:expense_tracker/presentation/animations/animated_line/line_point.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_item_details_cubit/statistics_item_details_cubit.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_details_card.dart';
import 'package:expense_tracker/core/util/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullAnimatedLinedStatistics extends StatelessWidget {
  const FullAnimatedLinedStatistics({
    super.key,
    required this.items,
    required this.width,
    required this.height,
  });
  final List<LinePoint> items;
  final double width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      //?we need to center the content in the center of the widget.
      margin: const EdgeInsets.only(left: 5, top: 0),
      child: Stack(
        children: [
          //?this is the item details card
          BlocBuilder<StatisticsItemDetailsCubit, StatisticsItemDetailsState>(
            builder: (context, state) {
              final isSelected = state is SelectedItemState;
              return Positioned(
                top: 0,
                left: isSelected
                    ? _handleCardDetailsDx(
                        context,
                        state.itemOffset.dx,
                      )
                    : 0,
                child: Visibility(
                  visible: isSelected,
                  child: StatisticsDetailsCard(
                    date: isSelected ? state.date : '',
                    amount: isSelected ? '${state.amount}' : '',
                  ),
                ),
              );
            },
          ),

          Column(
            children: [
              const SizedBox(height: 70),
              //?widget responsible for the line chart points and line
              Container(
                //?we need to put the point exactly above the center of its label
                margin: const EdgeInsets.only(left: 5),
                child: AnimatedLineWidget(
                  offsets: LinePoint.offsets(items),
                  label: LinePoint.labels(items),
                  dates: LinePoint.dates(items),
                  values: LinePoint.values(items),
                  width: width,
                  height: height,
                ),
              ),
              //?this is the widget responsible for labels is the bottom.
              SizedBox(
                height: 20,
                child: Stack(
                  children: List.generate(items.length, (index) {
                    return Positioned(
                      left: items[index].offset.dx,
                      //?we want to put the labels in the bottom of the widget
                      bottom: 0,
                      child: BlocBuilder<StatisticsItemDetailsCubit,
                          StatisticsItemDetailsState>(
                        builder: (context, state) {
                          return InkWell(
                            onTap: () => _handleOnTap(
                              context,
                              index: index,
                              state: state,
                              offset: items[index].offset,
                              amount: items[index].statisticsItem.amount,
                              date: handleCardDate(
                                items[index].statisticsItem.date,
                              ),
                            ),
                            child: Text(
                              items[index].statisticsItem.name,
                              style: TextStyle(
                                fontSize: items.length > 8 ? 10 : 14,
                                color: _handelColor(
                                  state,
                                  itemIndex: index,
                                  selectedColor:
                                      Theme.of(context).colorScheme.primary,
                                  unSelectedColor: Colors.black,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void _handleOnTap(
  BuildContext context, {
  required StatisticsItemDetailsState state,
  required int index,
  required Offset offset,
  required double amount,
  required String date,
}) {
  if (state is SelectedItemState) {
    if (state.selectedIndex == index) {
      context.read<StatisticsItemDetailsCubit>().deSelect();
      return;
    }
  }
  context.read<StatisticsItemDetailsCubit>().select(
        index,
        itemOffset: offset,
        amount: amount,
        date: date,
      );
}

Color _handelColor(
  StatisticsItemDetailsState state, {
  required int itemIndex,
  required Color selectedColor,
  required Color unSelectedColor,
}) {
  if (state is SelectedItemState) {
    if (state.selectedIndex == itemIndex) return selectedColor;
  }
  return unSelectedColor;
}

double _handleCardDetailsDx(BuildContext context, double dx) {
  final width = MediaQuery.of(context).size.width;

  if (dx > width - 90) return dx - 60;
  if (dx > 50) return dx - 40;

  return 0;
}
