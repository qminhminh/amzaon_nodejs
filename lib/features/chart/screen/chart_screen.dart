import 'package:amazon_clone_nodejs/features/chart/model/chart_model.dart';
import 'package:amazon_clone_nodejs/features/chart/services/chart_services.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ChartScreen extends StatefulWidget {
  static const String routeName = "/chart";
  const ChartScreen({Key? key}) : super(key: key);

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  final ChartServices _chartServices = ChartServices();
  List<Chart>? _list;
  int total = 0;
  String previousDate = '';
  String currentDay = '';

  @override
  void initState() {
    super.initState();
    fetchDataChart();
  }

  void fetchDataChart() async {
    _list = await _chartServices.getChart(context: context);

    if (_list != null) {
      total = 0; // Reset total
      previousDate = ''; // Reset previous date

      for (var chart in _list!) {
        for (var point in chart.moneys) {
          String date = point['date'] ?? '';
          int money = point['money'] as int;

          if (date.isNotEmpty) {
            if (date != previousDate) {
              // Ngày mới, reset tổng tiền và cập nhật ngày hiện tại
              total = money;
              currentDay = date;
            } else {
              // Cùng ngày, cộng thêm tiền
              total += money;
            }
            previousDate = date;
          }
        }
      }

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: BarChart(
            BarChartData(
              barGroups: _chartGroups(),
              borderData: FlBorderData(
                  border:
                      const Border(bottom: BorderSide(), left: BorderSide())),
              gridData: const FlGridData(show: false),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(sideTitles: _bottomTitles),
                leftTitles: AxisTitles(sideTitles: _leftTitles),
                topTitles: AxisTitles(sideTitles: _topTitles),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _chartGroups() {
    if (_list != null) {
      return _list!
          .map(
            (chart) => chart.moneys.map(
              (point) => BarChartGroupData(
                x: chart.moneys.indexOf(point), // Use the index as X
                barRods: [
                  BarChartRodData(
                    toY: point['money'].toDouble(),
                  ), // Use 'money' as Y
                ],
              ),
            ),
          )
          .expand((group) => group)
          .toList();
    } else {
      return [];
    }
  }

  // bootm
  SideTitles get _bottomTitles {
    if (_list != null) {
      // Extract all unique dates
      // ignore: prefer_collection_literals
      Set<String> uniqueDates = Set<String>();
      for (var chart in _list!) {
        for (var point in chart.moneys) {
          String date = point['date'] ?? '';
          uniqueDates.add(date);
        }
      }

      // Convert set of unique dates to a list and sort them if needed
      List<String> sortedDates = uniqueDates.toList();
      sortedDates.sort();

      // Generate titles based on unique dates
      return SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (_list != null) {
            int index = value.toInt();
            if (index >= 0 && index < sortedDates.length) {
              return Text(sortedDates[index]);
            }
          }
          return const Text('');
        },
      );
    } else {
      return const SideTitles(showTitles: false);
    }
  }

  SideTitles get _topTitles {
    if (_list != null) {
      // Extract all unique dates
      // ignore: prefer_collection_literals
      Set<String> uniqueDates = Set<String>();
      for (var chart in _list!) {
        for (var point in chart.moneys) {
          int date = point['money'] ?? 0;
          uniqueDates.add(date.toString());
        }
      }

      // Convert set of unique dates to a list and sort them if needed
      List<String> sortedDates = uniqueDates.toList();
      sortedDates.sort();

      // Generate titles based on unique dates
      return SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (_list != null) {
            int index = value.toInt();
            if (index >= 0 && index < sortedDates.length) {
              return Text(sortedDates[index]);
            }
          }
          return const Text('');
        },
      );
    } else {
      return const SideTitles(showTitles: false);
    }
  }

  SideTitles get _leftTitles {
    if (_list != null) {
      // Extract all unique dates
      // ignore: prefer_collection_literals
      Set<String> uniqueDates = Set<String>();
      for (var chart in _list!) {
        for (var point in chart.moneys) {
          int date = point['money'] ?? 0;
          uniqueDates.add(date.toString());
        }
      }

      // Convert set of unique dates to a list and sort them if needed
      List<String> sortedDates = uniqueDates.toList();
      sortedDates.sort();

      // Generate titles based on unique dates
      return SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (_list != null) {
            int index = value.toInt();
            if (index >= 0 && index < sortedDates.length) {
              return Text(sortedDates[index]);
            }
          }
          return const Text('');
        },
      );
    } else {
      return const SideTitles(showTitles: false);
    }
  }
}
