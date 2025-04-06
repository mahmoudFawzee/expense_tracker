import 'package:expense_tracker/view/components/custom_shape.dart';
import 'package:expense_tracker/view/theme/color_manger.dart';
import 'package:flutter/material.dart';

class AuthBase extends StatelessWidget {
  const AuthBase({
    super.key,
    required this.child,
  });
  final Widget child;
  static const pageRoute = '/auth_route';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: ClipPath(
              clipper: const CustomShape(),
              child: Container(
                height: 250,
                color: ColorsMangerLight.primaryColor,
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
