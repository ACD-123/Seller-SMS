import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/ordercontroller.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

import '../customcomponents/customeleveted_button.dart';

class SellerOrderHistoryScreen extends StatefulWidget {
  const SellerOrderHistoryScreen({super.key});

  @override
  State<SellerOrderHistoryScreen> createState() =>
      _SellerOrderHistoryScreenState();
}

class _SellerOrderHistoryScreenState extends State<SellerOrderHistoryScreen> {
  final ordercontroller = Get.put(OrderController(orderRepo: Get.find()));
  final scrollcontroller = ScrollController();

  Future<void> onrefresh() async {
    ordercontroller.pendingorderspage.value = 1;
    ordercontroller.activeorderspage.value = 1;
    ordercontroller.completedorderspage.value = 1;
    ordercontroller.recentorderspage.value = 1;
    ordercontroller.recentorderspage.value = 1;
    ordercontroller.getOrderHistoryCount();
    if (ordercontroller.issellerselectedOrdercount.value == 1) {
      ordercontroller.getPendingOrders();
    } else if (ordercontroller.issellerselectedOrdercount.value == 2) {
      ordercontroller.getActiveOrders();
    } else if (ordercontroller.issellerselectedOrdercount.value == 3) {
      ordercontroller.getCompletedOrders();
    }
    else if (ordercontroller.issellerselectedOrdercount.value == 4) {
      ordercontroller.getRefundedOrders();
    }
     else if (ordercontroller.issellerselectedOrdercount.value == 4) {
      ordercontroller.getRejectedOrders();
    }
  }

