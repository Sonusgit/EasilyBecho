import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ReusableBarChart extends StatelessWidget {
  final Map<String, double> data;
  final String title;
  final Color barColor;
  final Color? backgroundColor;
  final double chartHeight;
  final bool showGrid;
  final bool showValues;
  final String valuePrefix;
  final String valueSuffix;

  const ReusableBarChart({
    Key? key,
    required this.data,
    required this.title,
    this.barColor = const Color(0xFF6366F1),
    this.backgroundColor,
    this.chartHeight = 300,
    this.showGrid = true,
    this.showValues = true,
    this.valuePrefix = '',
    this.valueSuffix = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty || data.values.every((v) => v == 0)) {
      return _buildEmptyChart();
    }

    final chartData = data.entries
        .map((e) => ChartData(label: e.key, value: e.value))
        .toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: chartHeight,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              primaryYAxis: NumericAxis(
                majorGridLines: MajorGridLines(
                  width: showGrid ? 1 : 0,
                  color: Colors.grey[300],
                  dashArray: const [5, 5],
                ),
                axisLine: AxisLine(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                labelStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
                numberFormat: _getNumberFormat(),
              ),
              plotAreaBorderWidth: 0,
              plotAreaBorderColor: Colors.transparent,
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: Colors.black87,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                format: 'point.x\n$valuePrefix point.y $valueSuffix',
              ),
              series: <CartesianSeries>[
                ColumnSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => _getBottomLabel(data.label),
                  yValueMapper: (ChartData data, _) => data.value,
                  color: barColor,
                  width: 0.6,
                  spacing: 0.2,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4),
                  ),
                  dataLabelSettings: DataLabelSettings(
                    isVisible: showValues,
                    textStyle: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                    labelAlignment: ChartDataLabelAlignment.top,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _getBottomLabel(String key) {
    if (key.contains('-')) {
      final parts = key.split('-');
      if (parts.length == 2) {
        final month = int.tryParse(parts[1]);
        if (month != null) {
          const months = [
            'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
          ];
          return months[month - 1];
        }
      }
    }
    return key.length > 10 ? '${key.substring(0, 8)}..' : key;
  }

  _getNumberFormat() {
    return null; // Syncfusion handles formatting automatically
  }

  Widget _buildEmptyChart() {
    return Container(
      height: chartHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart_outlined,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              'No data available',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusableLineChart extends StatelessWidget {
  final Map<String, double> data;
  final String title;
  final Color lineColor;
  final Color? backgroundColor;
  final double chartHeight;
  final bool showGrid;
  final bool showDots;
  final bool showArea;
  final String valuePrefix;
  final String valueSuffix;

  const ReusableLineChart({
    Key? key,
    required this.data,
    required this.title,
    this.lineColor = const Color(0xFF6366F1),
    this.backgroundColor,
    this.chartHeight = 300,
    this.showGrid = true,
    this.showDots = true,
    this.showArea = true,
    this.valuePrefix = '',
    this.valueSuffix = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty || data.values.every((v) => v == 0)) {
      return _buildEmptyChart();
    }

    final chartData = data.entries
        .map((e) => ChartData(label: e.key, value: e.value))
        .toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            height: chartHeight,
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                labelStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
                interval: _getBottomInterval().toDouble(),
              ),
              primaryYAxis: NumericAxis(
                majorGridLines: MajorGridLines(
                  width: showGrid ? 1 : 0,
                  color: Colors.grey[300],
                  dashArray: const [5, 5],
                ),
                axisLine: AxisLine(
                  color: Colors.grey[300]!,
                  width: 1,
                ),
                labelStyle: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6B7280),
                ),
              ),
              plotAreaBorderWidth: 0,
              plotAreaBorderColor: Colors.transparent,
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: Colors.black87,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
                format: 'point.x\n$valuePrefix point.y $valueSuffix',
              ),
              series: <CartesianSeries>[
                if (showArea)
                  AreaSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => _getBottomLabel(data.label),
                    yValueMapper: (ChartData data, _) => data.value,
                    color: lineColor.withValues(alpha: 0.1),
                    borderColor: lineColor,
                    borderWidth: 3,
                  )
                else
                  LineSeries<ChartData, String>(
                    dataSource: chartData,
                    xValueMapper: (ChartData data, _) => _getBottomLabel(data.label),
                    yValueMapper: (ChartData data, _) => data.value,
                    color: lineColor,
                    width: 3,
                    markerSettings: MarkerSettings(
                      isVisible: showDots,
                      height: 8,
                      width: 8,
                      color: lineColor,
                      borderColor: Colors.white,
                      borderWidth: 2,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  int _getBottomInterval() {
    if (data.length <= 6) return 1;
    if (data.length <= 12) return 2;
    return 3;
  }

  String _getBottomLabel(String key) {
    if (key.contains('-')) {
      final parts = key.split('-');
      if (parts.length == 2) {
        final month = int.tryParse(parts[1]);
        if (month != null) {
          const months = [
            'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
            'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
          ];
          return months[month - 1];
        }
      }
    }
    return key.length > 10 ? '${key.substring(0, 8)}..' : key;
  }

  Widget _buildEmptyChart() {
    return Container(
      height: chartHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.show_chart,
              size: 48,
              color: Colors.grey[400],
            ),
            const SizedBox(height: 12),
            Text(
              'No data available',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReusablePieChart extends StatelessWidget {
  final Map<String, double> data;
  final String title;
  final List<Color>? colors;
  final Color? backgroundColor;
  final double chartHeight;
  final bool showLegend;
  final bool showDataLabels;
  final String valuePrefix;
  final String valueSuffix;

  const ReusablePieChart({
    Key? key,
    required this.data,
    required this.title,
    this.colors,
    this.backgroundColor,
    this.chartHeight = 300,
    this.showLegend = true,
    this.showDataLabels = true,
    this.valuePrefix = '',
    this.valueSuffix = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty || data.values.every((v) => v == 0)) {
      return _buildEmptyChart();
    }

    final chartData = data.entries
        .map((e) => ChartData(label: e.key, value: e.value))
        .toList();

    final defaultColors = [
      const Color(0xFF6366F1),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEC4899),
      const Color(0xFF8B5CF6),
      const Color(0xFF3B82F6),
      const Color(0xFFEF4444),
      const Color(0xFF14B8A6),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: chartHeight,
            child: SfCircularChart(
              legend: Legend(
                isVisible: showLegend,
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
                textStyle: const TextStyle(fontSize: 11),
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: Colors.black87,
                textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                format: 'point.x: $valuePrefix point.y $valueSuffix',
              ),
              series: <CircularSeries>[
                PieSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.label,
                  yValueMapper: (ChartData data, _) => data.value,
                  pointColorMapper: (ChartData data, int index) =>
                      colors != null && index < colors!.length
                          ? colors![index]
                          : defaultColors[index % defaultColors.length],
                  dataLabelSettings: DataLabelSettings(
                    isVisible: showDataLabels,
                    labelPosition: ChartDataLabelPosition.outside,
                    textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                  explode: true,
                  explodeIndex: 0,
                  explodeOffset: '5%',
                  radius: '80%',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChart() {
    return Container(
      height: chartHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.pie_chart_outline, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              'No data available',
              style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// ============= REUSABLE DOUGHNUT CHART =============
class ReusableDoughnutChart extends StatelessWidget {
  final Map<String, double> data;
  final String title;
  final List<Color>? colors;
  final Color? backgroundColor;
  final double chartHeight;
  final bool showLegend;
  final bool showDataLabels;
  final String valuePrefix;
  final String valueSuffix;
  final String? centerText;

  const ReusableDoughnutChart({
    Key? key,
    required this.data,
    required this.title,
    this.colors,
    this.backgroundColor,
    this.chartHeight = 300,
    this.showLegend = true,
    this.showDataLabels = true,
    this.valuePrefix = '',
    this.valueSuffix = '',
    this.centerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty || data.values.every((v) => v == 0)) {
      return _buildEmptyChart();
    }

    final chartData = data.entries
        .map((e) => ChartData(label: e.key, value: e.value))
        .toList();

    final defaultColors = [
      const Color(0xFF6366F1),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEC4899),
      const Color(0xFF8B5CF6),
      const Color(0xFF3B82F6),
    ];

    final total = data.values.reduce((a, b) => a + b);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: chartHeight,
            child: SfCircularChart(
              legend: Legend(
                isVisible: showLegend,
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
                textStyle: const TextStyle(fontSize: 11),
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: Colors.black87,
                textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                format: 'point.x: $valuePrefix point.y $valueSuffix',
              ),
              annotations: centerText != null
                  ? [
                      CircularChartAnnotation(
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              centerText!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF6B7280),
                              ),
                            ),
                            Text(
                              '$valuePrefix${total.toStringAsFixed(0)}$valueSuffix',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]
                  : null,
              series: <CircularSeries>[
                DoughnutSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.label,
                  yValueMapper: (ChartData data, _) => data.value,
                  pointColorMapper: (ChartData data, int index) =>
                      colors != null && index < colors!.length
                          ? colors![index]
                          : defaultColors[index % defaultColors.length],
                  dataLabelSettings: DataLabelSettings(
                    isVisible: showDataLabels,
                    labelPosition: ChartDataLabelPosition.outside,
                    textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                  innerRadius: '60%',
                  radius: '80%',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChart() {
    return Container(
      height: chartHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.donut_large, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              'No data available',
              style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// ============= REUSABLE RADIAL BAR CHART =============
class ReusableRadialBarChart extends StatelessWidget {
  final Map<String, double> data;
  final String title;
  final List<Color>? colors;
  final Color? backgroundColor;
  final double chartHeight;
  final bool showLegend;
  final bool showDataLabels;
  final double maxValue;

  const ReusableRadialBarChart({
    Key? key,
    required this.data,
    required this.title,
    this.colors,
    this.backgroundColor,
    this.chartHeight = 300,
    this.showLegend = true,
    this.showDataLabels = true,
    this.maxValue = 100,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty || data.values.every((v) => v == 0)) {
      return _buildEmptyChart();
    }

    final chartData = data.entries
        .map((e) => ChartData(label: e.key, value: e.value))
        .toList();

    final defaultColors = [
      const Color(0xFF6366F1),
      const Color(0xFF10B981),
      const Color(0xFFF59E0B),
      const Color(0xFFEC4899),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1A1A1A),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: chartHeight,
            child: SfCircularChart(
              legend: Legend(
                isVisible: showLegend,
                position: LegendPosition.bottom,
                overflowMode: LegendItemOverflowMode.wrap,
                textStyle: const TextStyle(fontSize: 11),
              ),
              tooltipBehavior: TooltipBehavior(
                enable: true,
                color: Colors.black87,
                textStyle: const TextStyle(color: Colors.white, fontSize: 12),
                format: 'point.x: point.y%',
              ),
              series: <CircularSeries>[
                RadialBarSeries<ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (ChartData data, _) => data.label,
                  yValueMapper: (ChartData data, _) => data.value,
                  pointColorMapper: (ChartData data, int index) =>
                      colors != null && index < colors!.length
                          ? colors![index]
                          : defaultColors[index % defaultColors.length],
                  dataLabelSettings: DataLabelSettings(
                    isVisible: showDataLabels,
                    textStyle: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                  maximumValue: maxValue,
                  radius: '100%',
                  gap: '10%',
                  innerRadius: '30%',
                  cornerStyle: CornerStyle.bothCurve,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyChart() {
    return Container(
      height: chartHeight,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.donut_small, size: 48, color: Colors.grey[400]),
            const SizedBox(height: 12),
            Text(
              'No data available',
              style: TextStyle(fontSize: 14, color: Colors.grey[600], fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}

// Helper class for chart data
class ChartData {
  final String label;
  final double value;

  ChartData({required this.label, required this.value});
}
