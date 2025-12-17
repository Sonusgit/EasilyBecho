import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
class CustomerSegment {
  final String name;
  final double value;

  CustomerSegment(this.name, this.value);
}

class CustomerPieChart extends StatelessWidget {
  CustomerPieChart({super.key});

  final List<CustomerSegment> data = [
    CustomerSegment('Segment A', 40),
    CustomerSegment('Segment B', 30),
    CustomerSegment('Segment C', 20),
    CustomerSegment('Segment D', 10),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: 'Customer Segments (Pie)'),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <PieSeries<CustomerSegment, String>>[
        PieSeries<CustomerSegment, String>(
          dataSource: data,
          xValueMapper: (CustomerSegment data, _) => data.name,
          yValueMapper: (CustomerSegment data, _) => data.value,
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}

class CustomerDoughnutChart extends StatelessWidget {
  CustomerDoughnutChart({super.key});

  final List<CustomerSegment> data = [
    CustomerSegment('Segment A', 40),
    CustomerSegment('Segment B', 30),
    CustomerSegment('Segment C', 20),
    CustomerSegment('Segment D', 10),
  ];

  @override
  Widget build(BuildContext context) {
    return SfCircularChart(
      title: ChartTitle(text: 'Customer Segments (Doughnut)'),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.bottom,
        overflowMode: LegendItemOverflowMode.wrap,
      ),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <DoughnutSeries<CustomerSegment, String>>[
        DoughnutSeries<CustomerSegment, String>(
          dataSource: data,
          xValueMapper: (CustomerSegment data, _) => data.name,
          yValueMapper: (CustomerSegment data, _) => data.value,
          innerRadius: '60%', // center hole
          dataLabelSettings: const DataLabelSettings(isVisible: true),
        ),
      ],
    );
  }
}
