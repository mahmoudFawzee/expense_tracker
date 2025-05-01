import 'dart:developer';

import 'package:expense_tracker/data/helper/interface/i_chart_type.dart';
import 'package:expense_tracker/data/helper/service/bar_chart.dart';
import 'package:expense_tracker/data/helper/service/line_chart.dart';
import 'package:expense_tracker/domain/entities/statistics/time_based_statistics.dart';
import 'package:expense_tracker/presentation/animations/animated_line/animated_lined_statistics.dart';
import 'package:expense_tracker/presentation/animations/animated_line/line_point.dart';
import 'package:expense_tracker/presentation/components/custom_loading_indicator.dart';
import 'package:expense_tracker/presentation/components/statistics/bar_statistics/bar_details_cubit.dart';
import 'package:expense_tracker/presentation/components/statistics/bar_statistics/full_bar_statistics_item.dart';
import 'package:expense_tracker/presentation/components/statistics/cubit/button_option_cubit.dart';
import 'package:expense_tracker/presentation/components/statistics/option_button/option_button.dart';
import 'package:expense_tracker/presentation/components/statistics/pie_chart.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_card.dart';
import 'package:expense_tracker/presentation/screens/statistics/bar_statistics_cubit/bar_statistics_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/line_statistics_cubit/line_statistics_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/pie_statistics_cubit/category_statistics_cubit.dart';
import 'package:expense_tracker/presentation/theme/color_manger.dart';
import 'package:expense_tracker/util/enum/enums.dart';
import 'package:expense_tracker/util/maps/maps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatisticsScreen extends StatelessWidget {
  const StatisticsScreen({super.key});
  static const pageRoute = '/Statistics_page';

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8),
            height: height * .13,
            width: double.infinity,
            decoration: const BoxDecoration(
                color: ColorsMangerLight.primaryColor,
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 63, 173, 157),
                  Color.fromARGB(135, 44, 120, 109)
                ])),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appLocalizations.statistics,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                      ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.notifications_active_outlined,
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * .1,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //?pie card statistics
                  StatisticsCard(
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            appLocalizations.categories,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Colors.black,
                                ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        BlocBuilder<CategoryStatisticsCubit,
                            CategoryStatisticsState>(
                          builder: (context, state) {
                            if (state is FetchedCategoriesStatisticsState) {
                              return CustomPieChart(
                                dataMap: state.categoriesStatistics,
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  //?bar card statistics
                  BlocProvider(
                    create: (context) => BarDetailsCubit(),
                    child: StatisticsCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //?select statistics type buttons
                          StatisticsOptions(
                            chartType:
                                BarChart(context.read<BarStatisticsCubit>()),
                          ),
                          BlocBuilder<BarStatisticsCubit, BarStatisticsState>(
                            builder: (context, state) {
                              if (state is BarStatisticsLoading) {
                                return const CustomLoadingIndicator(
                                  widgetHeight: 200,
                                );
                              }
                              if (state is FetchedBarWeekStatisticsState) {
                                final days = state.statistics.items;
                                final totalSpent = state.statistics.totalSpent;
                                return BarStatisticsListView(
                                  length: days.length,
                                  totalSpent: totalSpent,
                                  itemBuilder: (context, index) {
                                    final day = days[index];
                                    //?we will take total spent per week or per year
                                    //?when we will apply this formula: (spent_per_day/spent_per_week)*100
                                    return FullBarStatisticsItem(
                                      barIndex: index,
                                      amount: day.amount,
                                      date:
                                          '${day.date.day}/${monthsName[day.date.month]}',
                                      label: day.name,
                                      totalSpent: totalSpent,
                                    );
                                  },
                                );
                              }
                              if (state is FetchedBarYearStatisticsState) {
                                final months = state.statistics.items;
                                final totalSpent = state.statistics.totalSpent;
                                return BarStatisticsListView(
                                    length: months.length,
                                    totalSpent: totalSpent,
                                    itemBuilder: (context, index) {
                                      final month = months[index];
                                      //?we will take total spent per week or per year
                                      //?when we will apply this formula: (spent_per_day/spent_per_week)*100
                                      return FullBarStatisticsItem(
                                        barIndex: index,
                                        totalSpent: totalSpent,
                                        amount: month.amount,
                                        date:
                                            '${month.date.day}/${monthsName[month.date.month]}',
                                        label: month.name,
                                      );
                                    });
                              }

                              if (state is BarStatisticsErrorState) {
                                return Center(
                                  child: Text(state.error),
                                );
                              }
                              return const SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //?line card statistics
                  StatisticsCard(
                    child: Column(
                      children: [
                        StatisticsOptions(
                          chartType:
                              LineChart(context.read<LineStatisticsCubit>()),
                        ),
                        BlocBuilder<LineStatisticsCubit, LineStatisticsState>(
                          builder: (context, state) {
                            if (state is LineStatisticsLoading) {
                              return const CustomLoadingIndicator(
                                widgetHeight: 200,
                              );
                            }
                            if (state is FetchedLineWeekStatisticsState) {
                              return LineStatisticsWidget(
                                maxValue: state.weekStatistics.maxValue,
                                items: state.weekStatistics.items,
                              );
                            }
                            if (state is FetchedLineYearStatisticsState) {
                              return LineStatisticsWidget(
                                maxValue: state.statistics.maxValue,
                                items: state.statistics.items,
                              );
                            }
                            return const SizedBox();
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LineStatisticsWidget extends StatelessWidget {
  const LineStatisticsWidget({
    super.key,
    required this.maxValue,
    required this.items,
  });

  final double maxValue;
  final List<TimeBasedStatistics> items;

  @override
  Widget build(BuildContext context) {
    //?40 is the padding.
    final width = MediaQuery.of(context).size.width - 40;
    return Center(
      child: AnimatedLinedStatistics(
        //?this is the number of items it can be 7 if week or 12 if year.
        width: width,
        //?this actually set the height of the y axis.
        height: 150,
        points: List.generate(items.length, (index) {
          final dx = (width / items.length) * index;
          //?this be sure that the point dy won't pass the maximum yD value(150).
          final dy = ((maxValue - items[index].amount) / maxValue) * 150;
          log('state offset: Offset($dx,$dy)');
          return LinePoint(
            //?actual value if the represented item
            value: items[index].amount,
            //?the label on the x axis with yd=>0
            label: items[index].name,
            //?the position of the point in the xy demotions
            offset: Offset(dx, dy),
          );
        }),
      ),
    );
  }
}

class BarStatisticsListView extends StatelessWidget {
  const BarStatisticsListView({
    super.key,
    required this.length,
    required this.totalSpent,
    required this.itemBuilder,
  });

  final int length;
  final double totalSpent;
  final Widget? Function(BuildContext, int) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 180,
        child: Stack(
          children: [
            BlocBuilder<BarDetailsCubit, BarDetailsState>(
              builder: (context, state) {
                final isBarSelected = state is SelectedBarState;
                if (isBarSelected) {
                  log('index: ${state.selectedIndex}');
                }
                return Positioned(
                  top: 0,
                  left: isBarSelected ? state.barIndex! * 10 : 0.0,
                  child: Visibility(
                    visible: isBarSelected,
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
                          Text(isBarSelected ? state.date : ''),
                          Text(isBarSelected ? '${state.amount}' : ''),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: length,
              itemBuilder: itemBuilder,
            ),
          ],
        ),
      ),
    );
  }
}

class StatisticsOptions extends StatelessWidget {
  const StatisticsOptions({
    super.key,
    required this.chartType,
  });
  final ChartTypeHelperInterface chartType;
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          appLocalizations.expensePer,
          style: const TextStyle(fontSize: 10),
        ),
        BlocProvider(
          create: (context) => ButtonOptionCubit(),
          child: Builder(builder: (context) {
            return BlocBuilder<ButtonOptionCubit, ButtonOption>(
              builder: (context, selectedOption) {
                return Row(
                  children: [
                    StatisticsOptionButton(
                      label: appLocalizations.weekly,
                      selected: selectedOption == ButtonOption.weekly,
                      onTap: () {
                        context
                            .read<ButtonOptionCubit>()
                            .selectOption(ButtonOption.weekly);
                        //?this will request the monthly option
                        chartType.fetchWeeklyStatistics();
                      },
                    ),
                    StatisticsOptionButton(
                      label: appLocalizations.yearly,
                      selected: selectedOption == ButtonOption.yearly,
                      onTap: () {
                        context
                            .read<ButtonOptionCubit>()
                            .selectOption(ButtonOption.yearly);
                        chartType.fetchYearlyStatistics();

                        //?this will request the yearly option
                      },
                    ),
                  ],
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
