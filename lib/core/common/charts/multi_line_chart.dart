import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final String label;
  final double sales;
  final double profit;

  ChartData(this.label, this.sales, this.profit);
}

class MultiSplineChart extends StatelessWidget {
  MultiSplineChart({super.key});

  final List<ChartData> salesData = [
    ChartData('Jan', 120, 30),
    ChartData('Feb', 150, 50),
    ChartData('Mar', 90, 20),
    ChartData('Apr', 180, 80),
    ChartData('May', 140, 60),
    ChartData('Jun', 200, 90),
    ChartData('Jul', 170, 70),
    ChartData('Aug', 160, 60),
    ChartData('Sep', 190, 80),
    ChartData('Oct', 210, 100),
    ChartData('Nov', 230, 120),
    ChartData('Dec', 250, 130),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Sales & Profit (Spline - Full Year)'),
      primaryXAxis: CategoryAxis(
        labelRotation: -45,
        majorGridLines: const MajorGridLines(width: 0),
      ),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries>[
        SplineSeries<ChartData, String>(
          name: 'Sales',
          dataSource: salesData,
          xValueMapper: (ChartData data, _) => data.label,
          yValueMapper: (ChartData data, _) => data.sales,
          color: Colors.blue,
          width: 3,
          markerSettings: const MarkerSettings(isVisible: true),
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
        SplineSeries<ChartData, String>(
          name: 'Profit',
          dataSource: salesData,
          xValueMapper: (ChartData data, _) => data.label,
          yValueMapper: (ChartData data, _) => data.profit,
          color: Colors.green,
          width: 3,
          markerSettings: const MarkerSettings(isVisible: true),
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

