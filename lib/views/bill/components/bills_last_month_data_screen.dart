// ✅ Accept a single bill item instead of the full data
import 'package:easilybecho/utility/utility_helper/date_formatter_helper.dart';
import 'package:flutter/material.dart';

class BillsLastMonthDataScreen extends StatelessWidget {
  final dynamic itemData; // <-- Use a better model type if available

  BillsLastMonthDataScreen({super.key, required this.itemData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Last Month Bill")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Bill Data:", style: TextStyle(fontSize: 20)),
             
DateFormatterHelper.dateFormatter(dateList: itemData.createdDate),
 Text("Company: ${itemData.company}"),
              Text("Model: ${itemData.model}"),
              Text("Category: ${itemData.itemCategory}"),
              Text("Quantity: ${itemData.qty}"),
              Text("billMobileItem: ${itemData.billMobileItem}"),
              Text("color: ${itemData.color}"),
              Text("logo: ${itemData.logo}"),
              Text("rom: ${itemData.rom}"),
            ],
          ),
        ),
      ),
    );
  }
}
