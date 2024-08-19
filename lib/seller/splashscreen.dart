import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/services/local_storage.dart';
// import 'package:sms/views/onboarding/welcome_screen1.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final authcontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));

  @override
  void initState() {
    super.initState();
    
    final token = LocalStorage().getString("token");
    final istrustedseller = LocalStorage().getBool("istrustedseller");
    Future.delayed(
        const Duration(seconds: 2),
        () => token.isEmpty
            ? Get.offNamed(RouteConstants.welcome1)
            : istrustedseller == false
                ? Get.offNamed(RouteConstants.selerwelcome)
                : Get.offNamed(RouteConstants.sellerdashboard));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage('assets/images/splashbackgroundimage.png'),
          fit: BoxFit.cover,
        )),
        child: Center(child: Image.asset('assets/images/splashlogo.png')),
      ),
    );
  }
}