  @override
  void initState() {
    super.initState();
    ordercontroller.pendingorderspage.value = 1;
    ordercontroller.activeorderspage.value = 1;
    ordercontroller.completedorderspage.value = 1;
    ordercontroller.refundedorderspage.value = 1;
    ordercontroller.rejectedorderspage.value = 1;
    ordercontroller.issellerselectedOrdercount.value = 1;
  WidgetsBinding.instance.addPostFrameCallback((_) {
 ordercontroller.getOrderHistoryCount();
    ordercontroller.getPendingOrders();
    });
    scrollcontroller.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollcontroller.offset >= scrollcontroller.position.maxScrollExtent &&
        !scrollcontroller.position.outOfRange) {
      if (ordercontroller.issellerselectedOrdercount.value == 1) {
        ordercontroller.getPendingOrders();
      } else if (ordercontroller.issellerselectedOrdercount.value == 2) {
        ordercontroller.getActiveOrders();
      } else if (ordercontroller.issellerselectedOrdercount.value == 3) {
        ordercontroller.getCompletedOrders();
      }
      else if (ordercontroller.issellerselectedOrdercount.value == 4) {
        ordercontroller.getRefundedOrders();
      }
      else if (ordercontroller.issellerselectedOrdercount.value == 5) {
        ordercontroller.getRejectedOrders();
      }
    }
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
        backgroundColor: Color(0xff1375EA).withOpacity(0.25),
        elevation: 0.0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18.sp,
            )),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'Order History',
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: onrefresh,
        child: SingleChildScrollView(
            controller: scrollcontroller,
            child: Obx(
              () => Column(
                children: [
                  Container(
                      height: 25.h,
                      color: Color(0xff1375EA).withOpacity(0.25),
                      child: Obx(() => Padding(
                            padding: const EdgeInsets.all(18),
                            child: ordercontroller
                                    .getorderhistorycountloading.value
                                ? Center(
                                    child: SizedBox(
                                      height: 3.h,
                                      width: 6.w,
                                      child: customcircularprogress(),
                                    ),
                                  )
                                : ordercontroller.getorderhistorycount.value ==
                                        null
                                    ? Center(
                                        child: nodatatext("No Orders Count"),
                                      )
                                    : Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              customordercountcontainer(
                                                  title: 'Pending Orders',
                                                  count: ordercontroller
                                                          .getorderhistorycount
                                                          .value
                                                          ?.data
                                                          ?.pending
                                                          .toString() ??
                                                      "0",
                                                  ontap: () {
                                                    ordercontroller
                                                        .pendingorderspage
                                                        .value = 1;
                                                    ordercontroller
                                                        .getPendingOrders();
                                                    ordercontroller
                                                        .setsellerSelectedOrdercount(
                                                            1);
                                                  },
                                                  isselected: ordercontroller
                                                          .issellerselectedOrdercount
                                                          .value ==
                                                      1),
                                              customordercountcontainer(
                                                  title: 'Active Orders',
                                                  count: ordercontroller
                                                          .getorderhistorycount
                                                          .value
                                                          ?.data
                                                          ?.active
                                                          .toString() ??
                                                      "0",
                                                  ontap: () {
                                                    ordercontroller
                                                        .activeorderspage
                                                        .value = 1;
                                                    ordercontroller
                                                        .getActiveOrders();
                                                    ordercontroller
                                                        .setsellerSelectedOrdercount(
                                                            2);
                                                  },
                                                  isselected: ordercontroller
                                                          .issellerselectedOrdercount
                                                          .value ==
                                                      2),
                                              customordercountcontainer(
                                                  title: 'Completed Orders',
                                                  count: ordercontroller
                                                          .getorderhistorycount
                                                          .value
                                                          ?.data
                                                          ?.completed
                                                          .toString() ??
                                                      "0",
                                                  ontap: () {
                                                     ordercontroller
                                                        .completedorderspage
                                                        .value = 1;
                                                    ordercontroller
                                                        .getCompletedOrders();
                                                    ordercontroller
                                                        .setsellerSelectedOrdercount(
                                                            3);
                                                  },
                                                  isselected: ordercontroller
                                                          .issellerselectedOrdercount
                                                          .value ==
                                                      3),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              customordercountcontainer(
                                                  title: 'Refund Orders',
                                                  count: ordercontroller
                                                          .getorderhistorycount
                                                          .value
                                                          ?.data
                                                          ?.refunded
                                                          .toString() ??
                                                      "0",
                                                  ontap: () {
                                                     ordercontroller
                                                        .refundedorderspage
                                                        .value = 1;
                                                    ordercontroller
                                                        .getRefundedOrders();
                                                    ordercontroller
                                                        .setsellerSelectedOrdercount(
                                                            4);
                                                  },
                                                  isselected: ordercontroller
                                                          .issellerselectedOrdercount
                                                          .value ==
                                                      4),
                                              SizedBox(
                                                width: 7.w,
                                              ),
                                              customordercountcontainer(
                                                  title: 'Rejected Orders',
                                                  count: ordercontroller
                                                          .getorderhistorycount
                                                          .value
                                                          ?.data
                                                          ?.rejected
                                                          .toString() ??
                                                      "0",
                                                  ontap: () {
                                                      ordercontroller
                                                        .rejectedorderspage
                                                        .value = 1;
                                                    ordercontroller
                                                        .getRejectedOrders();
                                                    ordercontroller
                                                        .setsellerSelectedOrdercount(
                                                            5);
                                                  },
                                                  isselected: ordercontroller
                                                          .issellerselectedOrdercount
                                                          .value ==
                                                      5),
                                            ],
                                          ),
                                        ],
                                      ),
                          ))),
                  Obx(() {
                    if (ordercontroller.issellerselectedOrdercount.value == 1) {
                      if (ordercontroller.getpendingordersloading.value) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Center(child: customcircularprogress()),
                        );
                      } else if (ordercontroller.getpendingorders.value ==
                              null ||
                          ordercontroller
                              .getpendingorders.value!.data!.orders!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Center(child: nodatatext("No Pending Orders")),
                        );
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ordercontroller
                              .getpendingorders.value?.data?.orders?.length,
                          itemBuilder: (context, index) {
                            final pendingdata = ordercontroller
                                .getpendingorders.value?.data?.orders?[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17),
                                  child: customproductcontainer(
                                    orderid:
                                        "Order Id# ${pendingdata?.orderid ?? ""}",
                                    productname: pendingdata?.note ?? "",
                                    productimage:
                                        pendingdata?.user?.media == null
                                            ? AppConstants.noimage
                                            : pendingdata?.user?.media?.first
                                                    .originalUrl ??
                                                AppConstants.noimage,
                                    status: "Pending",
                                    viewdetailsontap: () {
                                      ordercontroller.getOrderDetailsbyId(
                                          pendingdata?.id ?? 0, 0);
                                      Get.toNamed(RouteConstants
                                          .sellerpendingdetailsscreen);
                                    },
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        );
                      }
                    } else if (ordercontroller
                            .issellerselectedOrdercount.value ==
                        2) {
                      if (ordercontroller.getactiveordersloading.value) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Center(child: customcircularprogress()),
                        );
                      } else if (ordercontroller.getactiveorders.value ==
                              null ||
                          ordercontroller
                              .getactiveorders.value!.data!.orders!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Center(child: nodatatext("No Active Orders")),
                        );
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ordercontroller
                              .getactiveorders.value?.data?.orders?.length,
                          itemBuilder: (context, index) {
                            final activedata = ordercontroller
                                .getactiveorders.value?.data?.orders?[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17),
                                  child: customproductcontainer(
                                    orderid:
                                        "Order Id# ${activedata?.orderid ?? ""}",
                                    productname: activedata?.note ?? "",
                                    productimage:
                                        activedata?.user?.media == null
                                            ? AppConstants.noimage
                                            : activedata?.user?.media?.first
                                                    .originalUrl ??
                                                AppConstants.noimage,
                                    status: "Accepted",
                                    viewdetailsontap: () {
                                      ordercontroller.getOrderDetailsbyId(
                                          activedata?.id ?? 0, 1);
                                      Get.toNamed(RouteConstants
                                          .selleractiveorderdetailsscreen);
                                    },
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        );
                      }
                    } else if (ordercontroller
                            .issellerselectedOrdercount.value ==
                        3) {
                      if (ordercontroller.getcompletedordersloading.value) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Center(child: customcircularprogress()),
                        );
                      } else if (ordercontroller.getcompletedorders.value ==
                              null ||
                          ordercontroller.getcompletedorders.value!.data!
                              .orders!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child:
                              Center(child: nodatatext("No Completed Orders")),
                        );
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ordercontroller
                              .getcompletedorders.value?.data?.orders?.length,
                          itemBuilder: (context, index) {
                            final completeddata = ordercontroller
                                .getcompletedorders.value?.data?.orders?[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17),
                                  child: customproductcontainer(
                                    orderid:
                                        "Order Id# ${completeddata?.orderid ?? ""}",
                                    productname: completeddata?.note ?? "",
                                    productimage:
                                        completeddata?.user?.media == null
                                            ? AppConstants.noimage
                                            : completeddata?.user?.media?.first
                                                    .originalUrl ??
                                                AppConstants.noimage,
                                    status: "Completed",
                                    viewdetailsontap: () {
                                      ordercontroller.getOrderDetailsbyId(
                                          completeddata?.id ?? 0, 3);
                                      Get.toNamed(RouteConstants
                                          .sellerorderdetailsscreen);
                                    },
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        );
                      }
                    } else if (ordercontroller
                            .issellerselectedOrdercount.value ==
                        4) {
                      if (ordercontroller.getrefundedordersloading.value) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Center(child: customcircularprogress()),
                        );
                      } else if (ordercontroller.getrefundedorders.value ==
                              null ||
                          ordercontroller
                              .getrefundedorders.value!.data!.orders!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child:
                              Center(child: nodatatext("No Refunded Orders")),
                        );
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ordercontroller
                              .getrefundedorders.value?.data?.orders?.length,
                          itemBuilder: (context, index) {
                            final refundeddata = ordercontroller
                                .getrefundedorders.value?.data?.orders?[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17),
                                  child: customproductcontainer(
                                    orderid:
                                        "Order Id# ${refundeddata?.orderid ?? ""}",
                                    productname: refundeddata?.note ?? "",
                                    productimage:
                                        refundeddata?.user?.media == null
                                            ? AppConstants.noimage
                                            : refundeddata?.user?.media?.first
                                                    .originalUrl ??
                                                AppConstants.noimage,
                                    status: "Refunded",
                                    viewdetailsontap: () {
                                      ordercontroller.getRefundOrderDetailsById(
                                          refundeddata?.id ?? 0);
                                      Get.toNamed(RouteConstants
                                          .sellerrefundorderdetailsscreen);
                                    },
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        );
                      }
                    } else if (ordercontroller
                            .issellerselectedOrdercount.value ==
                        5) {
                      if (ordercontroller.getrejectedordersloading.value) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child: Center(child: customcircularprogress()),
                        );
                      } else if (ordercontroller.getrejectedorders.value ==
                              null ||
                          ordercontroller
                              .getrejectedorders.value!.data!.orders!.isEmpty) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 25.h),
                          child:
                              Center(child: nodatatext("No Rejected Orders")),
                        );
                      } else {
                        return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: ordercontroller
                              .getrejectedorders.value?.data?.orders?.length,
                          itemBuilder: (context, index) {
                            final rejecteddata = ordercontroller
                                .getrejectedorders.value?.data?.orders?[index];
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 17),
                                  child: customproductcontainer(
                                    orderid:
                                        "Order Id# ${rejecteddata?.orderid ?? ""}",
                                    productname: rejecteddata?.note ?? "",
                                    productimage:
                                        rejecteddata?.user?.media == null
                                            ? AppConstants.noimage
                                            : rejecteddata?.user?.media?.first
                                                    .originalUrl ??
                                                AppConstants.noimage,
                                    status: "Rejected",
                                    viewdetailsontap: () {
                                      ordercontroller.getOrderDetailsbyId(
                                          rejecteddata?.id ?? 0, 2);
                                      Get.toNamed(RouteConstants
                                          .sellerorderdetailsscreen);
                                    },
                                  ),
                                ),
                                const Divider(),
                              ],
                            );
                          },
                        );
                      }
                    } else {
                      return const SizedBox();
                    }
                  }),
                  if (ordercontroller.issellerselectedOrdercount.value ==
                      1) ...[
                    if (ordercontroller.getpendingordersreloading.value)
                      Center(child: customcircularprogress()),
                  ] else if (ordercontroller.issellerselectedOrdercount.value ==
                      2) ...[
                    if (ordercontroller.getactiveordersreloading.value)
                      Center(child: customcircularprogress()),
                  ] else if (ordercontroller.issellerselectedOrdercount.value ==
                      3) ...[
                    if (ordercontroller.getcompletedordersreloading.value)
                      Center(child: customcircularprogress()),
                  ]else if (ordercontroller.issellerselectedOrdercount.value ==
                      4) ...[
                    if (ordercontroller.getrefundedordersreloading.value)
                      Center(child: customcircularprogress()),
                  ]else if (ordercontroller.issellerselectedOrdercount.value ==
                      5) ...[
                    if (ordercontroller.getrejectedordersreloading.value)
                      Center(child: customcircularprogress()),
                  ],
                  SizedBox(
                    height: 4.h,
                  )
                ],
              ),
            )),
      ),
    );
  }
}

