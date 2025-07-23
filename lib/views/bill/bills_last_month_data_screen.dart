import 'package:easilybecho/controllers/bill_controller.dart';
import 'package:easilybecho/utility/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart';

class BillsLastMonthDataScreen extends StatefulWidget {
  const BillsLastMonthDataScreen({super.key});

  @override
  State<BillsLastMonthDataScreen> createState() =>
      _BillsLastMonthDataScreenState();
}

class _BillsLastMonthDataScreenState extends State<BillsLastMonthDataScreen> {
  final billController = Get.find<BillController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
            if (billController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  final billsData = billController.bilsMonthData.value;

              return GridView.builder(
                itemCount: billsData!.payload.thisMonthItems.length,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  childAspectRatio: 0.8,
                  maxCrossAxisExtent: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Components.buildCard();
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
