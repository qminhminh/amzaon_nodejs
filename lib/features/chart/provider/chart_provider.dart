import 'package:amazon_clone_nodejs/features/chart/model/chart_model.dart';
import 'package:flutter/widgets.dart';

class ChartProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  Chart _chart = Chart(objectid: '', id: '', moneys: []);

  Chart get chart => _chart;

  void setChart(String chart) {
    _chart = Chart.fromJson(chart);
    notifyListeners();
  }

  void setChartFRomModel(Chart chart) {
    _chart = chart;
    notifyListeners();
  }
}
