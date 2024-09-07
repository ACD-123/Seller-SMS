import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/ordercontroller.dart';
import 'package:smsseller/customcomponents/currencytext.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

import '../customcomponents/customeleveted_button.dart';

class SellerRefundOrderDetails extends StatefulWidget {
  const SellerRefundOrderDetails({super.key});

  @override
  State<SellerRefundOrderDetails> createState() =>
      _SellerRefundOrderDetailsState();
}

class _SellerRefundOrderDetailsState extends State<SellerRefundOrderDetails> {
  final ordercontroller = Get.put(OrderController(orderRepo: Get.find()));
  String? selectedoption;

  final List<Map<String, dynamic>> options = [
    {
      "id": "approved",
      "status": "Approve",
    },
    {
      "id": "rejected",
      "status": "Reject",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customappbar(title: 'Order Details'),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SingleChildScrollView(child: Obx(() {
              if (ordercontroller.getrefundorderdetailsbyidloading.value) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 35.h),
                  child: Center(
                    child: customcircularprogress(),
                  ),
                );
              } else if (ordercontroller.getrefundorderdetailsbyid.value ==
                      null ||
                  ordercontroller.getrefundorderdetailsbyid.value?.data ==
                      null) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 35.h),
                  child: Center(
                    child: nodatatext("No Order Details"),
                  ),
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 18,
                      ),
                      child: Text(
                        'Shipping Details',
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16.sp),
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
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xffEFEFEF)),
                            color: const Color(0xffF3F3F3).withOpacity(0.18)),
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    ordercontroller.getrefundorderdetailsbyid
                                            .value?.data?.user?.name
                                            .toString() ??
                                        "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                        color: const Color(0xff757474)),
                                  ),
                                  Text(
                                    'ORDER # ${ordercontroller.getrefundorderdetailsbyid.value?.data?.orderid.toString() ?? ""}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: const Color(0xff2E3192)),
                                  ),
                                ],
                              ),
                              Text(
                                ordercontroller.getrefundorderdetailsbyid.value
                                        ?.data?.user?.address
                                        .toString() ??
                                    "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: const Color(0xff757474)),
                              ),
                              Text(
                                '${ordercontroller.getrefundorderdetailsbyid.value?.data?.user?.phoneCode.toString() ?? ""}-${ordercontroller.getrefundorderdetailsbyid.value?.data?.user?.phoneNumber.toString() ?? ""}',
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
                      color: const Color(0xffD9D9D9).withOpacity(0.5),
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
                                      color: const Color(0xff2E3192)),
                                ),
                                // RichText(
                                //     text: TextSpan(children: [
                                //   TextSpan(
                                //     text: 'Est Delivery: Tue, ',
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.w400,
                                //         fontSize: 14.sp,
                                //         color: const Color(0xff757474)),
                                //   ),
                                //   TextSpan(
                                //     text: 'Dec 15',
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.w400,
                                //         fontSize: 14.sp,
                                //         color: const Color(0xff000000)),
                                //   ),
                                //   TextSpan(
                                //     text: ' -Wed,',
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.w400,
                                //         fontSize: 14.sp,
                                //         color: const Color(0xff757474)),
                                //   ),
                                //   TextSpan(
                                //     text: ' Dec 16',
                                //     style: TextStyle(
                                //         fontWeight: FontWeight.w400,
                                //         fontSize: 14.sp,
                                //         color: const Color(0xff000000)),
                                //   ),
                                // ]))
                              ],
                            ),
                            CustomElevetedButton(
                                ontap: () {},
                                height: 3.5.h,
                                width: 32.w,
                                fontSize: 14.sp,
                                borderradius: 15,
                                color: const Color(0xff2E3192),
                                buttonName: ordercontroller
                                        .getrefundorderdetailsbyid
                                        .value
                                        ?.data
                                        ?.orderProductIds
                                        ?.first
                                        .status ??
                                    "")
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
                          ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: ordercontroller
                                  .getrefundorderdetailsbyid
                                  .value
                                  ?.data
                                  ?.orderProductIds
                                  ?.length,
                              itemBuilder: (context, index) {
                                final refunddetailsdata = ordercontroller
                                    .getrefundorderdetailsbyid
                                    .value
                                    ?.data
                                    ?.orderProductIds?[index];
                                return Padding(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: SizedBox(
                                    width: Get.width,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              height: 12.h,
                                              width: 33.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Color(0xff1375EA)
                                                          .withOpacity(0.25)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15.62),
                                                  image: DecorationImage(
                                                      image: NetworkImage(refunddetailsdata
                                                                      ?.product
                                                                      ?.media ==
                                                                  null ||
                                                              refunddetailsdata!
                                                                  .product!
                                                                  .media!
                                                                  .isEmpty
                                                          ? AppConstants.noimage
                                                          : refunddetailsdata
                                                                  .product
                                                                  ?.media
                                                                  ?.first
                                                                  .originalUrl ??
                                                              AppConstants
                                                                  .noimage),
                                                      fit: BoxFit.fill)),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: 20.w,
                                                        child: Text(
                                                       refunddetailsdata
                                                                  ?.product
                                                                  ?.title
                                                                  .toString() ??
                                                              "",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontSize: 15.sp),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 3.w,
                                                      ),
                                                       refunddetailsdata?.refund?.status == "pending"  ? 
                                         
                                                      SizedBox(
                                                        height: 2.8.h,
                                                        width: 25.w,
                                                        child: Center(
                                                            child:
                                                                DropdownButtonFormField<
                                                                    String>(
                                                          decoration:
                                                              InputDecoration(
                                                            hintText: "Pending",
                                                            hintStyle:
                                                                TextStyle(
                                                              fontSize: 16.sp,
                                                              color: Color(
                                                                  0xff2E3192),
                                                            ),
                                                            enabledBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xff2E3192)),
                                                            ),
                                                            focusedBorder:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                              borderSide: BorderSide(
                                                                  color: Color(
                                                                      0xff2E3192)),
                                                            ),
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                                    left: 8,
                                                                    right: 2),
                                                            border:
                                                                OutlineInputBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          14),
                                                            ),
                                                          ),
                                                          value: selectedoption,
                                                          onChanged:
                                                              (newValue) {
                                                            selectedoption =
                                                                newValue!;
                                                            ordercontroller.updateRefundOrderStatus(id:  refunddetailsdata?.refund?.id.toString() ?? "", status: newValue);
                                                          
                                                          },
                                                          items: options.map(
                                                              (statusoptions) {
                                                            return DropdownMenuItem<
                                                                String>(
                                                              value:
                                                                  statusoptions[
                                                                      "id"],
                                                              child: Text(
                                                                statusoptions[
                                                                    "status"],
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      16.sp,
                                                                  color: Color(
                                                                      0xff2E3192),
                                                                ),
                                                              ),
                                                            );
                                                          }).toList(),
                                                        )),
                                                      ):
                                                      Row(children: [
                                                        Text(
                                                        'Approval: ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 13.sp,
                                                            color: const Color(
                                                                0xff757474)),
                                                      ),
                                                      Text(
                                                        refunddetailsdata
                                                                ?.refund?.status
                                                                .toString() ??
                                                            "",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 13.sp,
                                                            color: const Color(
                                                                0xffE2001B)),
                                                      )
                                                      ],)
                                                    ],
                                                  ),
                                                  Text(
                                                    refunddetailsdata?.product
                                                                    ?.discountPrice ==
                                                                null ||
                                                            refunddetailsdata
                                                                    ?.product
                                                                    ?.discountPrice ==
                                                                "0"
                                                        ? '${currencytext()}${refunddetailsdata?.product?.price ?? ""}'
                                                        : '${currencytext()}${refunddetailsdata?.product?.discountPrice ?? ""}',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 17.sp,
                                                        color: const Color(
                                                            0xff2E3192)),
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        refunddetailsdata
                                                                    ?.product
                                                                    ?.discountPrice ==
                                                                null
                                                            ? 'Save ${currencytext()}0 ( ${(refunddetailsdata?.product?.disPercentage ?? "").toStringAsFixed(2)}% off )'
                                                            : 'Save ${currencytext()}${'${((double.parse(refunddetailsdata?.product?.price.toString() ?? "0.00")) - (double.parse(refunddetailsdata?.product?.discountPrice.toString() ?? "0.00"))).toStringAsFixed(2)}'} ( ${refunddetailsdata?.product?.disPercentage.toString() ?? ""}% off )',
                                                        style: TextStyle(
                                                            fontSize: 12.sp,
                                                            color: Color(
                                                                0xffEF0D0D)),
                                                      ),
                                                      SizedBox(
                                                        width: 1.w,
                                                      ),
                                                      Text(
                                                        'Quantity: ',
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 13.sp,
                                                            color: Color(
                                                                0xff757474)),
                                                      ),
                                                      Container(
                                                        color: const Color(
                                                            0xff2E3192),
                                                        child: Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(2),
                                                            child: Text(
                                                              refunddetailsdata
                                                                      ?.quantity
                                                                      .toString() ??
                                                                  "",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize:
                                                                      13.sp,
                                                                  color: const Color(
                                                                      0xffFFFFFF)),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                  SizedBox(
                                                    height: 2.h,
                                                    child:
                                                        SingleChildScrollView(
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      child: Row(children: [
                                                        ListView.builder(
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            scrollDirection:
                                                                Axis.horizontal,
                                                            shrinkWrap: true,
                                                            itemCount:
                                                                refunddetailsdata
                                                                    ?.orderAttribute
                                                                    ?.length,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final attributedata =
                                                                  refunddetailsdata
                                                                          ?.orderAttribute?[
                                                                      index];
                                                              return Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        right: 1
                                                                            .w),
                                                                child: Text(
                                                                  "${attributedata?.attribute?.name ?? ""}, ",
                                                                  style: TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          13.sp),
                                                                ),
                                                              );
                                                            }),
                                                      ]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        refunddetailsdata?.refund == null
                                            ? const SizedBox()
                                            : Row(
                                                children: [
                                                  Text(
                                                    'Images',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 16.sp),
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
                                                    '${refunddetailsdata?.refund?.media?.length.toString() ?? 0} images',
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 13.sp,
                                                        color:
                                                            Color(0xff757474)),
                                                  ),
                                                ],
                                              ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        refunddetailsdata?.refund == null ||
                                                refunddetailsdata
                                                        ?.refund?.media ==
                                                    null ||
                                                refunddetailsdata!
                                                    .refund!.media!.isEmpty
                                            ? const SizedBox()
                                            : SizedBox(
                                                height: 6.h,
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(
                                                    children: [
                                                      ListView.builder(
                                                          physics:
                                                              const NeverScrollableScrollPhysics(),
                                                          shrinkWrap: true,
                                                          scrollDirection:
                                                              Axis.horizontal,
                                                          itemCount:
                                                              refunddetailsdata
                                                                      .refund
                                                                      ?.media
                                                                      ?.length ??
                                                                  0,
                                                          itemBuilder:
                                                              (context, index) {
                                                            final refundimages =
                                                                refunddetailsdata
                                                                        .refund
                                                                        ?.media?[
                                                                    index];
                                                            return customreasonimagescontainer(
                                                                image: refundimages
                                                                        ?.originalUrl ??
                                                                    AppConstants
                                                                        .noimage);
                                                          })
                                                    ],
                                                  ),
                                                ),
                                              ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        refunddetailsdata?.refund == null
                                            ? const SizedBox()
                                            : Text(
                                                'Reason',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 16.sp),
                                              ),
                                        SizedBox(
                                          height: 0.5.h,
                                        ),
                                        refunddetailsdata?.refund == null
                                            ? const SizedBox()
                                            : Container(
                                                decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xffF5F5F5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.79)),
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12,
                                                      vertical: 15),
                                                  child: Text(
                                                    refunddetailsdata
                                                            ?.refund?.reason
                                                            .toString() ??
                                                        "",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        fontSize: 13.sp,
                                                        color:
                                                            Color(0xff2E2E2E)),
                                                  ),
                                                ),
                                              ),
                                        const Divider(),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                          SizedBox(
                            height: 2.h,
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
                                color:
                                    const Color(0xff1375EA).withOpacity(0.25),
                                borderRadius: BorderRadius.circular(20)),
                            height: 19.h,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  customamountrow(
                                      title:
                                          'Subtotal (${ordercontroller.getrefundorderdetailsbyid.value?.data?.orderProductIds?.length} items)',
                                      amount:
                                          '${currencytext()}${ordercontroller.getrefundorderdetailsbyid.value?.data?.subtotalPrice.toString() ?? ""}'),
                                  customamountrow(
                                      title: 'Shipping',
                                      amount:
                                          '${currencytext()}${ordercontroller.getrefundorderdetailsbyid.value?.data?.shippingCost.toString() ?? ""}'),
                                  customamountrow(
                                      title: 'Discount',
                                      amount:
                                          '${currencytext()}${ordercontroller.getrefundorderdetailsbyid.value?.data?.discount.toString() ?? ""}'),
                                  const Divider(
                                    color: Color(0xffAAA4A4),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Order Total',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17.sp,
                                            color: Color(0xff2E3192)),
                                      ),
                                      Text(
                                        '${currencytext()}${((double.parse(ordercontroller.getrefundorderdetailsbyid.value?.data?.totalPrice.toString() ?? "0.00")) + (double.parse(ordercontroller.getrefundorderdetailsbyid.value?.data?.shippingCost.toString() ?? "0.00"))).toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 17.sp,
                                            color: const Color(0xff2E3192)),
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
                          ordercontroller.getrefundorderdetailsbyid.value?.data
                                          ?.note ==
                                      null ||
                                  ordercontroller.getrefundorderdetailsbyid
                                      .value!.data!.note!.isEmpty
                              ? const SizedBox()
                              : Text(
                                  'Note',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.sp),
                                ),
                          SizedBox(
                            height: 1.h,
                          ),
                          ordercontroller.getrefundorderdetailsbyid.value?.data
                                          ?.note ==
                                      null ||
                                  ordercontroller.getrefundorderdetailsbyid
                                      .value!.data!.note!.isEmpty
                              ? const SizedBox()
                              : Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xffF5F5F5),
                                      borderRadius:
                                          BorderRadius.circular(20.79)),
                                  width: Get.width,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 15),
                                    child: Text(
                                      ordercontroller.getrefundorderdetailsbyid
                                              .value?.data?.note
                                              .toString() ??
                                          "",
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
                );
              }
            }))));
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

Padding customreasonimagescontainer({required String image}) {
  return Padding(
    padding: EdgeInsets.only(right: 1.w),
    child: Container(
      height: 6.h,
      width: 17.w,
      decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xff2E3192),
          ),
          image: DecorationImage(image: NetworkImage(image), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(3)),
    ),
  );
}
