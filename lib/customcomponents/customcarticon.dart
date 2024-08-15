import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sms/constants/route_constants.dart';
import 'package:smsseller/constants/route_constants.dart';

GestureDetector customcarticon({required String quantity}) {
  return GestureDetector(
    onTap: () {
      Get.toNamed(RouteConstants.addtocart);
    },
    child: Stack(
      clipBehavior: Clip.none,
      children: [
        Image.asset(
          "assets/images/carticon.png",
          height: 3.h,
        ),
        Positioned(
          top: -10.sp,
          right: -10.sp,
          child: CircleAvatar(
            radius: 12.sp,
            backgroundColor: Color(0xff1375EA),
            child: Center(
              child: Text(
                quantity,
                style: TextStyle(
                  color: const Color(0XFFFAFAFA),
                  fontSize: 12.sp,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
