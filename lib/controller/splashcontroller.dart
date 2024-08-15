import 'dart:async';

import 'package:get/get.dart';
import 'package:smsseller/seller/splashscreen.dart';
// import 'package:sms/views/splashscreen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 0),
        () => Get.offAll(() => const SplashScreen()));
  }
}
