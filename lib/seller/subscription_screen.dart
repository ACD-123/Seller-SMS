import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionPaymentScreen extends StatefulWidget {
  const SubscriptionPaymentScreen({super.key});

  @override
  State<SubscriptionPaymentScreen> createState() =>
      _SubscriptionPaymentScreenState();
}

class _SubscriptionPaymentScreenState extends State<SubscriptionPaymentScreen> {
  final authcontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Welcome to Seller hub"),
      body: Padding(
        padding: EdgeInsets.all(18.sp),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Subscription",
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff000000)),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "You need to buy Package before become a seller.",
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xff848484)),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                "\$5.00",
                style: TextStyle(
                    fontSize: 31.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xff2E3192)),
              ),
              Image.asset(
                "assets/images/subscriptionicon.png",
                height: 40.h,
                width: 85.w,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 12.h,
              ),
              Obx(
                () => authcontroller.getsubscriptionpaymenturlloading.value
                    ? Center(
                        child: customcircularprogress(),
                      )
                    : custombutton(
                        ontap: () async {
                          await authcontroller.getSubscriptionPayment();
                          print(authcontroller.getsubscriptionpaymenturl.value
                                  ?.data?.paymentUrl ??
                              "");
                          // try {
                          //   final Uri url = Uri.parse(authcontroller
                          //           .getsubscriptionpaymenturl
                          //           .value
                          //           ?.data
                          //           ?.paymentUrl ??
                          //       "");
                          //   if (!await launchUrl(url)) {
                          //     throw Exception('Could not launch URL');
                          //   }
                          //   Get.toNamed(RouteConstants.sellercreateshopscreen);
                          // } catch (e) {
                          //   showErrrorSnackbar(
                          //       message: "Failed to fetch payment URL.");
                          // }
                        },
                        hinttext: "Buy Now"),
              ),
              SizedBox(
                height: 1.h,
              ),
              custombutton(
                  hinttext: "Testing Create Shop",
                  ontap: () {
                    Get.toNamed(RouteConstants.sellercreateshopscreen);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
