import 'package:amazon_clone_nodejs/common/widgets/loader.dart';
import 'package:amazon_clone_nodejs/features/admin/models/sales.dart';
import 'package:amazon_clone_nodejs/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Import the fl_chart library

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({Key? key}) : super(key: key);

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  final AdminServices adminServices = AdminServices();
  int? totalSales;
  List<Sales>? earnings;

  @override
  void initState() {
    super.initState();
    getEarnings();
  }

  getEarnings() async {
    var earningData = await adminServices.getEarnings(context);
    totalSales = earningData['totalEarnings'];
    earnings = earningData['sales'];
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return earnings == null || totalSales == null
        ? const Loader()
        : Column(
            children: [
              Text(
                '\$$totalSales',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 250,
                child: CategoryProductsChart(
                    salesData: earnings!), // Pass salesData
              ),
            ],
          );
  }
}

class CategoryProductsChart extends StatelessWidget {
  final List<Sales> salesData; // Use List<Sales> instead of charts.Series
  const CategoryProductsChart({
    Key? key,
    required this.salesData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
        // ignore: prefer_const_constructors
        titlesData: FlTitlesData(show: false),
        borderData: FlBorderData(show: false),
        barGroups: salesData
            .asMap()
            .entries
            .map((entry) => BarChartGroupData(
                  x: entry.key, // Convert to double
                  barRods: [
                    BarChartRodData(
                      toY: entry.value.earning.toDouble(), // Convert to double
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
