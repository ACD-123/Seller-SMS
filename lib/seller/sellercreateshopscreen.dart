import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/custom_textformfield.dart';
import 'package:smsseller/customcomponents/custombutton.dart';

class SellerCreateShopScreen extends StatefulWidget {
  const SellerCreateShopScreen({super.key});

  @override
  State<SellerCreateShopScreen> createState() => _SellerCreateShopScreenState();
}

class _SellerCreateShopScreenState extends State<SellerCreateShopScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  final authcontroller = Get.put(AuthenticationController(authRepo: Get.find()));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    authcontroller.signupstreetaddrescontroller.value.clear();
    authcontroller.signupstreetaddres.value = '';
    authcontroller.signupcountryregioncontroller.value.clear();
    authcontroller.signupcitycontroller.value.clear();
    authcontroller.signupzipcodecontroller.value.clear();
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
                    customtextformfield(
                        hinttext: "Business Name",
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
                        if (storecontroller
                            .phonenumbercontroller.value.text.isEmpty) {
                          return 'Please Enter Phone Number';
                        }
                        return null;
                      },
                      controller: storecontroller.phonenumbercontroller.value,
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
                        hintText: 'Phone Number',
                        hintStyle: const TextStyle(color: Color(0xFF656565)),
                      ),
                      initialCountryCode: 'KE',
                      onChanged: (phone) {
                        storecontroller.createshopphonecode.value =
                            phone.countryCode;
                      },
                    ),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    customtextformfield(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Please Enter Sell";
                          }
                          return null;
                        },
                        hinttext: "What you Sell"),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    customtextformfield(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Please Enter ID";
                          }
                          return null;
                        },
                        hinttext: "Commercial Registration ID"),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    customtextformfield(
                        validator: (v) {
                          if (v!.isEmpty) {
                            return "Please Enter Email";
                          } else if (!v.isEmail) {
                            return 'Invalid Email';
                          }
                          return null;
                        },
                        hinttext: "Email"),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Obx(() => customtextformfield(
                       controller:  authcontroller.signupstreetaddrescontroller.value,
                        validator: (v) {
                          if (authcontroller.signupstreetaddres.value.isEmpty) {
                            return "Please Enter Street Address";
                          }
                          return null;
                        },
                        hinttext: authcontroller.signupstreetaddres.value.isEmpty
                              ? 'Street Address'
                              : authcontroller.signupstreetaddres.value),),
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
                                authcontroller.signupstreetaddres.value = place['description'];
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
                      controller:  authcontroller.signupcountryregioncontroller.value,
                       enabled: false,
                      hinttext: "Country"),
                    SizedBox(
                      height: 1.5.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          
                          width: 45.w,
                          child: customtextformfield(
                            controller:  authcontroller.signupcitycontroller.value,
                            enabled: false,
                            hinttext: "City"),
                        ),
                        Container(
                          width: 45.w,
                          child: customtextformfield(
                            controller:  authcontroller.signupzipcodecontroller.value,
                             enabled: false,
                            hinttext: "Zip Code"),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    custombutton(
                        hinttext: "Next",
                        ontap: () {
                          // if (formKey.currentState!.validate()) {
                          //   if (storecontroller
                          //           .sellercreateshopuploadedprofileImage
                          //           .value ==
                          //       null || storecontroller
                          //   .phonenumbercontroller.value.text.isEmpty ) {
                          //     showErrrorSnackbar(
                          //         message: "Please fill all fields ");
                          //   } else {
                          //     Get.toNamed(RouteConstants.sellersetupshop);
                          //   }
                          // }
                           Get.toNamed(RouteConstants.sellersetupshop);
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