////////////custom orders count container
GestureDetector customordercountcontainer({
  required String title,
  required String count,
  required VoidCallback ontap,
  required bool isselected,
}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      height: 9.h,
      width: 28.w,
      decoration: BoxDecoration(
          border: Border.all(
              color: isselected ? Colors.transparent : Color(0xffE0E0E0)),
          color: isselected ? Color(0xff1375EA) : Color(0xffFFFFFF),
          borderRadius: BorderRadius.circular(4.11)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 0.4.h,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w600,
                color: isselected ? Color(0xffFFFFFF) : Color(0xff000000)),
          ),
          Text(
            count,
            style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w600,
                color: isselected ? Color(0xffFFFFFF) : Color(0xff2E3192)),
          )
        ],
      ),
    ),
  );
}

//////custom productcontainer
SizedBox customproductcontainer({
  required String orderid,
  required String productname,
  required String productimage,
  required String status,
  required VoidCallback viewdetailsontap,
}) {
  return SizedBox(
    height: 13.h,
    width: Get.width,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Image.network(
                    productimage,
                    height: 10.h,
                    width: 20.w,
                    fit: BoxFit.fill,
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      orderid,
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    productname.isEmpty
                        ? const SizedBox()
                        : SizedBox(
                            height: 4.2.h,
                            width: 48.w,
                            child: Text(
                              productname,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 0.7.h,
                    ),
                    Text(
                      status,
                      style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w700,
                          color: Color(0xff2E3192)),
                    ),
                  ],
                ),
              )
            ],
          ),
          CustomElevetedButton(
              ontap: viewdetailsontap,
              height: 3.h,
              width: 17.w,
              fontSize: 12.sp,
              borderradius: 9,
              color: Color(0xff2E3192),
              buttonName: 'View Details')
        ],
      ),
    ),
  );
}
