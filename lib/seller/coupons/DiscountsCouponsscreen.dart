import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/storecontroller.dart';

class DiscountsCouponsScreen extends StatefulWidget {
  const DiscountsCouponsScreen({super.key});

  @override
  State<DiscountsCouponsScreen> createState() => _DiscountsCouponsScreenState();
}

class _DiscountsCouponsScreenState extends State<DiscountsCouponsScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff1375EA).withOpacity(0.25),
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
          'Discounts & Coupons',
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: Column(
        children: [
          Container(
            height: 0.1.h,
            color: const Color(0xffB5B5B5),
          ),
          Container(
              height: 20.h,
              color: const Color(0xff1375EA).withOpacity(0.25),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        storecontroller.updatediscountcouponboxcolor(1);
                      },
                      child: Container(
                        height: 12.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color:
                                storecontroller.discountcouponboxcolor.value ==
                                        1
                                    ? const Color(0xff1375EA)
                                    : const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(7.26)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Active Coupon",
                              style: TextStyle(
                                  color: storecontroller
                                              .discountcouponboxcolor.value ==
                                          1
                                      ? Colors.white
                                      : const Color(0xff2E3192),
                                  fontSize: 14.sp),
                            ),
                            Text(
                              "125",
                              style: TextStyle(
                                  color: storecontroller
                                              .discountcouponboxcolor.value ==
                                          1
                                      ? Colors.white
                                      : const Color(0xff000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        storecontroller.updatediscountcouponboxcolor(2);
                      },
                      child: Container(
                        height: 12.h,
                        width: 40.w,
                        decoration: BoxDecoration(
                            color:
                                storecontroller.discountcouponboxcolor.value ==
                                        2
                                    ? const Color(0xff1375EA)
                                    : const Color(0xffFFFFFF),
                            borderRadius: BorderRadius.circular(7.26)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Expired Coupon",
                              style: TextStyle(
                                  color: storecontroller
                                              .discountcouponboxcolor.value ==
                                          2
                                      ? Colors.white
                                      : const Color(0xff2E3192),
                                  fontSize: 14.sp),
                            ),
                            Text(
                              "12",
                              style: TextStyle(
                                  color: storecontroller
                                              .discountcouponboxcolor.value ==
                                          2
                                      ? Colors.white
                                      : const Color(0xff000000),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp,
                                  overflow: TextOverflow.ellipsis),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
