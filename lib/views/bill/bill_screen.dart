import 'package:easilybecho/controllers/bill_controller.dart';
import 'package:easilybecho/routes/app_routes.dart';
import 'package:easilybecho/utility/components/components.dart';
import 'package:easilybecho/utility/const/app_colors.dart';
import 'package:easilybecho/views/bill/bills_last_month_data_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  final billController = Get.find<BillController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      billslastmonthadd(),
                      Components.buildCard(
                        child: Text('data'),
                        onTap: () {
                          billController.fetchBillsLastmonth();
                        },
                      ),
                      Components.buildCard(),
                      Components.buildCard(),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Components.buildElevatedButton(
                      label: 'go to lastmosth ',
                      onPressed: () => Get.toNamed(AppRoutes.billsLastMonth),
                    ),
                  ],
                ),
                // Components()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget billslastmonthadd() {
    return Components.buildCard(
      width: 200,

      onTap: () => Get.bottomSheet(
        Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Components.buildCard(
            width: double.infinity,
            height: double.infinity,
            // onTap: () => Get.back(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(child: Text("This Month's Added Stock")),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.close_rounded),
                    ),
                  ],
                ),
                Obx(() {
                  if (billController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final billsData = billController.bilsMonthData.value;

                  return Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            200, // ✅ Set max width per grid item
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.8, // width : height
                      ),
                      itemCount: billsData!.payload.thisMonthItems.length,

                      itemBuilder: (context, index) {
                        return Components.buildCard(
                          color: AppColors.backgroundColor,
                          child: Column(
                            children: [
                              Text(
                                billsData!
                                    .payload
                                    .thisMonthItems[index]
                                    .company,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }),
              ],
            ),
          ),
        ),

        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
      ),
    );
  }
}
