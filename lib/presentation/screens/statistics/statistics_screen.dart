import 'package:expense_tracker/presentation/components/statistics/cubit/button_option_cubit.dart';
import 'package:expense_tracker/presentation/components/statistics/pie_chart.dart';
import 'package:expense_tracker/presentation/components/statistics/statistics_card.dart';
import 'package:expense_tracker/presentation/screens/statistics/cubit/category_statistics_cubit.dart';
import 'package:expense_tracker/presentation/theme/color_manger.dart';

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
      //appBar: CustomAppBar(title: appLocalizations.statistics),
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
                StatisticsCard(
                  child: Column(
                    children: [
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
                                      StatisticsPerButton(
                                        label: appLocalizations.monthly,
                                        selected:
                                            option == ButtonOption.monthly,
                                        onTap: () {
                                          context
                                              .read<ButtonOptionCubit>()
                                              .selectOption(
                                                  ButtonOption.monthly);
                                          //?this will request the monthly option
                                        },
                                      ),
                                      StatisticsPerButton(
                                        label: appLocalizations.yearly,
                                        selected: option == ButtonOption.yearly,
                                        onTap: () {
                                          context
                                              .read<ButtonOptionCubit>()
                                              .selectOption(
                                                  ButtonOption.yearly);
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
                    ],
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

class StatisticsPerButton extends StatelessWidget {
  const StatisticsPerButton({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });
  final String label;

  final bool selected;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: selected ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: selected
              ? const Color.fromARGB(152, 44, 120, 109)
              : ColorsMangerDark.primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
