import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/customcomponents/custom_popup_dialogwhite.dart';

typedef ButtonPressed = VoidCallback;

showErrrorSnackbar({required String message}) {
  return Get.snackbar("Error", message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xff2E3192),
      colorText: Colors.white);
}

showSuccessSnackbar({required String message}) {
  return Get.snackbar("Success", message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Color(0xff2E3192),
      colorText: Colors.white);
}

void showSuccessDialogAndNavigateToLogin(context, String message,String routename) {
  Get.dialog(
    WhiteCustomPopupDialog(
      message: message,
      image: 'assets/images/sms 5.png',
    ),
  );
  Future.delayed(Duration(seconds: 2), () {
    Get.offAllNamed(routename);
  });
}

customcircularprogress() {
  return const CircularProgressIndicator(
    color: Color(0xff2E3192),
  );
}



nodatatext(String message){
  return  Text(message,
                              style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold));
}



