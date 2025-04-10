import 'package:expense_tracker/app/cubits/navigation_cubit.dart';
import 'package:expense_tracker/presentation/theme/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeBase extends StatelessWidget {
  const HomeBase({
    super.key,
    required this.child,
  });
  static const pageRoute = '/home_base';
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                route: NavigationCubit.routes.first,
                icon: Icons.view_column,
              ),
              _bottomNavBarItem(
                route: NavigationCubit.routes[1],
                icon: Icons.home,
              ),
              _bottomNavBarItem(
                route: NavigationCubit.routes[2],
                icon: Icons.person,
              ),
            ],
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _bottomNavBarItem({
    required String route,
    required IconData icon,
  }) {
    return BottomNavigationBarItem(
      label: route.split('_').first.substring(1),
      icon: Icon(
        icon,
      ),
    );
  }
}
