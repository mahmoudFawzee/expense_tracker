import 'package:expense_tracker/data/helper/bar_chart.dart';
import 'package:expense_tracker/data/helper/line_chart.dart';
import 'package:expense_tracker/presentation/components/app_bar/underlayer_app_bar.dart';
import 'package:expense_tracker/presentation/components/custom_loading_indicator.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_item_details_cubit/statistics_item_details_cubit.dart';
import 'package:expense_tracker/presentation/components/statistics/bar_statistics/bar_statistics_list_view.dart';
import 'package:expense_tracker/presentation/components/statistics/line_statistics/line_statistics_widget.dart';
import 'package:expense_tracker/presentation/components/statistics/option_button/statistics_options_widget.dart';
import 'package:expense_tracker/presentation/components/statistics/pie_chart.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_card.dart';
import 'package:expense_tracker/presentation/screens/statistics/bar_statistics_cubit/bar_statistics_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/line_statistics_cubit/line_statistics_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/pie_statistics_cubit/category_statistics_cubit.dart';
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
          UnderLayerAppBar(
            label: appLocalizations.statistics,
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
                    create: (context) => StatisticsItemDetailsCubit(),
                    child: Builder(builder: (context) {
                      return StatisticsCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            //?select statistics type buttons
                            StatisticsOptions(
                              chartType: BarChart(
                                context.read<BarStatisticsCubit>(),
                                itemDetailsCubit:
                                    context.read<StatisticsItemDetailsCubit>(),
                              ),
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
                                  final totalSpent =
                                      state.statistics.totalSpent;
                                  return BarStatisticsListView(
                                    length: days.length,
                                    totalSpent: totalSpent,
                                    items: days,
                                  );
                                }
                                if (state is FetchedBarYearStatisticsState) {
                                  final months = state.statistics.items;
                                  final totalSpent =
                                      state.statistics.totalSpent;
                                  return BarStatisticsListView(
                                    length: months.length,
                                    totalSpent: totalSpent,
                                    items: months,
                                  );
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
                      );
                    }),
                  ),
                  const SizedBox(height: 20),

                  //?line card statistics
                  BlocProvider(
                    create: (context) => StatisticsItemDetailsCubit(),
                    child: Builder(builder: (context) {
                      return StatisticsCard(
                        child: Column(
                          children: [
                            StatisticsOptions(
                              chartType: LineChart(
                                  context.read<LineStatisticsCubit>(),
                                  itemDetailsCubit: context
                                      .read<StatisticsItemDetailsCubit>()),
                            ),
                            BlocBuilder<LineStatisticsCubit,
                                LineStatisticsState>(
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
                      );
                    }),
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
