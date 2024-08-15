import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/customcomponents/custombutton.dart';

class SellerWelcomeScreen extends StatelessWidget {
  const SellerWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.h,
            ),
            Center(
                child: Image.asset(
              "assets/images/sellersplashimage.png",
              height: 40.h,
              width: 80.w,
            )),
            Text(
              "Welcome",
              style: TextStyle(
                  color: const Color(0xff1375EA),
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              "To SMS Selling Hub",
              style: TextStyle(
                  color: const Color(0xff1375EA),
                  fontSize: 21.sp,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 2.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xff8A8484),
                  fontSize: 14.sp,
                ),
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            custombutton(
                hinttext: "Let’s Get Started",
                ontap: () {
                  Get.toNamed(RouteConstants.sellercreateshopscreen);
                })
          ],
        ),
      ),
    );
  }
}
