import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

Widget googlelogindetailsPopup() {
  final authcontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));
  return AlertDialog(
    // title: const Text("Select Image Source"),
    content: SingleChildScrollView(
        child: Form(
      key: authcontroller.googledetailsformkey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Icon(
                    Icons.clear,
                    color: const Color(0xff2E3192),
                    size: 20.sp,
                  )),
            ),
            SizedBox(
              height: 2.h,
            ),
            IntlPhoneField(
              validator: (v) {
                if (authcontroller
                    .socialphonenumbercontroller.value.text.isEmpty) {
                  return 'Phone Number can\'t be empty';
                }
                return null;
              },
              controller: authcontroller.socialphonenumbercontroller.value,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Phone Number',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16.sp),
              ),
              initialCountryCode: 'KE',
              onChanged: (phone) {
                authcontroller.socialphonecode.value = phone.countryCode;
                authcontroller.socialphonecountrycode.value =
                    phone.countryISOCode;
              },
            ),
            SizedBox(
              height: 1.h,
            ),
            TextFormField(
              controller: authcontroller.socialaccountnocontroller.value,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (v) {
                if (v!.isEmpty) {
                  return 'Account Number can\'t be empty';
                }
                return null;
              },
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: const Color(0xF3F3F3), width: 0),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.all(18.0),
                border: InputBorder.none,
                hintText: 'Orange Pay Account No:',
                hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image.asset(
                    'assets/images/ion_card-outline.png',
                    scale: 20.sp,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Obx(() => authcontroller.socialloginloading.value
                ? Center(
                    child: customcircularprogress(),
                  )
                : custombutton(
                    hinttext: "Save",
                    ontap: () {
                      if (authcontroller.googledetailsformkey.currentState!
                          .validate()) {
                        authcontroller
                                .socialphonenumbercontroller.value.text.isEmpty
                            ? showErrrorSnackbar(
                                message: "Please Enter Phone Number")
                            : authcontroller.socialLogin();
                      }
                    }))
          ],
        ),
      ),
    )),
  );
}
