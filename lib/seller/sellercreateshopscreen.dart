import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/custom_textformfield.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/controller/storecontroller.dart';
// import 'package:sms/customcomponents/custom_textformfield.dart';
// import 'package:sms/customcomponents/custombutton.dart';

class SellerCreateShopScreen extends StatefulWidget {
  const SellerCreateShopScreen({super.key});

  @override
  State<SellerCreateShopScreen> createState() => _SellerCreateShopScreenState();
}

class _SellerCreateShopScreenState extends State<SellerCreateShopScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 21.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "assets/images/myprofilebackgroundimage.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(50)),
                  ),
                ),
                Positioned(
                  top: 10.h,
                  left: 35.w,
                  right: 35.w,
                  child: GestureDetector(
                    onTap: () {
                      storecontroller
                          .uploadsellercreateshopprofileimage(context);
                    },
                    child: Center(
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Obx(
                            () => Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: Color(0xffFFFFFF), width: 5),
                              ),
                              child: CircleAvatar(
                                radius: 32.sp,
                                backgroundImage: storecontroller
                                            .sellercreateshopuploadedprofileImage
                                            .value !=
                                        null
                                    ? FileImage(storecontroller
                                        .sellercreateshopuploadedprofileImage
                                        .value!)
                                    : const AssetImage(
                                            "assets/images/placeholderprofileimage.png")
                                        as ImageProvider,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 5,
                            bottom: 3,
                            child: Container(
                              width: 8.w,
                              height: 6.h,
                              decoration: BoxDecoration(
                                color: Color(0xff2E3192),
                                shape: BoxShape.circle,
                              ),
                              child: Image.asset(
                                  'assets/images/myprofilecamera.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  customtextformfield(hinttext: "Business Name"),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(
                      hinttext: "Phone Number",
                      keyboardType: TextInputType.number),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(hinttext: "What you Sell"),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(hinttext: "Commercial Registration ID"),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(hinttext: "Email"),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(hinttext: "Street Address"),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(hinttext: "Country"),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 45.w,
                        child: customtextformfield(hinttext: "City"),
                      ),
                      Container(
                        width: 45.w,
                        child: customtextformfield(hinttext: "Zip Code"),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  custombutton(
                      hinttext: "Next",
                      ontap: () {
                        Get.toNamed(RouteConstants.sellersetupshop);
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
