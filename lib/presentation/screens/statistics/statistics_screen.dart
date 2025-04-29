import 'package:expense_tracker/presentation/components/statistics/bar_statistics/bar_details_cubit.dart';
import 'package:expense_tracker/presentation/components/statistics/bar_statistics/full_bar_statistics_item.dart';
import 'package:expense_tracker/presentation/components/statistics/cubit/button_option_cubit.dart';
import 'package:expense_tracker/presentation/components/statistics/option_button/option_button.dart';
import 'package:expense_tracker/presentation/components/statistics/pie_chart.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_card.dart';
import 'package:expense_tracker/presentation/screens/statistics/bar_statistics_cubit/bar_statistics_cubit.dart';
import 'package:expense_tracker/presentation/screens/statistics/pie_statistics_cubit/category_statistics_cubit.dart';
import 'package:expense_tracker/presentation/theme/color_manger.dart';
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
              bottom: 8.0,
              left: 8.0,
              right: 8.0,
              top: height * .1,
            ),
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
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              appLocalizations.expensePer,
                              style: const TextStyle(fontSize: 10),
                            ),
                            BlocProvider(
                              create: (context) => ButtonOptionCubit(),
                              child: Builder(builder: (context) {
                                return BlocBuilder<ButtonOptionCubit,
                                    ButtonOption>(
                                  builder: (context, option) {
                                    return Row(
                                      children: [
                                        StatisticsOptionButton(
                                          label: appLocalizations.weekly,
                                          selected:
                                              option == ButtonOption.monthly,
                                          onTap: () {
                                            context
                                                .read<ButtonOptionCubit>()
                                                .selectOption(
                                                    ButtonOption.monthly);
                                            //?this will request the monthly option
                                            context
                                                .read<BarStatisticsCubit>()
                                                .fetchBarWeekStatistics();
                                            context
                                                .read<BarDetailsCubit>()
                                                .select(null);
                                          },
                                        ),
                                        StatisticsOptionButton(
                                          label: appLocalizations.yearly,
                                          selected:
                                              option == ButtonOption.yearly,
                                          onTap: () {
                                            context
                                                .read<ButtonOptionCubit>()
                                                .selectOption(
                                                    ButtonOption.yearly);
                                            context
                                                .read<BarStatisticsCubit>()
                                                .fetchBarYearStatistics();
                                            context
                                                .read<BarDetailsCubit>()
                                                .select(null);
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
                        ),

                        BlocBuilder<BarStatisticsCubit, BarStatisticsState>(
                          builder: (context, state) {
                            if (state is BarStatisticsLoading) {
                              return const Center(
                                child: CircularProgressIndicator.adaptive(),
                              );
                            }
                            if (state is FetchedBarWeekStatisticsState) {
                              final days = state.statistics.days;
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
                                    label: day.dayName,
                                    totalSpent: totalSpent,
                                  );
                                },
                              );
                            }
                            if (state is FetchedBarYearStatisticsState) {
                              final months = state.statistics.months;
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
                                      label: month.monthName,
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
              ],
            ),
          ),
        ],
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
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          
          itemCount: length,
          itemBuilder: itemBuilder,
        ),
      ),
    );
  }
}
