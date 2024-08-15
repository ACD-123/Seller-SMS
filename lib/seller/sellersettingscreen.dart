import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/customcomponents/customappbar.dart';

import '../customcomponents/customappbar.dart';

class SellerSettingScreen extends StatelessWidget {
  const SellerSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Setting"),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            CircleAvatar(
              radius: 32.sp,
              backgroundImage:
                  AssetImage("assets/images/sellerprofileimage.png"),
            ),
            Text(
              "Mathew Wade",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Color(0XFF2E3192),
              ),
            ),
            Text(
              "Joined since : 2022",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Color(0XFF757474),
                height: 0.9,
              ),
            ),
            SizedBox(
              height: 4.h,
            ),
            customsettingcontainer(
                title: "Change Password",
                ontap: () {
                  Get.toNamed(RouteConstants.sellersetuppassword);
                }),
            customsettingcontainer(
              title: "FAQs",
              ontap: () {
                Get.toNamed(RouteConstants.faq);
              },
            ),
            customsettingcontainer(
                title: "Private Policy",
                ontap: () {
                  Get.toNamed(RouteConstants.privacypolicy);
                }),
            customsettingcontainer(
                title: "Chats",
                ontap: () {
                  Get.toNamed(RouteConstants.sellerchatlistscreen);
                })
          ],
        ),
      ),
    );
  }
}

///////////custom setting container
Padding customsettingcontainer(
    {required String title, required VoidCallback ontap}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: GestureDetector(
      onTap: ontap,
      child: Container(
          width: Get.width,
          height: 6.h,
          decoration: BoxDecoration(
              color: Color(0xffFFFFFF),
              boxShadow: [
                BoxShadow(
                  color: Color(0xff000000).withOpacity(0.06),
                  blurRadius: 10,
                  offset: const Offset(0, 9),
                )
              ],
              border: Border.all(color: const Color(0xffDBDBDB)),
              borderRadius: BorderRadius.circular(20)),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Color(0xff474747), fontSize: 15.sp),
                  ),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    size: 17.sp,
                    color: const Color(0xff2E3192),
                  )
                ],
              ))),
    ),
  );
}
