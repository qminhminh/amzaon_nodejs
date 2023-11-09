import 'package:amazon_clone_nodejs/features/admin/models/sales.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesData;

  CategoryProductsChart({
    Key? key,
    required this.salesData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        titlesData: const FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: salesData
            .asMap()
            .entries
            .map((entry) => BarChartGroupData(
                  x: entry.key,
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.earning.toDouble(),
                      width: 20, // Width of each bar
                      color: Colors.blue, // Color of the bar
                    ),
                  ],
                ))
            .toList(),
      ),
    );
  }
}
