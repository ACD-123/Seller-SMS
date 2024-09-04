import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/custom_textformfield.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class AddNewCouponScreen extends StatefulWidget {
  const AddNewCouponScreen({super.key});

  @override
  State<AddNewCouponScreen> createState() => _AddNewCouponScreenState();
}

class _AddNewCouponScreenState extends State<AddNewCouponScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    storecontroller.selectstartdate.value.clear();
    storecontroller.selectenddate.value.clear();
    storecontroller.createcouponname.value.clear();
    storecontroller.createcouponcode.value.clear();
    storecontroller.createminorder.value.clear();
    storecontroller.creatediscount.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
            )),
        title: Text(
          'Add New Coupon',
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),
      ),
      bottomNavigationBar: Container(
        height: 10.h,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.15),
                  blurRadius: 4,
                  offset: const Offset(0, -5))
            ],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: const Color(0xffFFFFFF)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Obx(() => storecontroller.createcouponloading.value
                  ? Center(
                      child: customcircularprogress(),
                    )
                  : custombutton(
                      hinttext: "Add Coupon",
                      ontap: () {
                        if (formkey.currentState!.validate()) {
                          storecontroller.createCoupon();
                        }
                      })),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                customtextformfield(
                    controller: storecontroller.createcouponname.value,
                    hinttext: "Coupon Name",
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter coupon name";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 2.h,
                ),
                customtextformfield(
                    controller: storecontroller.createcouponcode.value,
                    hinttext: "Coupon Code",
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter coupon code";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 2.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 47.w,
                      child: GestureDetector(
                        onTap: () async {
                          final startdate =
                              await storecontroller.selectDate(context);
                          if (startdate != null) {
                            storecontroller.selectstartdate.value.text =
                                startdate;
                            formkey.currentState?.validate();
                          }
                        },
                        child: customtextformfield(
                            controller: storecontroller.selectstartdate.value,
                            enabled: false,
                            hinttext: "Start Date",
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Please select start date";
                              }
                              return null;
                            }),
                      ),
                    ),
                    SizedBox(
                      width: 47.w,
                      child: GestureDetector(
                        onTap: () async {
                          final enddate =
                              await storecontroller.selectDate(context);
                          if (enddate != null) {
                            storecontroller.selectenddate.value.text = enddate;
                            formkey.currentState?.validate();
                          }
                        },
                        child: customtextformfield(
                            controller: storecontroller.selectenddate.value,
                            enabled: false,
                            hinttext: "End Date",
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return "Please select end date";
                              }
                              return null;
                            }),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                customtextformfield(
                    controller: storecontroller.createminorder.value,
                    keyboardType: TextInputType.number,
                    hinttext: "Min Order",
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter min order";
                      }
                      return null;
                    }),
                SizedBox(
                  height: 2.h,
                ),
                customtextformfield(
                    controller: storecontroller.creatediscount.value,
                    keyboardType: TextInputType.number,
                    hinttext: "Max Discount",
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return "Please enter max discount";
                      }
                      return null;
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
