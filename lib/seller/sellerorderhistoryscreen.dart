import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sms/controller/storecontroller.dart';
// import 'package:sms/customcomponents/customeleveted_button.dart';
import 'package:smsseller/controller/storecontroller.dart';

import '../customcomponents/customeleveted_button.dart';

class SellerOrderHistoryScreen extends StatefulWidget {
  const SellerOrderHistoryScreen({super.key});

  @override
  State<SellerOrderHistoryScreen> createState() =>
      _SellerOrderHistoryScreenState();
}

class _SellerOrderHistoryScreenState extends State<SellerOrderHistoryScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 25.h,
                color: Color(0xff1375EA).withOpacity(0.25),
                child: Obx(() => Padding(
                      padding: const EdgeInsets.all(18),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customordercountcontainer(
                                  title: 'Active Orders',
                                  count: '35',
                                  ontap: () {
                                    storecontroller.setsellerSelectedOrdercount(1);
                                  },
                                  isselected: storecontroller
                                          .issellerselectedOrdercount.value ==
                                      1),
                                      
                              customordercountcontainer(
                                  title: 'Completed Orders',
                                  count: '70',
                                  ontap: () {
                                    storecontroller.setsellerSelectedOrdercount(2);
                                  },
                                  isselected: storecontroller
                                          .issellerselectedOrdercount.value ==
                                      2),
                              customordercountcontainer(
                                  title: 'Refund Orders',
                                  count: '10',
                                  ontap: () {
                                    storecontroller.setsellerSelectedOrdercount(3);
                                  },
                                  isselected: storecontroller
                                          .issellerselectedOrdercount.value ==
                                      3),
                            ],
                          ),
                          SizedBox(height: 1.h,)
,                           Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              customordercountcontainer(
                                  title: 'Active Orders',
                                  count: '35',
                                  ontap: () {
                                    storecontroller.setsellerSelectedOrdercount(1);
                                  },
                                  isselected: storecontroller
                                          .issellerselectedOrdercount.value ==
                                      1),
                                    SizedBox(width: 7.w,)  ,
                              
                              customordercountcontainer(
                                  title: 'Refund Orders',
                                  count: '10',
                                  ontap: () {
                                    storecontroller.setsellerSelectedOrdercount(3);
                                  },
                                  isselected: storecontroller
                                          .issellerselectedOrdercount.value ==
                                      3),
                            ],
                          ),
                        ],
                      ),
                    ))),
            Obx(() => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: storecontroller.getSelectedsellerOrderList().length,
                itemBuilder: (context, index) {
                  final sellerordersdata =
                      storecontroller.getSelectedsellerOrderList()[index];
                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 17, left: 17),
                        child: customproductcontainer(
                            orderid: sellerordersdata['orderid'],
                            productname: sellerordersdata['productname'],
                            productimage: sellerordersdata['image'],
                            status: sellerordersdata['orderstatus'],
                            viewdetailsontap: () {
                              Get.toNamed(storecontroller
                                  .ontapsellerorderhistoryviewdetailsbutton());
                            }),
                      ),
                      Divider()
                    ],
                  );
                }))
          ],
        ),
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
Container customproductcontainer({
  required String orderid,
  required String productname,
  required String productimage,
  required String status,
  required VoidCallback viewdetailsontap,
}) {
  return Container(
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
                  child: Image.asset(
                    productimage,
                    height: 12.h,
                    width: 20.w,
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
                    SizedBox(
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
