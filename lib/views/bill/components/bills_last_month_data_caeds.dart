import 'package:easilybecho/controllers/bill_controller.dart';
import 'package:easilybecho/utility/components/components.dart';
import 'package:easilybecho/utility/const/app_colors.dart';
import 'package:easilybecho/utility/utility_helper/date_formatter_helper.dart';
import 'package:easilybecho/views/bill/components/bills_last_month_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';

class BillsLastMonthDataCaeds extends StatefulWidget {
  const BillsLastMonthDataCaeds({super.key});

  @override
  State<BillsLastMonthDataCaeds> createState() =>
      _BillsLastMonthDataCaedsState();
}

class _BillsLastMonthDataCaedsState extends State<BillsLastMonthDataCaeds> {
  final billController = Get.find<BillController>();
  // String formattedDate = DateFormat('dd/MM/yyyy').format(date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Aapka koi heading ya content ho to
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "This Month's Bills",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              Obx(() {
                if (billController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final billsData = billController.bilsMonthData.value;
                if (billsData == null) {
                  return const Center(child: Text("No data available"));
                }

                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: billsData.payload.thisMonthItems.length,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200, // ✅ max width per item/card
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio:
                        0.8, // ✅ width / height ratio (adjust as needed)
                  ),
                  itemBuilder: (context, index) {
                    final item = billsData.payload.thisMonthItems[index];
                    return Components.buildCard(
                      onTap: () => Get.to(
                        () => BillsLastMonthDataScreen(itemData: item),
                      ),
                      child: Column(
                        children: [
                          DateFormatterHelper.dateFormatter(
                            dateList: item.createdDate,
                            textStyle: TextStyle(
                              fontSize: 20,
                              color: AppColors.appBarColor,
                            ),
                          ),
                          Text('Company:${item.company}'),
                          Text('Model: ${item.model}'),
                          Text('Category: ${item.itemCategory}'),
                          Text('Quantity: ${item.qty}'),
                          Text('billMobileItem: ${item.billMobileItem}'),
                          Text('color: ${item.color}'),
                          Text('sellingPrice: ${item.sellingPrice}'),
                          Row(
                            children: [
                              Components.buildElevatedButton(
                                label: 'viwe more',
                                // textStyle: TextStyle(fontSize: 20),

                                onPressed: () => Get.to(() => BillsLastMonthDataScreen(itemData: item),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ); // 🔁 Card show karo yahan
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
