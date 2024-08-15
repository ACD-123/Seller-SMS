import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

AppBar customappbar({required String title}) {
  return AppBar(
    elevation: 0.0,
    leading: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18.sp,
        )),
    centerTitle: true,
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
    ),
  );
}
