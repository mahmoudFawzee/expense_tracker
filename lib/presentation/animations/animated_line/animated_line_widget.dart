import 'package:expense_tracker/presentation/components/custom_shapes/line_shape.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_item_details_cubit/statistics_item_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


const _spaceOnTheLeft = 10.0;
const _spaceFromTop = 3.0;
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
