import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/currencytext.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  ScrollController scrollcontroller = ScrollController();

  void _scrollListener() {
    if (scrollcontroller.offset >= scrollcontroller.position.maxScrollExtent &&
        !scrollcontroller.position.outOfRange) {
      storecontroller.getWalletTransections();
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    storecontroller.walletpage.value = 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      storecontroller.getWalletTransections();
    });
    scrollcontroller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
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
          'Wallet',
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
          controller: scrollcontroller,
          child: Obx(
            () => storecontroller.getwallettransectionsloading.value
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 35.h),
                    child: Center(
                      child: customcircularprogress(),
                    ),
                  )
                : storecontroller.getwallettransections.value == null ||
                        storecontroller.getwallettransections.value?.data ==
                            null
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.h),
                        child: Center(
                          child: nodatatext("No Wallet Data"),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Divider(),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w, vertical: 0.3.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 18.h,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xff000000)
                                                .withOpacity(0.04),
                                            offset: const Offset(0, 3.57),
                                            blurRadius: 10.7)
                                      ],
                                      borderRadius: BorderRadius.circular(7.13),
                                      color: Color(0xff1375EA)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.w,
                                        top: 3.h,
                                        right: 2.w,
                                        bottom: 1.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Text(
                                          "Available Balance",
                                          style: TextStyle(
                                              color: Color(0xffFFFFFF),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${currencytext()}${storecontroller.getwallettransections.value?.data?.availableBalance.toStringAsFixed(2) ?? "0"}",
                                                  style: TextStyle(
                                                      color: Color(0xffFFFFFF),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 21.sp),
                                                ),
                                                Text(
                                                  '${storecontroller.getwallettransections.value?.data?.finalGrowth.toStringAsFixed(2) ?? "0"}% month over month',
                                                  style: TextStyle(
                                                      color: Color(0xffFFFFFF),
                                                      // fontWeight: FontWeight.w500,
                                                      fontSize: 16.sp),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  height: 18.h,
                                  width: Get.width,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xffE0E0E0)),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xff000000)
                                                .withOpacity(0.04),
                                            offset: const Offset(0, 3.57),
                                            blurRadius: 10.7)
                                      ],
                                      borderRadius: BorderRadius.circular(7.13),
                                      color: const Color(0xffFFFFFF)),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 5.w,
                                        top: 3.h,
                                        right: 2.w,
                                        bottom: 1.h),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 1.5.h,
                                        ),
                                        Text(
                                          "Total Earning",
                                          style: TextStyle(
                                              color: Color(0xff000000),
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${currencytext()}${storecontroller.getwallettransections.value?.data?.earned.toStringAsFixed(2) ?? "0"}",
                                                  style: TextStyle(
                                                      color: Color(0xff2E3192),
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 21.sp),
                                                ),
                                                Text(
                                                  '${storecontroller.getwallettransections.value?.data?.earnedGrowth.toStringAsFixed(2) ?? "0"}% month over month',
                                                  style: TextStyle(
                                                      color: Color(0xff828282),
                                                      // fontWeight: FontWeight.w500,
                                                      fontSize: 16.sp),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                custombutton(hinttext: "Withdraw"),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Payment Method",
                                  style: TextStyle(
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 17.sp),
                                ),
                                Image.asset(
                                  "assets/images/orangemoneyicon.png",
                                  height: 6.h,
                                  width: 27.w,
                                  fit: BoxFit.fill,
                                ),
                                SizedBox(
                                  height: 2.h,
                                ),
                                Text(
                                  "Transactions",
                                  style: TextStyle(
                                      color: const Color(0xff000000),
                                      fontSize: 16.sp),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 5.h,
                            color: const Color(0xff2E3192),
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 18.w,
                                    child: Text(
                                      "Date",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20.w,
                                    child: Text(
                                      "Amount",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 22.w,
                                    child: Text(
                                      "Transaction ID",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.sp),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 18.w,
                                    child: Text(
                                      "Status",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14.sp),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        storecontroller.getwallettransections.value?.data
                                      ?.transactions?.isEmpty ??
                                  true
                              ? Center(
                                  child: nodatatext("No Transaction"),
                                )
                              : ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: storecontroller
                                      .getwallettransections
                                      .value
                                      ?.data
                                      ?.transactions
                                      ?.length,
                                  itemBuilder: (context, index) {
                                    final transactiondata = storecontroller
                                        .getwallettransections
                                        .value
                                        ?.data
                                        ?.transactions?[index];
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 3.w, vertical: 1.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: 18.w,
                                                child: Text(
                                                  transactiondata?.date
                                                          .toString() ??
                                                      "",
                                                  style: TextStyle(
                                                      color: const Color(
                                                              0XFF000000)
                                                          .withOpacity(0.69),
                                                      fontSize: 14.sp),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 20.w,
                                                child: Text(
                                                  "${currencytext()}${transactiondata?.amount.toString() ?? ""}",
                                                  style: TextStyle(
                                                      color: const Color(
                                                              0XFF000000)
                                                          .withOpacity(0.69),
                                                      fontSize: 14.sp),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 22.w,
                                                child: Text(
                                                  "TRX-00${transactiondata?.id.toString() ?? ""}",
                                                  style: TextStyle(
                                                      color: const Color(
                                                              0XFF000000)
                                                          .withOpacity(0.69),
                                                      fontSize: 14.sp),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 18.w,
                                                child: Text(
                                                  transactiondata?.type
                                                          .toString() ??
                                                      "",
                                                  style: TextStyle(
                                                      color: const Color(
                                                              0XFF000000)
                                                          .withOpacity(0.69),
                                                      fontSize: 14.sp),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        const Divider(),
                                        
                                      ],
                                    );
                                  }),
                                  storecontroller.getwallettransectionsreloadloading.value ?
                                        Center(child: customcircularprogress(),)
                                        : const  SizedBox(),


                                SizedBox(height: 5.h,)
                        ],
                      ),
          )),
    );
  }
}
