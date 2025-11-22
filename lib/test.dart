import 'package:easilybecho/core/utility/components/components.dart';
import 'package:easilybecho/core/utility/const/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

 
  @override
  Widget build(BuildContext context) {

  
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              'StrutStyle? strutStyle, TextAlign? textAlign, TextDirection? textDirection, Locale? locale, bool? softWrap, TextOverflow? overflow, double? textScaleFactor, TextScaler? textScaler, int? maxLines, String? semanticsLabel, String? semanticsIdentifier, TextWidthBasis? textWidthBasis, TextHeightBehavior? textHeightBehavior, Color? selectionColor})',
              style: TextStyle(fontSize: 20.h),
            ),
            SizedBox(
              height: 150.h,
              child: Row(
                children: [
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      // physics: NeverScrollableScrollPhysics(),
                      children: [
                        Components.buildOverviewCards(
                          icon: FontAwesomeIcons.arrowTrendUp,
                          color: AppColors.overviewCardsPurpleAccent,
                          title: 'Total Sales',
                          value: '₹ ${1220}',
                        ),
                        Components.buildOverviewCards(
                          icon: FontAwesomeIcons.boxOpen,
                          color: AppColors.overviewCardsGreen,
                          title: 'Available Stocks',
                          value: '${1120}',
                        ),
                        Components.buildOverviewCards(
                          icon: FontAwesomeIcons.mobileScreenButton,
                          color: AppColors.overviewCardsOrange,
                          title: 'Phone Sold',
                          value: '${12}',
                        ),
                        Components.buildOverviewCards(
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
            ),
            Row(
              children: [
                Components.buildElevatedButton(
                  color: AppColors.overviewCardsCyanAccent,
                  icon: FontAwesomeIcons.creditCard,
                  label: 'testind',
                  onPressed: () => (),
                ),
                Components.buildElevatedButton(
                  icon: FontAwesomeIcons.creditCard,
                  color: AppColors.overviewCardsOrange,
                  label: 'testind',
                  onPressed: () => (),
                ),
              ],
            ),
            Row(
              children: [
                Components.buildTextformField(
                  label: 'login',
                  controller: TextEditingController(),
                ),
              ],
            ),
            Container(
              width: 250.w, // Responsive width
              height: 50.h, // Responsive height
              margin: EdgeInsets.all(10.w),
              child: ElevatedButton(
                onPressed: () {
                  print("Button clicked!");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      12.r,
                    ), // Responsive radius
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.touch_app, size: 22.sp, color: Colors.white),
                    SizedBox(width: 10.w),
                    Text(
                      'Responsive Button',
                      style: TextStyle(
                        fontSize: 18.sp, // Responsive text size
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            
          ],
        ),
      ),
    );
  }
}
