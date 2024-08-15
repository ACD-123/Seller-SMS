import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sms/controller/homeguestcontroller.dart';
import 'package:smsseller/controller/homeguestcontroller.dart';

Padding customrowpaymentmethods({
  required String image,
  required int index,
}) {
  final homeguestcontroller =
      Get.put(HomeGuestController(authRepo: Get.find()));
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Obx(
      () => GestureDetector(
        onTap: () {
          homeguestcontroller.updateaddnewcardpaymentmethod(index);
        },
        child: Container(
          height: 5.5.h,
          width: 25.w,
          decoration: BoxDecoration(
              border: Border.all(
                  width: 2,
                  color:
                      homeguestcontroller.addnewcardpaymentmethod.value == index
                          ? const Color(0xff2E3192)
                          : const Color(0xffDDDDDD)),
              image: DecorationImage(image: AssetImage(image)),
              color: const Color(0xffFFFFFF),
              borderRadius: BorderRadius.circular(9.86)),
        ),
      ),
    ),
  );
}
