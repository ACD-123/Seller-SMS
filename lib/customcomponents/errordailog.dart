import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/custom_popup_dialogwhite.dart';

typedef ButtonPressed = VoidCallback;

showErrrorSnackbar({required String message}) {
  return Get.snackbar("Error", message,
      backgroundColor: Color(0xff2E3192), colorText: Colors.white);
}

showSuccessSnackbar({required String message}) {
  return Get.snackbar("Success", message,
      backgroundColor: Color(0xff2E3192), colorText: Colors.white);
}

void showSuccessDialogAndNavigateToLogin(context) {
  Get.dialog(
    WhiteCustomPopupDialog(
      message: 'Verification Done',
      image: 'assets/images/sms 5.png',
    ),
  );
  Future.delayed(Duration(seconds: 2), () {
    Get.offAllNamed(RouteConstants.loginscreen);
  });
}
