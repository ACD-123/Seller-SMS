import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sms/customcomponents/customappbar.dart';
// import 'package:sms/customcomponents/customeleveted_button.dart';
import 'package:smsseller/customcomponents/customappbar.dart';

import '../customcomponents/customeleveted_button.dart';

class SellerActiveOrderDetails extends StatelessWidget {
  const SellerActiveOrderDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: 'Order Details'),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Text(
                  'Shipping Details',
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 16.sp),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                ),
                child: Container(
                  height: 15.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Color(0xffEFEFEF)),
                      color: Color(0xffF3F3F3).withOpacity(0.18)),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Anderson',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15.sp,
                                  color: Color(0xff757474)),
                            ),
                            Text(
                              'ORDER # :q54x514fe',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0xff2E3192)),
                            ),
                          ],
                        ),
                        Text(
                          '2438 6th Ave, Ketchikan, Alaska 99901, USA',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: Color(0xff757474)),
                        ),
                        Text(
                          '02184548845',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14.sp,
                              color: const Color(0xff757474)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 8.h,
                width: Get.width,
                color: Color(0xffD9D9D9).withOpacity(0.5),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Delivery Status',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 16.sp,
                                color: Color(0xff2E3192)),
                          ),
                          RichText(
                              text: TextSpan(children: [
                            TextSpan(
                              text: 'Est Delivery: Tue, ',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0xff757474)),
                            ),
                            TextSpan(
                              text: 'Dec 15',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0xff000000)),
                            ),
                            TextSpan(
                              text: ' -Wed,',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0xff757474)),
                            ),
                            TextSpan(
                              text: ' Dec 16',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.sp,
                                  color: Color(0xff000000)),
                            ),
                          ]))
                        ],
                      ),
                      CustomElevetedButton(
                          ontap: () {},
                          height: 3.5.h,
                          width: 32.w,
                          fontSize: 14.sp,
                          borderradius: 15,
                          color: Color(0xff2E3192),
                          buttonName: 'Pending')
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 12.h,
                      width: Get.width,
                      child: Row(
                        children: [
                          Container(
                            height: 12.h,
                            width: 33.w,
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color(0xff1375EA).withOpacity(0.25)),
                                borderRadius: BorderRadius.circular(15.62),
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/images/orderhistoryproductimage1.png"),
                                    fit: BoxFit.fill)),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'H1 Gamepad',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15.sp),
                                ),
                                Text(
                                  '\$260',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.sp,
                                      color: Color(0xff2E3192)),
                                ),
                                Text(
                                  'Save \$ 8.99 ( 40% off )',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Color(0xffEF0D0D)),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Row(children: [
                                  Text(
                                    'M (48)',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    width: 3.w,
                                  ),
                                  Image.asset('assets/images/Ellipse 8.png'),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    'Red',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.sp),
                                  ),
                                  SizedBox(
                                    width: 12.w,
                                  ),
                                  Text(
                                    'Quantity :  ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 13.sp,
                                        color: Color(0xff757474)),
                                  ),
                                  Container(
                                    height: 2.h,
                                    width: 5.w,
                                    color: Color(0xff2E3192),
                                    child: Center(
                                      child: Text(
                                        '1',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 13.sp,
                                            color: Color(0xffFFFFFF)),
                                      ),
                                    ),
                                  )
                                ])
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      'Order Summary',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xff1375EA).withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20)),
                      height: 19.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customamountrow(
                                title: 'Subtotal (2 items)', amount: '\$98.88'),
                            customamountrow(
                                title: 'Shipping', amount: '\$96.00'),
                            customamountrow(
                                title: 'Discount', amount: '\$-5.00'),
                            Divider(
                              color: Color(0xffAAA4A4),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Order Total',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.sp,
                                      color: Color(0xff2E3192)),
                                ),
                                Text(
                                  '\$ 198.00',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 17.sp,
                                      color: Color(0xff2E3192)),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      'Note',
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 16.sp),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadius.circular(20.79)),
                      height: 10.h,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        child: Text(
                          'This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32.',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                              color: Color(0xff2E2E2E)),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

////////custom amounts row
Padding customamountrow({
  required String title,
  required String amount,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: Color(0xff757474)),
        ),
        Text(
          amount,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
              color: Color(0xff757474)),
        ),
      ],
    ),
  );
}
