import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
class SalesData {
  final String month;
  final double sales;

  SalesData(this.month, this.sales);
}

class YearlySalesBarChart extends StatelessWidget {
  YearlySalesBarChart({super.key});

  final List<SalesData> data = [
    SalesData('Jan', 120),
    SalesData('Feb', 150),
    SalesData('Mar', 90),
    SalesData('Apr', 180),
    SalesData('May', 140),
    SalesData('Jun', 200),
    SalesData('Jul', 170),
    SalesData('Aug', 160),
    SalesData('Sep', 190),
    SalesData('Oct', 210),
    SalesData('Nov', 230),
    SalesData('Dec', 250),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      title: ChartTitle(text: 'Yearly Sales (Bar)'),
      primaryXAxis: CategoryAxis(
        labelRotation: -45,
      ),
      primaryYAxis: NumericAxis(
        title: AxisTitle(text: 'Sales'),
      ),
      legend: Legend(
        isVisible: false,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries>[
        ColumnSeries<SalesData, String>(
          dataSource: data,
          xValueMapper: (SalesData d, _) => d.month,
          yValueMapper: (SalesData d, _) => d.sales,
          color: Colors.blue,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
