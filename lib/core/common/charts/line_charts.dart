import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ChartData {
  final String label;
  final double value;

  ChartData(this.label, this.value);
}

class SalesLineChart extends StatelessWidget {
  SalesLineChart({super.key});

  final List<ChartData> chartData = [
    ChartData('Jan', 120),
    ChartData('Feb', 150),
    ChartData('Mar', 90),
    ChartData('Apr', 180),
    ChartData('May', 140),
    ChartData('Jun', 200),
    ChartData('Jul', 170),
    ChartData('Aug', 160),
    ChartData('Sep', 190),
    ChartData('Oct', 210),
    ChartData('Nov', 230),
    ChartData('Dec', 250),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Monthly Sales'),
      tooltipBehavior: TooltipBehavior(enable: true),

      primaryXAxis: CategoryAxis(title: AxisTitle(text: 'Month')),

      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Sales')),

      series: <LineSeries<ChartData, String>>[
        LineSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.label,
          yValueMapper: (ChartData data, _) => data.value,

          color: Colors.blue,
          width: 3,
          markerSettings: const MarkerSettings(isVisible: true),
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class SalesSplineChart extends StatelessWidget {
  SalesSplineChart({super.key});

  final List<ChartData> chartData = [
    ChartData('Jan', 120),
    ChartData('Feb', 150),
    ChartData('Mar', 90),
    ChartData('Apr', 180),
    ChartData('May', 140),
    ChartData('Jun', 200),
    ChartData('Jul', 170),
    ChartData('Aug', 160),
    ChartData('Sep', 190),
    ChartData('Oct', 210),
    ChartData('Nov', 230),
    ChartData('Dec', 250),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Yearly Sales (Spline)'),
      tooltipBehavior: TooltipBehavior(enable: true),

      primaryXAxis: CategoryAxis(
        title: AxisTitle(text: 'Month'),
        labelRotation: -45,
        majorGridLines: const MajorGridLines(width: 0),
      ),

      primaryYAxis: NumericAxis(title: AxisTitle(text: 'Sales')),

      series: <SplineSeries<ChartData, String>>[
        SplineSeries<ChartData, String>(
          dataSource: chartData,
          xValueMapper: (ChartData data, _) => data.label,
          yValueMapper: (ChartData data, _) => data.value,

          color: Colors.blue,
          width: 3,
          markerSettings: const MarkerSettings(isVisible: true),
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class RadialData {
  final String label;
  final double value;

  RadialData(this.label, this.value);
}

class SalesRadialBar extends StatelessWidget {
  SalesRadialBar({super.key});

  final List<RadialData> data = [
    RadialData('Sales', 50), // 75%
    RadialData('Sales', 60), // 75%
    RadialData('Sales', 70), // 75%
    RadialData('Sales', 80), // 75%
  ];

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: 'Sales Target'),
      legend: Legend(isVisible: false),

      series: <CircularSeries>[
        RadialBarSeries<RadialData, String>(
          dataSource: data,
          xValueMapper: (RadialData data, _) => data.label,
          yValueMapper: (RadialData data, _) => data.value,

          maximumValue: 100,
          radius: '90%',
          innerRadius: '70%',
          gap: '5%',

          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            labelPosition: ChartDataLabelPosition.inside,
          ),
        ),
      ],
    );
  }
}

class CustomerRank {
  final String name;
  final double value;

  CustomerRank(this.name, this.value);
}




class CustomerPyramidChart extends StatelessWidget {
  CustomerPyramidChart({super.key});

  final List<CustomerRank> data = [
    CustomerRank('Customer A', 100),
    CustomerRank('Customer B', 80),
    CustomerRank('Customer C', 60),
    CustomerRank('Customer D', 40),
    CustomerRank('Customer E', 20),
  ];

  @override
  Widget build(BuildContext context) {
    return SfPyramidChart(
      title: ChartTitle(text: 'Customer Ranking'),

      tooltipBehavior: TooltipBehavior(enable: true),

      series: PyramidSeries<CustomerRank, String>(
        dataSource: data,

        xValueMapper: (CustomerRank data, _) => data.name,
        yValueMapper: (CustomerRank data, _) => data.value,

        gapRatio: 0.05,
        pyramidMode: PyramidMode.surface,
        explode: true,
        explodeIndex: 0,

        // ✅ Label settings
        dataLabelSettings: DataLabelSettings(
          isVisible: true,
          labelPosition: ChartDataLabelPosition.inside,
          builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) => Text(data.name), // only name
        ),
      ),
    );
  }
}


