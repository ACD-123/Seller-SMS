import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/customeleveted_button.dart';
// import 'package:sms/customcomponents/customappbar.dart';
// import 'package:sms/customcomponents/customeleveted_button.dart';

class SellerRefundOrderDetails extends StatelessWidget {
  const SellerRefundOrderDetails({super.key});

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
                              color: Color(0xff757474)),
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
                          buttonName: 'Delivered')
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
                                Row(
                                  children: [
                                    Text(
                                      'H1 Gamepad',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 15.sp),
                                    ),
                                    SizedBox(
                                      width: 7.w,
                                    ),
                                    Text(
                                      'Approval: ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13.sp,
                                          color: Color(0xff757474)),
                                    ),
                                    Text(
                                      'Pending',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13.sp,
                                          color: Color(0xffE2001B)),
                                    )
                                  ],
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
                          color: Color(0xffF1EAEA),
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
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.error_outline_outlined,
                            color: Color(0xff989595)),
                        Text(
                          'Amount will be transferred after admin approval and amount will \n  be deducted from your earnings',
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 13.sp,
                              color: Color(0xff878787)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Reason',
                      style: TextStyle(
                          fontWeight: FontWeight.w400, fontSize: 16.sp),
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
                    SizedBox(
                      height: 2.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Images',
                              style: TextStyle(
                                  fontWeight: FontWeight.w400, fontSize: 16.sp),
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Image.asset(
                              'assets/images/imagesicon.png',
                              height: 3.h,
                              width: 3.w,
                            ),
                            SizedBox(
                              width: 1.w,
                            ),
                            Text(
                              '7 images',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 13.sp,
                                  color: Color(0xff757474)),
                            ),
                          ],
                        ),
                        Text("View More",
                            style: TextStyle(
                                color: const Color(0xff2E3192),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                decorationColor: const Color(0xff2E3192),
                                decoration: TextDecoration.underline))
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        customreasonimagescontainer(
                            image: 'assets/images/refundreasonimage1.png'),
                        customreasonimagescontainer(
                            image: 'assets/images/refundreasonimage4.png'),
                        customreasonimagescontainer(
                            image: 'assets/images/refundreasonimage2.png'),
                        customreasonimagescontainer(
                            image: 'assets/images/refundreasonimage4.png')
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
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

Container customreasonimagescontainer({required String image}) {
  return Container(
    height: 8.h,
    width: 20.w,
    decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xff2E3192),
        ),
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
        borderRadius: BorderRadius.circular(3)),
  );
}
