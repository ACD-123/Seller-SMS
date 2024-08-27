import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/custom_textformfield.dart';
import 'package:smsseller/customcomponents/custombutton.dart';

class SellerUpdateShopScreen extends StatefulWidget {
  const SellerUpdateShopScreen({super.key});

  @override
  State<SellerUpdateShopScreen> createState() => _SellerUpdateShopScreenState();
}

class _SellerUpdateShopScreenState extends State<SellerUpdateShopScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  final authcontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void getapidata() async {
    storecontroller.updateshopselectedCategories.clear();
    storecontroller.updateshopselectedCategoriesIds.clear();
    storecontroller.updateshopremovedbannersimage.clear();
    await storecontroller.getSellerShopProfileData();
    storecontroller.getsellershopcategoriesandstore();
  }

  @override
  void initState() {
    super.initState();
    getapidata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
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
                    top: 5.h,
                    left: 2.w,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: SizedBox(
                        width: 8.w,
                        height: 4.h,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            backgroundColor: const Color(0xffEEEAEA),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(9.79),
                            ),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new_sharp,
                            size: 17.sp,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    left: 35.w,
                    right: 35.w,
                    child: GestureDetector(
                      onTap: () {
                        storecontroller.updateSellershopmainimage(context);
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
                                              .updatesellershopmainimage
                                              .value !=
                                          null
                                      ? FileImage(storecontroller
                                          .updatesellershopmainimage.value!)
                                      : NetworkImage(storecontroller
                                                  .getsellershopprofiledata
                                                  .value
                                                  ?.data
                                                  ?.sellerData
                                                  ?.mainImage ??
                                              AppConstants.noimage)
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
                    customtextformfield(
                        controller:
                            storecontroller.updateshopnamecontroller.value,
                        hinttext: storecontroller.getsellershopprofiledata.value
                                ?.data?.sellerData?.shopName ??
                            "Business Name",
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Please Enter Business Name";
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    IntlPhoneField(
                      validator: (v) {
                        if (storecontroller.updateshopphonenumbercontroller
                            .value.text.isEmpty) {
                          return 'Please Enter Phone Number';
                        }
                        return null;
                      },
                      controller:
                          storecontroller.updateshopphonenumbercontroller.value,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFDBDBDB), width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xFFDBDBDB), width: 1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        contentPadding: const EdgeInsets.all(15.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: storecontroller.getsellershopprofiledata.value
                                ?.data?.sellerData?.phoneNumber ??
                            'Phone Number',
                        hintStyle: const TextStyle(color: Color(0xFF656565)),
                      ),
                      initialCountryCode: storecontroller
                          .getsellershopprofiledata
                          .value
                          ?.data
                          ?.sellerData
                          ?.phoneCountryCode,
                      onChanged: (phone) {
                        storecontroller.updateshopphonecode.value =
                            phone.countryCode;
                        storecontroller.updateshopphonecountrycode.value =
                            phone.countryISOCode;
                      },
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    customtextformfield(
                        controller: storecontroller
                            .updateshopwhatyousellcontroller.value,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Please Enter Sell";
                          }
                          return null;
                        },
                        hinttext: storecontroller.getsellershopprofiledata.value
                                ?.data?.sellerData?.sell ??
                            "What you Sell"),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    customtextformfield(
                        controller: storecontroller
                            .updateshopregistrationnumcontroller.value,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Please Enter ID";
                          }
                          return null;
                        },
                        hinttext: storecontroller.getsellershopprofiledata.value
                                ?.data?.sellerData?.registrationNumber ??
                            "Commercial Registration ID"),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    // customtextformfield(
                    //     validator: (v) {
                    //       if (v!.isEmpty) {
                    //         return "Please Enter Email";
                    //       } else if (!v.isEmail) {
                    //         return 'Invalid Email';
                    //       }
                    //       return null;
                    //     },
                    //     hinttext: "Email"),
                    // SizedBox(
                    //   height: 1.5.h,
                    // ),
                    Obx(
                      () => customtextformfield(
                          controller: authcontroller
                              .signupstreetaddrescontroller.value,
                          validator: (v) {
                            if (authcontroller
                                .signupstreetaddres.value.isEmpty) {
                              return "Please Enter Street Address";
                            }
                            return null;
                          },
                          hinttext:
                              authcontroller.signupstreetaddres.value.isEmpty
                                  ? storecontroller.getsellershopprofiledata
                                          .value?.data?.sellerData?.address ??
                                      'Street Address'
                                  : authcontroller.signupstreetaddres.value),
                    ),
                    Obx(
                      () {
                        if (authcontroller.places.isNotEmpty) {
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: authcontroller.places.length,
                            itemBuilder: (context, index) {
                              final place = authcontroller.places[index];
                              return ListTile(
                                title: Text(place['description']),
                                onTap: () {
                                  authcontroller
                                      .setSelectedPlace(place['place_id']);
                                  authcontroller.signupstreetaddres.value =
                                      place['description'];
                                  authcontroller
                                      .signupstreetaddrescontroller.value
                                      .clear();
                                  authcontroller.places.clear();
                                },
                              );
                            },
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),

                    customtextformfield(
                        controller:
                            authcontroller.signupcountryregioncontroller.value,
                        enabled: false,
                        hinttext: storecontroller.getsellershopprofiledata.value
                                ?.data?.sellerData?.country ??
                            "Country"),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 45.w,
                          child: customtextformfield(
                              controller:
                                  authcontroller.signupcitycontroller.value,
                              enabled: false,
                              hinttext: storecontroller.getsellershopprofiledata
                                      .value?.data?.sellerData?.city ??
                                  "City"),
                        ),
                        Container(
                          width: 45.w,
                          child: customtextformfield(
                              controller:
                                  authcontroller.signupzipcodecontroller.value,
                              enabled: false,
                              hinttext: storecontroller.getsellershopprofiledata
                                      .value?.data?.sellerData?.city ??
                                  "Zip Code"),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    custombutton(
                        hinttext: "Next",
                        ontap: () {
                          Get.toNamed(RouteConstants.sellerupdateshopdetails);
                        })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
