import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/custom_textformfield.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/custombutton.dart';

class SellerSetupBank extends StatefulWidget {
  const SellerSetupBank({super.key});

  @override
  State<SellerSetupBank> createState() => _SellerSetupBankState();
}

class _SellerSetupBankState extends State<SellerSetupBank> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Setup Bank"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: const Color(0XFFFFFFFF),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 10,
                              offset: const Offset(0, 9),
                              color: const Color(0xff000000).withOpacity(0.06))
                        ]),
                    child: DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          hintText: "Select Bank",
                          hintStyle: TextStyle(
                            fontSize: 15.sp,
                            color: Color(0xff656565),
                          ),
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
                        ),
                        value: storecontroller.selectedbank,
                        onChanged: (newValue) {
                          storecontroller.selectedbank = newValue!;
                        },
                        items: storecontroller.selectbanklist.map((bank) {
                          return DropdownMenuItem<String>(
                            value: bank,
                            child: Text(
                              bank,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Color(0xff656565),
                              ),
                            ),
                          );
                        }).toList(),
                        icon: Icon(
                          Icons.keyboard_arrow_down_outlined,
                          color: Color(0xff2E3192),
                        )),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  customtextformfield(
                    hinttext: "Bank Account / IBAN",
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  customtextformfield(
                      hinttext: "SWIFT/ Routing Number",
                      keyboardType: TextInputType.number),
                  SizedBox(
                    height: 2.h,
                  ),
                  customtextformfield(hinttext: "Account holder Name"),
                  SizedBox(
                    height: 48.h,
                  ),
                  custombutton(
                      hinttext: "Next Step",
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
