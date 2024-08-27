import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/authcontroller.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/controller/storecontroller.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/custombutton.dart';

class SellerDashboardScreen extends StatefulWidget {
  const SellerDashboardScreen({super.key});

  @override
  State<SellerDashboardScreen> createState() => _SellerDashboardScreenState();
}

class _SellerDashboardScreenState extends State<SellerDashboardScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  final authcontroller = Get.put(AuthenticationController(authRepo: Get.find()));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storecontroller.getSellerShopProfileData();
    storecontroller.getSellerProfileData();
    storecontroller.getSellerTotalSalesStats(storecontroller.todaysalesselectedmonth.value.toString());
    storecontroller.getSellerItemsSoldStats(storecontroller.itemssoldselectedmonth.value.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteConstants.sellerprofilescreen);
                    },
                    child: Container(
                      child: Row(
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              CircleAvatar(
                                radius: 25.sp,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                  storecontroller
                                        .getsellerprofiledata
                                        .value == null || storecontroller
                                        .getsellerprofiledata
                                        .value!.data!.media!.isEmpty  ? AppConstants.noimage : 
                                  storecontroller
                                        .getsellerprofiledata
                                        .value
                                        ?.data
                                        ?.media?.first.originalUrl ??
                                    AppConstants.noimage),
                              ),
                              Positioned(
                                right: 0,
                                top: 48,
                                child: Container(
                                  width: 5.w,
                                  height: 3.h,
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          blurRadius: 2.07,
                                          offset: Offset(0, 2.07),
                                          color: Color(0xff000000)
                                              .withOpacity(0.25))
                                    ],
                                    color: Color(0xffFFFFFF),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.camera_alt_outlined,
                                    size: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 1.w,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8, left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  storecontroller
                                        .getsellerprofiledata
                                        .value
                                        ?.data?.name ??
                                      "",
                                  style: TextStyle(
                                      color: Color(0xff2E3192),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18.sp),
                                ),
                                SizedBox(
                                  width: 1.w,
                                ),
                                Text(
                                  'Hello ${storecontroller
                                        .getsellerprofiledata
                                        .value
                                        ?.data?.name ?? ""}',
                                  style: TextStyle(
                                      color: Color(0xff2E3192),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  height: 21.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff000000).withOpacity(0.04),
                            offset: Offset(0, 3.57),
                            blurRadius: 10.7)
                      ],
                      borderRadius: BorderRadius.circular(7.13),
                      color: Color(0xff1375EA)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, top: 17, right: 20, bottom: 17),
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                          child:  DropdownButton<String>(
                              value:
                                  storecontroller.todaysalesselectedmonth.value,
                              onChanged: (newValue) {
                                storecontroller.todaysalesselectedmonth.value =
                                    newValue!;
                                storecontroller.getSellerTotalSalesStats(newValue);
                              },
                              items:
                                  storecontroller.selectmonthslist.map((months) {
                                return DropdownMenuItem<String>(
                                  value: months,
                                  child: Text(
                                    months,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xffFFFFFF),
                                    ),
                                  ),
                                );
                              }).toList(),
                              underline: SizedBox(),
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Color(0xffFFFFFF),
                                size: 17.sp,
                              ),
                              dropdownColor: Color(0xff1375EA),
                            ),
                          
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'Total Sales',
                          style: TextStyle(
                              color: Color(0xffFFFFFF),
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '\$${storecontroller.getsellertotalsalesstats.value?.data?.currentMonthEarning ?? ""}',
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25.sp),
                                ),
                                Text(
                                  '+${storecontroller.getsellertotalsalesstats.value?.data?.percentageGrowth ?? ""}% month over month',
                                  style: TextStyle(
                                      color: Color(0xffFFFFFF),
                                      // fontWeight: FontWeight.w500,
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/images/sellerdashboardarrowline.png',
                              height: 6.h,
                            )
                          ],
                        )
                      ],
                    ),)
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 21.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xff000000).withOpacity(0.04),
                            offset: Offset(0, 3.57),
                            blurRadius: 10.7)
                      ],
                      borderRadius: BorderRadius.circular(7.13),
                      border: Border.all(color: Color(0xffE0E0E0)),
                      color: Color(0xffFFFFFF)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 25, top: 17, right: 20, bottom: 15),
                    child: Obx(() => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 2.h,
                          child: DropdownButton<String>(
                              value:
                                  storecontroller.itemssoldselectedmonth.value,
                              onChanged: (newValue) {
                                storecontroller.itemssoldselectedmonth.value =
                                    newValue!;
                                    storecontroller.getSellerItemsSoldStats(newValue);
                              },
                              items:
                                  storecontroller.selectmonthslist.map((bank) {
                                return DropdownMenuItem<String>(
                                  value: bank,
                                  child: Text(
                                    bank,
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: Color(0xff828282),
                                    ),
                                  ),
                                );
                              }).toList(),
                              underline: SizedBox(),
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: Color(0xff828282),
                                size: 17.sp,
                              ),
                            ),
                          
                        ),
                        SizedBox(
                          height: 1.5.h,
                        ),
                        Text(
                          'Items Sold',
                          style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                storecontroller.getselleritemssoldstats.value?.data?.totalProductsSoldCurrentMonth.toString() ??   '',
                                  style: TextStyle(
                                      color: Color(0xff2E3192),
                                      fontWeight: FontWeight.w600,
                                      fontSize: 25.sp),
                                ),
                                Text(
                                  '+${ storecontroller.getselleritemssoldstats.value?.data?.percentageGrowth.toString() ??   ''}% month over month',
                                  style: TextStyle(
                                      color: Color(0xff828282),
                                      // fontWeight: FontWeight.w500,
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                            Image.asset(
                              'assets/images/sellerdashboardarrowline.png',
                              height: 6.h,
                              color: Color(0xff2E3192),
                            )
                          ],
                        )
                      ],
                    ),)
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Dashboard',
                  style: TextStyle(color: Color(0xff828282), fontSize: 15.sp),
                ),
                SizedBox(
                  height: 1.h,
                ),
                customdashboardcontainer(
                    title: 'Order History',
                    image: 'assets/images/sellerdashboardorderhistoryicon.png',
                    ontap: () {
                      Get.toNamed(RouteConstants.sellerorderhistoryscreen);
                    }),
                SizedBox(
                  height: 2.h,
                ),
                customdashboardcontainer(
                    title: 'Bank Details',
                    image: 'assets/images/sellerdashboardbankdetailsicon.png',
                    ontap: () {
                      Get.toNamed(RouteConstants.banksetting);
                    }),
                SizedBox(
                  height: 2.h,
                ),
                customdashboardcontainer(
                    title: 'Store Profile',
                    image: 'assets/images/sellerdashboardstoreprofileicon.png',
                    ontap: () {
                      Get.toNamed(RouteConstants.sellersideshop);
                    }),
                SizedBox(
                  height: 2.h,
                ),
                customdashboardcontainer(
                    title: 'Inventory Management',
                    image: 'assets/images/sellerdashboardinventoryicon.png',
                    ontap: () {
                      Get.toNamed(RouteConstants.inventory);
                    }),
                SizedBox(
                  height: 2.h,
                ),
                customdashboardcontainer(
                    title: 'Sales Report',
                    image: 'assets/images/sellerdashboardsalesreporticon.png',
                    ontap: () {
                      Get.toNamed(RouteConstants.sellersalesreportscreen);
                    }),
                SizedBox(
                  height: 2.h,
                ),
                customdashboardcontainer(
                    title: 'Setting',
                    image: 'assets/images/sellerdashboardsettinicon.png',
                    ontap: () {
                      Get.toNamed(RouteConstants.sellersettingscreen);
                    }),
                SizedBox(
                  height: 2.h,
                ),
                 custombutton(
                    hinttext: "Sign Out",
                    ontap: () {
                     authcontroller.signout();
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//////custom dashboard container

GestureDetector customdashboardcontainer(
    {required String title,
    required String image,
    required VoidCallback ontap}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      height: 7.h,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0xff000000).withOpacity(0.1),
                offset: Offset(0, 8.75),
                blurRadius: 16.53)
          ],
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xffDBDBDB)),
          color: Color(0xffFFFFFF)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 17),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(
                  image,
                  height: 2.5.h,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  title,
                  style: TextStyle(color: Color(0xff828282), fontSize: 15.sp),
                ),
              ],
            ),
            Image.asset(
              'assets/images/arrowforward.png',
              height: 2.5.h,
            ),
          ],
        ),
      ),
    ),
  );
}
