import 'package:easilybecho/routes/app_routes.dart';
import 'package:easilybecho/services/api_service.dart';
import 'package:easilybecho/utility/components/components.dart';
import 'package:easilybecho/utility/const/app_colors.dart';
import 'package:easilybecho/utility/urls/urls.dart';
import 'package:easilybecho/views/auth/login_screen.dart';
import 'package:easilybecho/views/bill/components/bills_last_month_data_caeds.dart';
import 'package:easilybecho/views/bill/components/bills_last_month_data_screen.dart';
import 'package:easilybecho/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future<void> localApi() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000'));
    if (response.statusCode == 200) {
      print('Response data: ${response.body}');
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///oververview cards [Total Sales,Available Stocks,Phone Sold,EMI Dues]
                oververview(),
                dashBoardcontect(),
                SizedBox(height: 10.h),
                stockoverview(),
                ElevatedButton(
                  onPressed: () {
                    localApi();
                  },
                  child: Text('api'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget stockOverview() => Components.buildCard(
    width: double.infinity,
    height: 400,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.boxOpen),
            Text(' Stock Overview', style: TextStyle(fontSize: 20)),
          ],
        ),
        Text('Total Stock: ${4585} Units', style: TextStyle(fontSize: 20)),
        Text('Company-Wise Stock Summary', style: TextStyle(fontSize: 20)),

        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 100,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 84, 122, 60),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  trailing: Text('${45} Units', style: TextStyle(fontSize: 20)),
                  leading: Text('Company', style: TextStyle(fontSize: 20)),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  Widget paymentOverview() => Components.buildCard(
    width: double.infinity,
    height: 400,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            FaIcon(FontAwesomeIcons.boxOpen),
            Text(' Stock Overview', style: TextStyle(fontSize: 20)),
          ],
        ),
        Text('Total Stock: ${4585} Units', style: TextStyle(fontSize: 20)),
        Text('Company-Wise Stock Summary', style: TextStyle(fontSize: 20)),

        Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 100,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 84, 122, 60),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  trailing: Text('${45} Units', style: TextStyle(fontSize: 20)),
                  leading: Text('Company', style: TextStyle(fontSize: 20)),
                ),
              );
            },
          ),
        ),
      ],
    ),
  );

  Widget oververview() {
    return SizedBox(
      height: 120,
      child: Row(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              // physics: NeverScrollableScrollPhysics(),
              children: [
                Components.buildOverviewCards(
                  onTap: () => Get.toNamed(AppRoutes.login),
                  icon: FontAwesomeIcons.arrowTrendUp,
                  color: AppColors.overviewCardsPurpleAccent,
                  title: 'Total Sales',
                  value: '₹ ${1220}',
                ),
                Components.buildOverviewCards(
                  onTap: () => Get.toNamed(AppRoutes.login),
                  icon: FontAwesomeIcons.boxOpen,
                  color: AppColors.overviewCardsGreen,
                  title: 'Available Stocks',
                  value: '${1120}',
                ),
                Components.buildOverviewCards(
                  onTap: () => Get.toNamed(AppRoutes.login),
                  icon: FontAwesomeIcons.mobileScreenButton,
                  color: AppColors.overviewCardsOrange,
                  title: 'Phone Sold',
                  value: '${12}',
                ),
                Components.buildOverviewCards(
                  onTap: () => Get.toNamed(AppRoutes.login),
                  icon: FontAwesomeIcons.creditCard,
                  color: AppColors.overviewCardsCyanAccent,
                  title: 'EMI Dues',
                  value: '₹ ${4500}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class stockoverview extends StatelessWidget {
  const stockoverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ' Stock Overview / Payment Breakdown',
            style: TextStyle(fontSize: 20),
          ),

          SizedBox(
            height: 100.h,
            child: Row(
              children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,

                    // itemCount: 2,
                    children: [
                      Components.buildCard(
                        // width: 500.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Stock',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            Row(
                              children: [
                                Text(
                                  '4585',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue,
                                    fontSize: 30.sp,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  'Units',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,

                                    // fontSize: 30.sp,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Components.buildCard(
                        // width: 500.w,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Amount:',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            Text(
                              ' ₹1,108,805.46',
                              style: TextStyle(
                                fontSize: 30.sp,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget dashBoardcontect() {
  return Wrap(
    spacing: 2,

    // clipBehavior: Clip.antiAlias,
    children: [
      Components.buildElevatedButton(
        icon: FontAwesomeIcons.mobileScreenButton,
        // color: AppColors.overviewCardsGreen,

        // width: 200,
        label: 'Sell mobiles',
        onPressed: () => (),
      ),
      Components.buildElevatedButton(
        icon: FontAwesomeIcons.plus,
        // color: AppColors.overviewCardsCyanAccent,
        // width: 200,
        label: 'Add Stock',
        onPressed: () => (),
      ),

      Components.buildElevatedButton(
        icon: FontAwesomeIcons.clipboard,
        // color: AppColors.overviewCardsPurpleAccent,

        // width: 200,
        label: 'Reports',
        onPressed: () => (),
      ),
      Components.buildElevatedButton(
        icon: FontAwesomeIcons.fileCircleCheck,
        // width: 200,
        label: 'Emi Records',

        // color: AppColors.overviewCardsOrange,
        onPressed: () => (),
      ),
      Components.buildElevatedButton(
        icon: FontAwesomeIcons.fileCircleCheck,
        // width: 200,
        label: 'Emi Records',

        // color: AppColors.overviewCardsOrange,
        onPressed: () => (),
      ),
    ],
  );
}
