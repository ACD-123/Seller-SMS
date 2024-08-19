import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/custom_textformfield.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class SellerProfileScreen extends StatefulWidget {
  const SellerProfileScreen({super.key});

  @override
  State<SellerProfileScreen> createState() => _SellerProfileScreenState();
}

class _SellerProfileScreenState extends State<SellerProfileScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  final logincontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    storecontroller.getSellerProfileData();
    storecontroller.updatesellerprofilename.value.clear();
    storecontroller.updatesellerprofilephonecode.value = '';
    storecontroller.updatesellerprofilephonenumber.value.clear();
    storecontroller.sellershopuploadedprofileImage.value = null;
    logincontroller.signupcountryregioncontroller.value.clear();
    logincontroller.signupstreetaddres.value = '';
    logincontroller.signupcitycontroller.value.clear();
    logincontroller.signupzipcodecontroller.value.clear();
    logincontroller.signupstateprovincecontroller.value.clear();
    logincontroller.signupstreetaddrescontroller.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: 'Profile'),
      body: SingleChildScrollView(
          child: Obx(
        () => storecontroller.getsellerprofiledataloading.value
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 35.h),
                child: Center(
                  child: customcircularprogress(),
                ),
              )
            : storecontroller.getsellerprofiledata.value == null
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 35.h),
                    child: const Center(child: Text("No Profile Data")),
                  )
                : Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              height: 17.h,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/myprofilebackgroundimage.png",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(50)),
                              ),
                            ),
                            Positioned(
                              top: 6.h,
                              left: 35.w,
                              right: 35.w,
                              child: GestureDetector(
                                onTap: () {
                                  storecontroller
                                      .uploadsellershopprofileImage(context);
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
                                                color: Color(0xffFFFFFF),
                                                width: 5),
                                          ),
                                          child: CircleAvatar(
                                            radius: 32.sp,
                                            backgroundImage: storecontroller
                                                        .sellershopuploadedprofileImage
                                                        .value !=
                                                    null
                                                ? FileImage(storecontroller
                                                    .sellershopuploadedprofileImage
                                                    .value!)
                                                : NetworkImage(storecontroller
                                                                .getsellerprofiledata
                                                                .value ==
                                                            null ||
                                                        storecontroller
                                                            .getsellerprofiledata
                                                            .value!
                                                            .data!
                                                            .media!
                                                            .isEmpty
                                                    ? AppConstants.noimage
                                                    : storecontroller
                                                            .getsellerprofiledata
                                                            .value
                                                            ?.data
                                                            ?.media
                                                            ?.first
                                                            .originalUrl ??
                                                        AppConstants
                                                            .noimage) as ImageProvider,
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
                          storecontroller
                                  .getsellerprofiledata.value?.data?.name ??
                              "",
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            color: Color(0XFF2E3192),
                          ),
                        ),
                        Text(
                          "Joined since : ${storecontroller.getsellerprofiledata.value?.data?.joined ?? ""}",
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
                                  controller: storecontroller
                                      .updatesellerprofilename.value,
                                  hinttext: storecontroller.getsellerprofiledata
                                          .value?.data?.name ??
                                      "",
                                  suffixicon: Image.asset(
                                      'assets/images/profilesettingediticon.png')),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              IntlPhoneField(
                                // validator: (v) {
                                //   if (storecontroller
                                //       .phonenumbercontroller.value.text.isEmpty) {
                                //     return 'Please Enter Phone Number';
                                //   }
                                //   return null;
                                // },
                                controller: storecontroller
                                    .updatesellerprofilephonenumber.value,
                        
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
                                  hintText: storecontroller.getsellerprofiledata
                                          .value?.data?.phoneNumber ??
                                      "",
                                  hintStyle:
                                      const TextStyle(color: Color(0xFF656565)),
                                ),

                                initialCountryCode: storecontroller
                                    .getsellerprofiledata
                                    .value
                                    ?.data
                                    ?.phoneCode,
                                onChanged: (phone) {
                                  storecontroller.updatesellerprofilephonecode
                                      .value = phone.countryCode;
                                },
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              // customtextformfield(
                              //     hinttext: "Business Name",
                              //     suffixicon: Image.asset(
                              //         'assets/images/profilesettingediticon.png')),
                              // SizedBox(
                              //   height: 1.5.h,
                              // ),
                              // customtextformfield(
                              //     hinttext: storecontroller
                              //             .getsellershopprofiledata
                              //             .value
                              //             ?.data
                              //             ?.sellerData
                              //             ?.sell ??
                              //         "",
                              //     suffixicon: Image.asset(
                              //         'assets/images/profilesettingediticon.png')),
                              // SizedBox(
                              //   height: 1.5.h,
                              // ),
                              customtextformfield(
                                enabled: false,
                                hinttext: storecontroller.getsellerprofiledata
                                        .value?.data?.email ??
                                    "",
                                // suffixicon: Image.asset(
                                //     'assets/images/profilesettingediticon.png')
                              ),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              customtextformfield(
                                  controller: logincontroller
                                      .signupstreetaddrescontroller.value,
                                  hinttext: logincontroller
                                          .signupstreetaddres.value.isEmpty
                                      ? storecontroller.getsellerprofiledata
                                              .value?.data?.address ??
                                          "Street Address"
                                      : logincontroller
                                          .signupstreetaddres.value,
                                  suffixicon: Image.asset(
                                      'assets/images/profilesettingediticon.png')),
                              Obx(
                                () {
                                  if (logincontroller.places.isNotEmpty) {
                                    return ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: logincontroller.places.length,
                                      itemBuilder: (context, index) {
                                        final place =
                                            logincontroller.places[index];
                                        return ListTile(
                                          title: Text(place['description']),
                                          onTap: () {
                                            logincontroller.setSelectedPlace(
                                                place['place_id']);
                                            logincontroller.signupstreetaddres
                                                .value = place['description'];
                                            logincontroller
                                                .signupstreetaddrescontroller
                                                .value
                                                .clear();
                                            logincontroller.places.clear();
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
                                  enabled: false,
                                  controller: logincontroller
                                      .signupstateprovincecontroller.value,
                                  hinttext: storecontroller.getsellerprofiledata
                                          .value?.data?.state ??
                                      "State",
                                  suffixicon: Image.asset(
                                      'assets/images/profilesettingediticon.png')),
                              SizedBox(
                                height: 1.5.h,
                              ),

                              customtextformfield(
                                  enabled: false,
                                  controller: logincontroller
                                      .signupcountryregioncontroller.value,
                                  hinttext: storecontroller.getsellerprofiledata
                                          .value?.data?.country ??
                                      "Country",
                                  suffixicon: Image.asset(
                                      'assets/images/profilesettingediticon.png')),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: 45.w,
                                    child: customtextformfield(
                                        enabled: false,
                                        controller: logincontroller
                                            .signupcitycontroller.value,
                                        hinttext: storecontroller
                                                .getsellerprofiledata
                                                .value
                                                ?.data
                                                ?.city ??
                                            "City",
                                        suffixicon: Image.asset(
                                            'assets/images/profilesettingediticon.png')),
                                  ),
                                  Container(
                                    width: 45.w,
                                    child: customtextformfield(
                                        enabled: false,
                                        controller: logincontroller
                                            .signupzipcodecontroller.value,
                                        hinttext: storecontroller
                                                .getsellerprofiledata
                                                .value
                                                ?.data
                                                ?.zipCode ??
                                            "ZipCode",
                                        suffixicon: Image.asset(
                                            'assets/images/profilesettingediticon.png')),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Obx(() => storecontroller
                                      .updateSellerProfileDataloading.value
                                  ? Center(
                                      child: customcircularprogress(),
                                    )
                                  : custombutton(
                                      hinttext: "Save",
                                      ontap: () {
                                        if (formKey.currentState!.validate()) {
                                          storecontroller.updateSellerProfileData(
                                              context: context,
                                              address: logincontroller
                                                  .signupstreetaddres.value
                                                  .toString(),
                                              city: logincontroller
                                                  .signupcitycontroller
                                                  .value
                                                  .text
                                                  .toString(),
                                              state: logincontroller
                                                  .signupstateprovincecontroller
                                                  .value
                                                  .text
                                                  .toString(),
                                              country: logincontroller
                                                  .signupcountryregioncontroller
                                                  .value
                                                  .text
                                                  .toString(),
                                              zipcode: logincontroller
                                                  .signupzipcodecontroller
                                                  .value
                                                  .text
                                                  .toString());
                                        }
                                      }))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
      )),
    );
  }
}
