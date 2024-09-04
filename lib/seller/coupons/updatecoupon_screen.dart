import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/custom_textformfield.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class UpdateCouponScreen extends StatefulWidget {
  const UpdateCouponScreen({super.key});

  @override
  State<UpdateCouponScreen> createState() => _UpdateCouponScreenState();
}

class _UpdateCouponScreenState extends State<UpdateCouponScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  final formkey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    storecontroller.updatecouponstartdate.value.clear();
    storecontroller.updatecouponenddate.value.clear();
    storecontroller.updatecouponname.value.clear();
    storecontroller.updatecouponcode.value.clear();
    storecontroller.updatecouponminorder.value.clear();
    storecontroller.updatecoupondiscount.value.clear();
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
          'Update Coupon',
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
              child: Obx(() {
                if (storecontroller.getcouponsbyid.value == null ||
                    storecontroller.getcouponsbyid.value?.data == null) {
                  return const SizedBox();
                } else {
                  if (storecontroller.updatecouponloading.value) {
                    return Center(
                      child: customcircularprogress(),
                    );
                  } else {
                    return custombutton(
                      hinttext: "Update Coupon",
                      ontap: () {
                        storecontroller.updateCoupon();
                      },
                    );
                  }
                }
              }),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Form(
              key: formkey,
              child: Obx(
                () => storecontroller.getcouponsbyidloading.value
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.h),
                        child: Center(
                          child: customcircularprogress(),
                        ),
                      )
                    : storecontroller.getcouponsbyid.value == null ||
                            storecontroller.getcouponsbyid.value?.data == null
                        ? Padding(
                            padding: EdgeInsets.symmetric(vertical: 35.h),
                            child: Center(
                              child: nodatatext("No Coupon Data"),
                            ),
                          )
                        : Column(
                            children: [
                              customtextformfield(
                                  controller:
                                      storecontroller.updatecouponname.value,
                                  hinttext: storecontroller
                                          .getcouponsbyid.value?.data?.title
                                          .toString() ??
                                      "Coupon Name",
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
                                  controller:
                                      storecontroller.updatecouponcode.value,
                                  hinttext: storecontroller
                                          .getcouponsbyid.value?.data?.code
                                          .toString() ??
                                      "Coupon Code",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 47.w,
                                    child: GestureDetector(
                                      onTap: () async {
                                        final startdate = await storecontroller
                                            .selectDate(context);
                                        if (startdate != null) {
                                          storecontroller.updatecouponstartdate
                                              .value.text = startdate;
                                        }
                                      },
                                      child: customtextformfield(
                                          controller: storecontroller
                                              .updatecouponstartdate.value,
                                          enabled: false,
                                          hinttext: storecontroller
                                                  .getcouponsbyid
                                                  .value
                                                  ?.data
                                                  ?.startDate
                                                  .toString() ??
                                              "Start Date",
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
                                        final enddate = await storecontroller
                                            .selectDate(context);
                                        if (enddate != null) {
                                          storecontroller.updatecouponenddate
                                              .value.text = enddate;
                                        }
                                      },
                                      child: customtextformfield(
                                          controller: storecontroller
                                              .updatecouponenddate.value,
                                          enabled: false,
                                          hinttext: storecontroller
                                                  .getcouponsbyid
                                                  .value
                                                  ?.data
                                                  ?.endDate
                                                  .toString() ??
                                              "End Date",
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
                                  controller: storecontroller
                                      .updatecouponminorder.value,
                                  keyboardType: TextInputType.number,
                                  hinttext: storecontroller
                                          .getcouponsbyid.value?.data?.minOrder
                                          .toString() ??
                                      "Min Order",
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
                                  controller: storecontroller
                                      .updatecoupondiscount.value,
                                  keyboardType: TextInputType.number,
                                  hinttext: storecontroller
                                          .getcouponsbyid.value?.data?.discount
                                          .toString() ??
                                      "Max Discount",
                                  validator: (v) {
                                    if (v == null || v.isEmpty) {
                                      return "Please enter max discount";
                                    }
                                    return null;
                                  }),
                            ],
                          ),
              )),
        ),
      ),
    );
  }
}
