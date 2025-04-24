import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class CustomPieChart extends StatelessWidget {
  const CustomPieChart({
    super.key,
    required this.dataMap,
  });
  final Map<String, double> dataMap;
  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: dataMap,
      animationDuration: const Duration(milliseconds: 800),
      chartLegendSpacing: 64,
      chartRadius: MediaQuery.of(context).size.width / 3.2,
      colorList: const [
        Colors.blue,
        Colors.red,
        Colors.green,
        Colors.yellow,
      ],
      initialAngleInDegree: 0,
      chartType: ChartType.ring,
      ringStrokeWidth: 32,
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.right,
        showLegends: true,
        legendShape: BoxShape.circle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: true,
        showChartValues: true,
        showChartValuesInPercentage: false,
        showChartValuesOutside: true,
        decimalPlaces: 1,
      ),
    );
  }
}
