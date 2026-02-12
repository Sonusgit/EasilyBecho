import 'package:easilybecho/core/charts/app_charts.dart';
import 'package:easilybecho/core/charts/line_chart.dart';
import 'package:easilybecho/core/extensions/context_extension.dart';
import 'package:easilybecho/core/network/configs/environment_config.dart';
import 'package:flutter/material.dart';

class ChartsExamplePage extends StatefulWidget {
  const ChartsExamplePage({Key? key}) : super(key: key);

  @override
  State<ChartsExamplePage> createState() => _ChartsExamplePageState();
}

class _ChartsExamplePageState extends State<ChartsExamplePage> {
  // Sample data for different chart types
  final Map<String, double> monthlySalesData = {
    'jan': 45000,
    '2024-02': 52000,
    '2024-03': 48000,
    '2024-04': 61000,
    '2024-05': 55000,
    '2024-06': 68000,
    '2024-07': 72000,
    '2024-08': 65000,
    '2024-09': 78000,
    '2024-10': 82000,
    '2024-11': 75000,
    '2024-12': 88000,
  };

  final Map<String, double> revenueData = {
    '2024-01': 125000,
    '2024-02': 142000,
    '2024-03': 138000,
    '2024-04': 165000,
    '2024-05': 158000,
    '2024-06': 178000,
  };

  final Map<String, double> topProductsData = {
    'Product A': 15000,
    'Product B': 22000,
    'Product C': 18000,
    'Product D': 12000,
    'Product E': 25000,
  };

  final Map<String, double> customerGrowthData = {
    'Jan': 1200,
    'Feb': 1450,
    'Mar': 1680,
    'Apr': 1920,
    'May': 2150,
    'Jun': 2480,
  };
  final Map<String, double> performanceData = {
    'Sales': 85,
    'Marketing': 72,
    'Support': 90,
    'Development': 78,
  };
  final Map<String, double> categoryData = {
    'Electronics': 35000,
    'Clothing': 28000,
    'Food': 42000,
    'Books': 15000,
    'Sports': 22000,
  };

  final Map<String, double> marketShareData = {
    'Product A': 30,
    'Product B': 25,
    'Product C': 20,
    'Product D': 15,
    'Product E': 10,
  };

  final Map<String, double> emptyData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Charts Dashboard',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xFF6366F1),
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Text(EnvironmentConfig.baseUrl),
            // Page Header
            const Text(
              'Analytics Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track your business performance with interactive charts',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            LineChart(),

            // Monthly Sales Bar Chart
            ReusableBarChart(
              data: monthlySalesData,
              title: 'Monthly Sales (2024)',
              barColor: const Color(0xFF6366F1),
              backgroundColor: Colors.white,
              chartHeight: context.screenHeight / 2.5,
              showGrid: true,
              showValues: false,
              valuePrefix: '₹',
              valueSuffix: '',
            ),
            const SizedBox(height: 20),

            // Revenue Line Chart
            ReusableLineChart(
              data: revenueData,
              title: 'Revenue Trend',
              lineColor: const Color(0xFF10B981),
              backgroundColor: Colors.white,
              chartHeight: 280,
              showGrid: true,
              showDots: true,
              showArea: true,
              valuePrefix: '₹',
              valueSuffix: '',
            ),
            const SizedBox(height: 20),

            // Two Column Layout for smaller charts
            Row(
              children: [
                // Top Products Bar Chart
                Expanded(
                  child: ReusableBarChart(
                    data: topProductsData,
                    title: 'Top Products',
                    barColor: const Color(0xFFF59E0B),
                    backgroundColor: Colors.white,
                    chartHeight: 240,
                    showGrid: true,
                    showValues: false,
                    valuePrefix: '₹',
                    valueSuffix: '',
                  ),
                ),
                const SizedBox(width: 16),

                // Customer Growth Line Chart
                Expanded(
                  child: ReusableLineChart(
                    data: customerGrowthData,
                    title: 'Customer Growth',
                    lineColor: const Color(0xFFEC4899),
                    backgroundColor: Colors.white,
                    chartHeight: 240,
                    showGrid: true,
                    showDots: true,
                    showArea: false,
                    valuePrefix: '',
                    valueSuffix: ' users',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ReusablePieChart(
                    data: categoryData,
                    title: 'Sales by Category',
                    backgroundColor: Colors.white,
                    chartHeight: 300,
                    showLegend: true,
                    showDataLabels: true,
                    valuePrefix: '₹',
                    valueSuffix: '',
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ReusableDoughnutChart(
                    data: marketShareData,
                    title: 'Market Share',
                    backgroundColor: Colors.white,
                    chartHeight: 300,
                    showLegend: true,
                    showDataLabels: true,
                    valuePrefix: '',
                    valueSuffix: '%',
                    centerText: 'Total',
                  ),
                ),
              ],
            ),
            // Empty Chart Example
            ReusableBarChart(
              data: emptyData,
              title: 'No Data Example',
              barColor: const Color(0xFF8B5CF6),
              backgroundColor: Colors.white,
              chartHeight: 200,
            ),
            const SizedBox(height: 20),

            // Stats Cards
            const Text(
              'Quick Stats',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1A1A1A),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildStatCard(
                  title: 'Total Sales',
                  value: '₹7.89L',
                  percentage: '+12.5%',
                  color: const Color(0xFF6366F1),
                  icon: Icons.trending_up,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  title: 'Revenue',
                  value: '₹9.06L',
                  percentage: '+8.2%',
                  color: const Color(0xFF10B981),
                  icon: Icons.account_balance_wallet,
                ),
                const SizedBox(width: 12),
                _buildStatCard(
                  title: 'Customers',
                  value: '2,480',
                  percentage: '+15.3%',
                  color: const Color(0xFFEC4899),
                  icon: Icons.people,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String percentage,
    required Color color,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, size: 20, color: color),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF10B981).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    percentage,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
