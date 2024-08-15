import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sms/customcomponents/custom_textformfield.dart';
// import 'package:sms/customcomponents/customappbar.dart';
// import 'package:sms/customcomponents/custombutton.dart';
// import 'package:sms/customcomponents/whitecustomdialogpopup.dart';
import 'package:smsseller/customcomponents/custom_textformfield.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/customcomponents/whitecustomdialogpopup.dart';

class SellerSetupPassword extends StatelessWidget {
  const SellerSetupPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Setup Password"),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            customtextformfield(hinttext: "Current Password"),
            SizedBox(
              height: 1.5.h,
            ),
            customtextformfield(hinttext: "New Password"),
            SizedBox(
              height: 1.5.h,
            ),
            customtextformfield(hinttext: "Confirm New Password"),
            SizedBox(
              height: 3.h,
            ),
            custombutton(
                hinttext: "Confirm",
                ontap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return customsuccessalertpopup(
                            message: "Password Successfully Changed");
                      });
                })
          ],
        ),
      ),
    );
  }
}
