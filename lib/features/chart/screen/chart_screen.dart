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
                      toY: point['money'].toDouble()), // Use 'money' as Y
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
  SideTitles get _bottomTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (_list != null) {
            int index = value.toInt();
            if (index >= 0 && index < _list!.length) {
              // Assuming you have a 'date' property in your 'point' data.
              String date = _list![index].moneys.first['date'] ?? '';
              if (date != currentDay) {
                // Ngày khác nhau, hiển thị ngày
                return Text(date);
              }
              // You can format the date as needed.
              return Text(date);
            }
          }

          // Return an empty Text widget when conditions are not met.
          return const Text('');
        },
      );

  // top title
  SideTitles get _topTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (_list != null) {
            int index = value.toInt();
            if (index >= 0 && index < _list!.length) {
              return Text('$total');
            }
          }

          // Return an empty Text widget when conditions are not met.
          return const Text('');
        },
      );

  SideTitles get _leftTitles => SideTitles(
        showTitles: true,
        getTitlesWidget: (value, meta) {
          if (_list != null) {
            int index = value.toInt();
            if (index >= 0 && index < _list!.length) {
              // Assuming you have a 'date' property in your 'point' data.
              int money = _list![index].moneys.first['money'] as int;

              // You can format the date as needed.
              return Text('$money');
            }
          }

          // Return an empty Text widget when conditions are not met.
          return const Text('');
        },
      );
}
