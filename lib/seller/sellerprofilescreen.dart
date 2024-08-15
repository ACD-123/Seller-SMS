import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/custom_textformfield.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
// import 'package:sms/controller/storecontroller.dart';
// import 'package:sms/customcomponents/custom_textformfield.dart';
// import 'package:sms/customcomponents/customappbar.dart';
// import 'package:sms/customcomponents/custombutton.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: 'Profile'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 17.h,
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
                  top: 6.h,
                  left: 35.w,
                  right: 35.w,
                  child: GestureDetector(
                    onTap: () {
                      storecontroller.uploadsellershopprofileImage(context);
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
                                            .sellershopuploadedprofileImage
                                            .value !=
                                        null
                                    ? FileImage(storecontroller
                                        .sellershopuploadedprofileImage.value!)
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
              height: 5.h,
            ),
            Text(
              "Mathew Wade",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Color(0XFF2E3192),
              ),
            ),
            Text(
              "Joined since : 2022",
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: Color(0XFF757474),
                height: 0.9,
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  customtextformfield(
                      hinttext: "Name",
                      suffixicon: Image.asset(
                          'assets/images/profilesettingediticon.png')),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(
                      hinttext: "Phone",
                      keyboardType: TextInputType.number,
                      suffixicon: Image.asset(
                          'assets/images/profilesettingediticon.png')),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(
                      hinttext: "Business Name",
                      suffixicon: Image.asset(
                          'assets/images/profilesettingediticon.png')),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(
                      hinttext: "What you Sell",
                      suffixicon: Image.asset(
                          'assets/images/profilesettingediticon.png')),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(
                      hinttext: "Email",
                      suffixicon: Image.asset(
                          'assets/images/profilesettingediticon.png')),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(
                      hinttext: "Commercial Registration ID",
                      suffixicon: Image.asset(
                          'assets/images/profilesettingediticon.png')),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(
                      hinttext: "Street Address",
                      suffixicon: Image.asset(
                          'assets/images/profilesettingediticon.png')),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  customtextformfield(
                      hinttext: "Country",
                      suffixicon: Image.asset(
                          'assets/images/profilesettingediticon.png')),
                  SizedBox(
                    height: 1.5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 45.w,
                        child: customtextformfield(
                            hinttext: "City",
                            suffixicon: Image.asset(
                                'assets/images/profilesettingediticon.png')),
                      ),
                      Container(
                        width: 45.w,
                        child: customtextformfield(
                            hinttext: "Zip Code",
                            suffixicon: Image.asset(
                                'assets/images/profilesettingediticon.png')),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  custombutton(hinttext: "Save", ontap: () {})
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
