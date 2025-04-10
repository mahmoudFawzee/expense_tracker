import 'package:expense_tracker/app/cubits/navigation_cubit.dart';
import 'package:expense_tracker/presentation/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeBase extends StatelessWidget {
  const HomeBase({
    super.key,
    required this.child,
  });
  static const pageRoute = '/home_base';
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    return SafeArea(
      child: Scaffold(
        body: child,
        bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
          builder: (context, currentIndex) {
            return BottomNavigationBar(
              selectedLabelStyle: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .copyWith(color: ColorsMangerDark.primaryColor),
              unselectedLabelStyle:
                  Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Colors.grey,
                      ),
              currentIndex: currentIndex,
              onTap: (value) {
                //?it will give us
                context.go(NavigationCubit.routes[value]);
                context.read<NavigationCubit>().navigateTo(value);
              },
              items: [
                _bottomNavBarItem(
                  label: appLocalizations.statistics,
                  icon: Icons.bar_chart_rounded,
                ),
                _bottomNavBarItem(
                  label: appLocalizations.expenses,
                  icon: Icons.home,
                ),
                _bottomNavBarItem(
                  label: appLocalizations.profile,
                  icon: Icons.person,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBarItem({
    required String label,
    required IconData icon,
  }) {
    return BottomNavigationBarItem(
      label: label,
      icon: Icon(
        icon,
      ),
    );
  }
}
