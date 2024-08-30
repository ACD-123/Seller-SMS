import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/customcomponents/custom_textformfield.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class SellerSetupPassword extends StatefulWidget {
  const SellerSetupPassword({super.key});

  @override
  State<SellerSetupPassword> createState() => _SellerSetupPasswordState();
}

class _SellerSetupPasswordState extends State<SellerSetupPassword> {
  final formkey = GlobalKey<FormState>();
  final authcontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));

      @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authcontroller.inappconfirmnewpasswordcontroller.value.clear();
    authcontroller.inappcurrentpasswordcontroller.value.clear();
    authcontroller.inappnewpasswordcontroller.value.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Setup Password"),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                customtextformfield(
                    controller:
                        authcontroller.inappcurrentpasswordcontroller.value,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter password";
                      }
                      return null;
                    },
                    hinttext: "Current Password"),
                SizedBox(
                  height: 1.5.h,
                ),
                customtextformfield(
                  controller: authcontroller.inappnewpasswordcontroller.value,
                  hinttext: "New Password",
                  validator: (v) {
                    if (v == null || v.isEmpty) {
                      return "Please enter new password";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 1.5.h,
                ),
                customtextformfield(
                  controller:
                      authcontroller.inappconfirmnewpasswordcontroller.value,
                  hinttext: "Confirm New Password",
                  validator: (v) {
                    if (v !=
                        authcontroller.inappnewpasswordcontroller.value.text) {
                      return "Password Does Not match";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 3.h,
                ),
                Obx(() => authcontroller.inappchangepasswordloading.value
                    ? Center(
                        child: customcircularprogress(),
                      )
                    : custombutton(
                        hinttext: "Confirm",
                        ontap: () {
                          if (formkey.currentState!.validate()) {
                            authcontroller.inAppChangePassword(context);

                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return customsuccessalertpopup(
                            //           message: "Password Successfully Changed");
                            //     });
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
