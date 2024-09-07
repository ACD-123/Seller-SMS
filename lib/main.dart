import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/constants/routemanagment.dart';
import 'package:smsseller/controller/splashcontroller.dart';
import 'package:smsseller/services/local_storage.dart';
import 'services/dependencies.dart' as dep;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print('Firebase is successfully connected.');
  } catch (error) {
    print('Failed to connect to Firebase: $error');
  }
  await dep.init();
  await LocalStorage().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (buildContext, orientation, screenType) {
        return GetBuilder(
            init: SplashController(),
            builder: (controller) {
              return GetMaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'SMS Seller',
                  defaultTransition: Transition.cupertino,
                  getPages: RouteGenerator.getPages(),
                  initialRoute: RouteConstants.splashscreen);
            });
      },
    );
  }
}
