import 'package:expense_tracker/domain/helper/interface/i_chart_type.dart';
import 'package:expense_tracker/presentation/components/statistics/option_button/button_option_cubit/button_option_cubit.dart';
import 'package:expense_tracker/presentation/components/statistics/option_button/option_button.dart';
import 'package:expense_tracker/util/enum/enums.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StatisticsOptions extends StatelessWidget {
  const StatisticsOptions({
    super.key,
    required this.chartType,
  });
  final ChartTypeHelper chartType;
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
