import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/capitalword.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/services/local_storage.dart';

class SellerWelcomeScreen extends StatefulWidget {
  const SellerWelcomeScreen({super.key});

  @override
  State<SellerWelcomeScreen> createState() => _SellerWelcomeScreenState();
}

class _SellerWelcomeScreenState extends State<SellerWelcomeScreen> {
  final authcontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storecontroller.getSellerProfileData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 3.h,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Obx(
                    () => GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteConstants.sellerprofilescreen);
                      },
                      child: SizedBox(
                        child: Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 25.sp,
                                  backgroundColor: Colors.white,
                                  backgroundImage: NetworkImage(storecontroller
                                                  .getsellerprofiledata.value ==
                                              null ||
                                          storecontroller.getsellerprofiledata
                                              .value!.data!.media!.isEmpty
                                      ? AppConstants.noimage
                                      : storecontroller
                                              .getsellerprofiledata
                                              .value
                                              ?.data
                                              ?.media
                                              ?.first
                                              .originalUrl ??
                                          AppConstants.noimage),
                                ),
                                Positioned(
                                  right: 0,
                                  top: 48,
                                  child: Container(
                                    width: 5.w,
                                    height: 3.h,
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            blurRadius: 2.07,
                                            offset: Offset(0, 2.07),
                                            color: Color(0xff000000)
                                                .withOpacity(0.25))
                                      ],
                                      color: Color(0xffFFFFFF),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt_outlined,
                                      size: 13.sp,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8, left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 48.w,
                                    child: Text(
                                      'Hello ${toCamelCase(storecontroller.getsellerprofiledata.value?.data?.name ?? "")}',
                                      style: TextStyle(
                                          color: const Color(0xff2E3192),
                                          fontWeight: FontWeight.w400,
                                          fontSize: 17.sp),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                height: 1.h,
              ),
              Center(
                  child: Image.asset(
                "assets/images/sellersplashimage.png",
                height: 40.h,
                width: 80.w,
              )),
              Text(
                "Welcome",
                style: TextStyle(
                    color: const Color(0xff1375EA),
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "To SMS Selling Hub",
                style: TextStyle(
                    color: const Color(0xff1375EA),
                    fontSize: 21.sp,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff8A8484),
                    fontSize: 14.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              custombutton(
                  hinttext: "Let’s Get Started",
                  ontap: () {
                    final int issubscribe =
                        LocalStorage().getInt("isSubscription");

                    // Get.toNamed(RouteConstants.subscriptionpayment);
                    issubscribe == 0
                        ? Get.toNamed(RouteConstants.subscriptionpayment)
                        : Get.toNamed(RouteConstants.sellercreateshopscreen);
                  }),
              SizedBox(
                height: 1.h,
              ),
              GestureDetector(
                onTap: () {
                  authcontroller.signout();
                },
                child: Container(
                  height: 5.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff2E3192)),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                      child: Text("Sign Out",
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: const Color(0xff757474),
                          ))),
                ),
              ),
              // custombutton(
              //     hinttext: "Sign Out",
              //     ontap: () {
              //       authcontroller.signout();
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
