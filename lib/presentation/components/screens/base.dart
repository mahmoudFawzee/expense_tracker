import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({
    super.key,
    required this.imagePath,
    required this.buttonLabel,
    required this.statusText,
    required this.textColor,
    required this.onTap,
  });
  final String imagePath, buttonLabel, statusText;
  final Color textColor;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                width: 250,
                height: 250,
                imagePath,
              ),
              const SizedBox(height: 20),
              Text(
                statusText,
                style: Theme.of(context).textTheme.displayMedium!.copyWith(
                      color: textColor,
                    ),
              )
            ],
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              height: 50,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(
                  color: textColor,
                  width: 2.5,
                ),
              ),
              child: Text(
                buttonLabel,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: textColor,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
