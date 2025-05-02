import 'dart:async';
import 'dart:developer';

import 'package:expense_tracker/presentation/animations/animated_line/line_point.dart';
import 'package:expense_tracker/presentation/components/custom_shapes/line_shape.dart';
import 'package:expense_tracker/presentation/components/statistics/cubit/statistics_item_details_cubit.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_details_card.dart';
import 'package:expense_tracker/util/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const _spaceOnTheLeft = 10.0;
const _spaceFromTop = 3.0;

class AnimatedLinedStatistics extends StatelessWidget {
  const AnimatedLinedStatistics({
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

class AnimatedLineWidget extends StatefulWidget {
  const AnimatedLineWidget({
    super.key,
    required this.offsets,
    required this.dates,
    required this.values,
    required this.label,
    required this.width,
    required this.height,
  });
  final List<Offset> offsets;
  final List<String> dates;
  final List<double> values;
  final List<String> label;
  final double width, height;

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedLineWidgetState createState() => _AnimatedLineWidgetState();
}

class _AnimatedLineWidgetState extends State<AnimatedLineWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return SizedBox(
          //?here we need to show the max value point so we increase box size by 15
          height: widget.height + (_spaceFromTop * 5),
          child: Stack(
            children: [
              //?is is the widget responsible for drawing the line.
              Positioned(
                //?we make it on positioned widget with (top,left)=>(3,3) to make the line in the points.
                top: _spaceFromTop,
                left: _spaceOnTheLeft,
                child: CustomPaint(
                  size: Size(widget.width, widget.height),
                  painter: AnimatedLinePainter(
                    points: widget.offsets,
                    progress: _animation.value,
                  ),
                ),
              ),
              //?here we draw the points of each offset.
              ...List.generate(widget.offsets.length, (index) {
                //?not that positioned starts as (bottom,left)=>)(dy,dx)
                //?not that drawn points using line painter starts as (top,left)=>(dy,dx)
                final bottom = widget.height - widget.offsets[index].dy;
                final left = widget.offsets[index].dx;
                return Positioned(
                  bottom: bottom,
                  left: left,
                  child: BlocBuilder<StatisticsItemDetailsCubit,
                      StatisticsItemDetailsState>(
                    builder: (context, state) {
                      return InkWell(
                        onTap: () => _handleOnTap(
                          context,
                          index: index,
                          state: state,
                          offset: widget.offsets[index],
                          amount: widget.values[index],
                          date: widget.dates[index],
                        ),
                        child: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          child: Container(
                            height: 10,
                            width: 10,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _handelColor(
                                state,
                                itemIndex: index,
                                selectedColor:
                                    Theme.of(context).colorScheme.primary,
                                unSelectedColor: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
        );
      },
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
