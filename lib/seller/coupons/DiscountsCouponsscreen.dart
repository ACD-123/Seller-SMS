import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class DiscountsCouponsScreen extends StatefulWidget {
  const DiscountsCouponsScreen({super.key});

  @override
  State<DiscountsCouponsScreen> createState() => _DiscountsCouponsScreenState();
}

class _DiscountsCouponsScreenState extends State<DiscountsCouponsScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      storecontroller.getCoupon();
    });
  }

  Future<void> onrefresh() async {
    storecontroller.getCoupon();
  }

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
      bottomNavigationBar: Container(
        height: 10.h,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff000000).withOpacity(0.15),
                  blurRadius: 4,
                  offset: Offset(0, -5))
            ],
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20), topLeft: Radius.circular(20)),
            color: Color(0xffFFFFFF)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: custombutton(
                  hinttext: "Add Coupon",
                  ontap: () {
                    Get.toNamed(RouteConstants.addnewcouponscreen);
                  }),
            )
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: onrefresh,
        child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Obx(
              () => storecontroller.getcouponsloading.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 35.h),
                      child: Center(
                        child: customcircularprogress(),
                      ),
                    )
                  : storecontroller.getcoupons.value == null ||
                          storecontroller.getcoupons.value?.data == null
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 35.h),
                          child: Center(
                            child: nodatatext("No Coupons Data"),
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              height: 0.1.h,
                              color: const Color(0xffB5B5B5),
                            ),
                            Container(
                              height: 20.h,
                              color: const Color(0xff1375EA).withOpacity(0.25),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      storecontroller
                                          .updatediscountcouponboxcolor(1);
                                    },
                                    child: Container(
                                      height: 12.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          color: storecontroller
                                                      .discountcouponboxcolor
                                                      .value ==
                                                  1
                                              ? const Color(0xff1375EA)
                                              : const Color(0xffFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(7.26)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Active Coupon",
                                            style: TextStyle(
                                                color: storecontroller
                                                            .discountcouponboxcolor
                                                            .value ==
                                                        1
                                                    ? Colors.white
                                                    : const Color(0xff2E3192),
                                                fontSize: 14.sp),
                                          ),
                                          Text(
                                            storecontroller.getcoupons.value
                                                    ?.data?.activeCount
                                                    .toString() ??
                                                "0",
                                            style: TextStyle(
                                                color: storecontroller
                                                            .discountcouponboxcolor
                                                            .value ==
                                                        1
                                                    ? Colors.white
                                                    : const Color(0xff000000),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.sp,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      storecontroller
                                          .updatediscountcouponboxcolor(2);
                                    },
                                    child: Container(
                                      height: 12.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          color: storecontroller
                                                      .discountcouponboxcolor
                                                      .value ==
                                                  2
                                              ? const Color(0xff1375EA)
                                              : const Color(0xffFFFFFF),
                                          borderRadius:
                                              BorderRadius.circular(7.26)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Expired Coupon",
                                            style: TextStyle(
                                                color: storecontroller
                                                            .discountcouponboxcolor
                                                            .value ==
                                                        2
                                                    ? Colors.white
                                                    : const Color(0xff2E3192),
                                                fontSize: 14.sp),
                                          ),
                                          Text(
                                            storecontroller.getcoupons.value
                                                    ?.data?.expiredCount
                                                    .toString() ??
                                                "0",
                                            style: TextStyle(
                                                color: storecontroller
                                                            .discountcouponboxcolor
                                                            .value ==
                                                        2
                                                    ? Colors.white
                                                    : const Color(0xff000000),
                                                fontWeight: FontWeight.bold,
                                                fontSize: 22.sp,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 3.h,
                            ),
                            Container(
                              height: 5.h,
                              color: const Color(0xff2E3192),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 2.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "S.no",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.sp),
                                    ),
                                    Text(
                                      "Coupons",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.sp),
                                    ),
                                    Text(
                                      "Discount",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.sp),
                                    ),
                                    Text(
                                      "Valid Till",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.sp),
                                    ),
                                    SizedBox(
                                      width: 12.w,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Obx(() {
                              if (storecontroller
                                      .discountcouponboxcolor.value ==
                                  1) {
                                if (storecontroller.getcoupons.value?.data
                                        ?.activeCoupons?.isEmpty ??
                                    true) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 17.h),
                                    child: nodatatext("No Active Coupons"),
                                  );
                                } else {
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: storecontroller.getcoupons
                                          .value?.data?.activeCoupons?.length,
                                      itemBuilder: (context, index) {
                                        final sno = index + 1;
                                        final activecoupondata = storecontroller
                                            .getcoupons
                                            .value
                                            ?.data
                                            ?.activeCoupons?[index];
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 1.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 8.w,
                                                    child: Text(
                                                      sno.toString(),
                                                      style: TextStyle(
                                                          color: const Color(
                                                                  0xff000000)
                                                              .withOpacity(
                                                                  0.69),
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 17.w,
                                                    child: Text(
                                                      activecoupondata?.code
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: const Color(
                                                                  0xff000000)
                                                              .withOpacity(
                                                                  0.69),
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                    child: Text(
                                                      activecoupondata?.discount
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: const Color(
                                                                  0xff000000)
                                                              .withOpacity(
                                                                  0.69),
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 17.w,
                                                    child: Text(
                                                      activecoupondata?.endDate
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: const Color(
                                                                  0xff000000)
                                                              .withOpacity(
                                                                  0.69),
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12.w,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        InkWell(
                                                          onTap: () async {
                                                            await storecontroller
                                                                .getCouponById(
                                                                    activecoupondata
                                                                            ?.id
                                                                            .toString() ??
                                                                        "");
                                                            Get.toNamed(
                                                                RouteConstants
                                                                    .updatecouponscreen);
                                                          },
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: Color(
                                                                0xff1375EA),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return deletecouponpopuop(
                                                                      yesontap:
                                                                          () async {
                                                                    await storecontroller.deleteCoupon(
                                                                        activecoupondata?.id.toString() ??
                                                                            "");
                                                                    storecontroller
                                                                        .getcoupons
                                                                        .update(
                                                                            (val) {
                                                                      val?.data?.activeCoupons?.removeWhere((active) =>
                                                                          active
                                                                              .id ==
                                                                          activecoupondata
                                                                              ?.id);
                                                                    });
                                                                  }, noontap:
                                                                          () {
                                                                    Get.back();
                                                                  });
                                                                });
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Color(
                                                                0xff1375EA),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              const Divider()
                                            ],
                                          ),
                                        );
                                      });
                                }
                              } else {
                                if (storecontroller.getcoupons.value?.data
                                        ?.expiredCoupons?.isEmpty ??
                                    true) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 17.h),
                                    child: nodatatext("No Expired Coupons"),
                                  );
                                } else {
                                  return ListView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: storecontroller.getcoupons
                                          .value?.data?.expiredCoupons?.length,
                                      itemBuilder: (context, index) {
                                        final expiresno = index + 1;
                                        final expirecoupondata = storecontroller
                                            .getcoupons
                                            .value
                                            ?.data
                                            ?.expiredCoupons?[index];
                                        return Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 2.w, vertical: 1.h),
                                          child: Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: 8.w,
                                                    child: Text(
                                                      expiresno.toString(),
                                                      style: TextStyle(
                                                          color: const Color(
                                                                  0xff000000)
                                                              .withOpacity(
                                                                  0.69),
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 17.w,
                                                    child: Text(
                                                      expirecoupondata?.code
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: const Color(
                                                                  0xff000000)
                                                              .withOpacity(
                                                                  0.69),
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 8.w,
                                                    child: Text(
                                                      expirecoupondata?.discount
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: const Color(
                                                                  0xff000000)
                                                              .withOpacity(
                                                                  0.69),
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 17.w,
                                                    child: Text(
                                                      expirecoupondata?.endDate
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                          color: const Color(
                                                                  0xff000000)
                                                              .withOpacity(
                                                                  0.69),
                                                          fontSize: 14.sp),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 12.w,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return deletecouponpopuop(
                                                                      yesontap:
                                                                          () async {
                                                                    await storecontroller.deleteCoupon(
                                                                        expirecoupondata?.id.toString() ??
                                                                            "");
                                                                    storecontroller
                                                                        .getcoupons
                                                                        .update(
                                                                            (val) {
                                                                      val?.data?.expiredCoupons?.removeWhere((expire) =>
                                                                          expire
                                                                              .id ==
                                                                          expirecoupondata
                                                                              ?.id);
                                                                    });
                                                                  }, noontap:
                                                                          () {
                                                                    Get.back();
                                                                  });
                                                                });
                                                          },
                                                          child: Icon(
                                                            Icons.delete,
                                                            color: Color(
                                                                0xff1375EA),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                height: 1.h,
                                              ),
                                              const Divider()
                                            ],
                                          ),
                                        );
                                      });
                                }
                              }
                            })
                          ],
                        ),
            )),
      ),
    );
  }
}

deletecouponpopuop(
    {required VoidCallback yesontap, required VoidCallback noontap}) {
  return AlertDialog(
    backgroundColor: Colors.transparent,
    contentPadding: EdgeInsets.zero,
    content: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(18.sp),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              "assets/images/deletepopupicon.png",
              fit: BoxFit.fill,
              height: 8.h,
              width: 15.w,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              "Are you sure you want to delete your Coupon ?",
              style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 2.h,
            ),
            GestureDetector(
              onTap: yesontap,
              child: Container(
                height: 4.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.28),
                    color: const Color(0xff2E3192)),
                child: Center(
                    child: Text("Yes",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xffFFFFFF),
                        ))),
              ),
            ),
            SizedBox(
              height: 1.h,
            ),
            GestureDetector(
              onTap: noontap,
              child: Container(
                height: 4.h,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff000000)),
                  borderRadius: BorderRadius.circular(5.28),
                ),
                child: Center(
                    child: Text("No",
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: const Color(0xff757474),
                        ))),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
