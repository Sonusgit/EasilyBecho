// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:smartbecho/utils/app_colors.dart';
// import 'package:smartbecho/views/account%20management/components/history/coustom_bottomSheet.dart';

// class PieChartWidget extends StatelessWidget {
//   final List<Map<String, dynamic>> data;

//   const PieChartWidget({super.key, required this.data});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AspectRatio(
//           aspectRatio: 1.4,
//           child: PieChart(
//             PieChartData(
//               centerSpaceRadius: 40,
//               sectionsSpace: 2,
//               sections: List.generate(
//                 data.length,
//                 (i) => PieChartSectionData(
//                   value: data[i]["value"],
//                   title: data[i]["label"],
//                   color: Colors.primaries[i % Colors.primaries.length],
//                   radius: 55,
//                   titleStyle: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 12,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//         Wrap(
//           children: List.generate(data.length, (index) {
//             return Container(
//               margin: const EdgeInsets.all(4),
//               decoration: BoxDecoration(
//                 color: Colors.grey[200],
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Container(
//                       width: 10,
//                       height: 10,
//                       decoration: BoxDecoration(
//                         shape: BoxShape.circle,
//                         color:
//                             Colors.primaries[index % Colors.primaries.length],
//                       ),
//                     ),
//                     SizedBox(width: 8),
//                     Text(data[index]["label"]),
//                     // Text("${data[index]["value"]}"),
//                   ],
//                 ),
//               ),
//             );
//           }),
//         ),
//       ],
//     );
//   }
// }

// class SimpleBarChart extends StatelessWidget {
//   final List<Map<String, dynamic>> data;
//   final String bottomTitles;
//   final Color bottomColor;

//   const SimpleBarChart({
//     super.key,
//     required this.data,
//     required this.bottomTitles,
//     required this.bottomColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         AspectRatio(
//           aspectRatio: 1.4,
//           child: BarChart(
//             BarChartData(
//               borderData: FlBorderData(show: false),
//               titlesData: FlTitlesData(
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     getTitlesWidget: (value, meta) {
//                       if (value >= 0 && value < data.length) {
//                         return Padding(
//                           padding: const EdgeInsets.only(top: 8),
//                           child: Text(
//                             data[value.toInt()]['label'],
//                             style: const TextStyle(fontSize: 12),
//                           ),
//                         );
//                       }
//                       return const Text('');
//                     },
//                   ),
//                 ),
//                 topTitles: AxisTitles(
//                   sideTitles: SideTitles(showTitles: false),
//                 ),
//               ),
//               barGroups: List.generate(
//                 data.length,
//                 (i) => BarChartGroupData(
//                   x: i,
//                   barRods: [
//                     BarChartRodData(
//                       toY: (data[i]["value"] as num).toDouble(),
//                       width: 14,
//                       color: Colors.primaries[i % Colors.primaries.length],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               decoration: BoxDecoration(color: bottomColor),
//             ),
//             SizedBox(width: 10),
//             Text(
//               bottomTitles,
//               style: TextStyle(fontSize: 12, color: bottomColor),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class MonthlyBarChart extends StatelessWidget {
//   final List<Map<String, dynamic>> apiData;
//   final String bottomTitles;
//   final Color bottomColor;
//   const MonthlyBarChart({
//     super.key,
//     required this.apiData,
//     required this.bottomTitles,
//     required this.bottomColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final List<String> months = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec",
//     ];

//     List<double> monthlyValues = List.filled(12, 0);

//     for (var item in apiData) {
//       String label = item["label"];
//       double value = item["value"].toDouble();
//       int index = months.indexWhere(
//         (m) => m.toLowerCase().startsWith(label.toLowerCase().substring(0, 3)),
//       );
//       if (index != -1) monthlyValues[index] = value;
//     }

//     return Column(
//       children: [
//         AspectRatio(
//           aspectRatio: 1.5,
//           child: BarChart(
//             BarChartData(
//               borderData: FlBorderData(show: false),
//               titlesData: FlTitlesData(
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     interval: 1,
//                     getTitlesWidget: (value, meta) {
//                       int idx = value.toInt();
//                       if (idx < 0 || idx >= 12) return const Text("");
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: Text(
//                           months[idx],
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               barGroups: List.generate(
//                 12,
//                 (i) => BarChartGroupData(
//                   x: i,
//                   barRods: [
//                     BarChartRodData(
//                       toY: monthlyValues[i],
//                       width: 14,
//                       color: Colors.primaries[i % Colors.primaries.length],
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),

//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               decoration: BoxDecoration(color: bottomColor),
//             ),
//             SizedBox(width: 10),
//             Text(bottomTitles, style: TextStyle(color: bottomColor)),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class MonthlyLineChart extends StatelessWidget {
//   final List<Map<String, dynamic>> apiData;
//   final String bottomTitles;
//   final Color bottomColor;
//   const MonthlyLineChart({
//     super.key,
//     required this.apiData,
//     required this.bottomTitles,
//     required this.bottomColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final months = [
//       "Jan",
//       "Feb",
//       "Mar",
//       "Apr",
//       "May",
//       "Jun",
//       "Jul",
//       "Aug",
//       "Sep",
//       "Oct",
//       "Nov",
//       "Dec",
//     ];

//     List<double> monthlyValues = List.filled(12, 0);

//     for (var item in apiData) {
//       String label = item["label"];
//       double value = item["value"].toDouble();
//       int index = months.indexWhere(
//         (m) => m.toLowerCase().startsWith(label.toLowerCase().substring(0, 3)),
//       );
//       if (index != -1) monthlyValues[index] = value;
//     }

//     List<FlSpot> spots = List.generate(
//       12,
//       (i) => FlSpot(i.toDouble(), monthlyValues[i]),
//     );

//     return Column(
//       children: [
//         AspectRatio(
//           aspectRatio: 1.6,
//           child: LineChart(
//             LineChartData(
//               minX: 0,
//               maxX: 11,
//               minY: 0,
//               maxY: monthlyValues.reduce((a, b) => a > b ? a : b) + 20,
//               titlesData: FlTitlesData(
//                 bottomTitles: AxisTitles(
//                   sideTitles: SideTitles(
//                     showTitles: true,
//                     interval: 1,
//                     getTitlesWidget: (value, meta) {
//                       int idx = value.toInt();
//                       if (idx < 0 || idx >= months.length)
//                         return const SizedBox();
//                       return Padding(
//                         padding: const EdgeInsets.only(top: 8),
//                         child: Text(
//                           months[idx],
//                           style: const TextStyle(fontSize: 12),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ),
//               lineBarsData: [
//                 LineChartBarData(
//                   isCurved: true,
//                   spots: spots,
//                   barWidth: 3,
//                   color: AppColors.primaryLight,
//                   dotData: FlDotData(show: true),
//                   preventCurveOverShooting: true,
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(height: 10),

//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
//               decoration: BoxDecoration(color: bottomColor),
//             ),
//             SizedBox(width: 10),
//             Text(
//               bottomTitles,
//               style: TextStyle(fontSize: 12, color: bottomColor),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// enum ChartType { monthly, trend, byCompany, filter }

// class ComboCahrtMonthlyAndTrends extends StatelessWidget {
//   final List<Map<String, dynamic>> apiData;
//   final Widget filterWidget;
//   final bool byCompany;
//   final String bottomTitles;
//   final Color bottomColor;
//   final String title;
//   final Function? onFilterChanged;
//   ComboCahrtMonthlyAndTrends({
//     super.key,
//     required this.apiData,
//     required this.filterWidget,
//     required this.byCompany,
//     required this.bottomTitles,
//     required this.bottomColor,
//     required this.title,
//     this.onFilterChanged,
//   });

//   final Rx<ChartType> selectedChart = ChartType.monthly.obs;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       return Card(
//         color: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(title, style: TextStyle(fontSize: 18)),
//               const SizedBox(height: 10),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   // SizedBox(width: 10),
//                   Row(
//                     children: [
//                       _buildSingleButton(
//                         label: "Monthly",
//                         type: ChartType.monthly,
//                       ),
//                       SizedBox(width: 10),
//                       if (byCompany) ...[
//                         _buildSingleButton(
//                           label: "By Company",
//                           type: ChartType.byCompany,
//                         ),
//                       ] else ...[
//                         _buildSingleButton(
//                           label: "Trend",
//                           type: ChartType.trend,
//                         ),
//                       ],

//                       SizedBox(width: 10),
//                       _buildSingleButton(
//                         label: "filter",
//                         type: ChartType.filter,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
//               _buildChart(),
//             ],
//           ),
//         ),
//       );
//     });
//   }

//   Widget _buildSingleButton({required String label, ChartType? type}) {
//     final isActive = selectedChart.value == type;
//     final notHaveType = type != null;

//     return SizedBox(
//       height: 30,
//       child: ElevatedButton(
//         style: ElevatedButton.styleFrom(
//           backgroundColor:
//               isActive && notHaveType ? AppColors.primaryLight : Colors.white,
//           foregroundColor: isActive ? Colors.white : Colors.black,
//           elevation: 0,
//           padding: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//             side: BorderSide(color: AppColors.primaryLight, width: 1),
//           ),
//         ),
//         onPressed: () {
//           if (type == ChartType.filter) {
//             onFilterChanged;
//             showCustomBottomSheet(child: filterWidget);
//           } else {
//             selectedChart.value = type!;
//           }
//         },

//         child: Text(label),
//       ),
//     );
//   }

//   Widget _buildChart() {
//     final convertedData = convertData(apiData); // <- Always convert here

//     if (selectedChart.value == ChartType.monthly) {
//       return Column(
//         children: [
//           if (!byCompany)
//             MonthlyBarChart(
//               apiData: convertedData, // <-- Fix
//               bottomColor: bottomColor,
//               bottomTitles: bottomTitles,
//             ),

//           if (byCompany)
//             SimpleBarChart(
//               data: convertedData, // <-- Fix
//               // data: [
//               //   {"label": "FILPCART", "value": 100.00},
//               //   {"label": "AMAZON", "value": 200.00},
//               // ],
//               bottomColor: bottomColor,
//               bottomTitles: bottomTitles,
//             ),
//         ],
//       );
//     } else if (selectedChart.value == ChartType.trend) {
//       return MonthlyLineChart(
//         apiData: convertedData, // <-- Fix
//         bottomColor: bottomColor,
//         bottomTitles: bottomTitles,
//       );
//     } else if (selectedChart.value == ChartType.byCompany) {
//       return PieChartWidget(data: apiData); // Pie chart will use original data
//     } else {
//       return Text('No chart available.');
//     }
//   }
// }

// final monthNames = {
//   1: "January",
//   2: "February",
//   3: "March",
//   4: "April",
//   5: "May",
//   6: "June",
//   7: "July",
//   8: "August",
//   9: "September",
//   10: "October",
//   11: "November",
//   12: "December",
// };

// /// Convert API data to standardized format for charts
// List<Map<String, dynamic>> convertData(List<dynamic> apiList) {
//   return apiList.map((item) {
//     String label = item["label"] ?? "";
//     double amount = (item["totalAmount"] ?? item["value"] ?? 0).toDouble();

//     // Case 1: "Month 11" type format
//     if (label.toLowerCase().startsWith("month")) {
//       int monthNumber = int.tryParse(label.split(" ").last) ?? 0;
//       return {"label": monthNames[monthNumber] ?? label, "value": amount};
//     }

//     // Case 2: "November" - Already month name format
//     if (monthNames.containsValue(label)) {
//       return {"label": label, "value": amount};
//     }

//     // Case 3: Abbreviated month (Nov, Oct, etc)
//     final abbrevMonths = {
//       "jan": "January",
//       "feb": "February",
//       "mar": "March",
//       "apr": "April",
//       "may": "May",
//       "jun": "June",
//       "jul": "July",
//       "aug": "August",
//       "sep": "September",
//       "oct": "October",
//       "nov": "November",
//       "dec": "December",
//     };

//     final fullName = abbrevMonths[label.toLowerCase()];
//     if (fullName != null) {
//       return {"label": fullName, "value": amount};
//     }

//     // Case 4: Company names or other labels (keep as is)
//     return {"label": label, "value": amount};
//   }).toList();
// }
