import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/ordercontroller.dart';
import 'package:smsseller/customcomponents/currencytext.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class SellerActiveOrderDetails extends StatefulWidget {
  const SellerActiveOrderDetails({super.key});

  @override
  State<SellerActiveOrderDetails> createState() =>
      _SellerActiveOrderDetailsState();
}

class _SellerActiveOrderDetailsState extends State<SellerActiveOrderDetails> {
  final ordercontroller = Get.put(OrderController(orderRepo: Get.find()));
  String? selectedoption;

  final List<Map<String, dynamic>> options = [
    {
      "id": "3",
      "status": "Completed",
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customappbar(title: 'Order Details'),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: SingleChildScrollView(child: Obx(() {
              if (ordercontroller.getorderdetailsbyidloading.value) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 35.h),
                  child: Center(
                    child: customcircularprogress(),
                  ),
                );
              } else if (ordercontroller.getorderdetailsbyid.value == null ||
                  ordercontroller.getorderdetailsbyid.value?.data == null) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 35.h),
                  child: Center(
                    child: nodatatext("No Order Details"),
                  ),
                );
              } else {
                // dynamic ordertotal = int.tryParse(ordercontroller.getorderdetailsbyid.value?.data?.subtotalPrice) ?? 0 + int.tryParse(ordercontroller.getorderdetailsbyid.value?.data?.shippingCost ) ?? 0;
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
                                    ordercontroller.getorderdetailsbyid.value
                                            ?.data?.user?.name ??
                                        "",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 15.sp,
                                        color: const Color(0xff757474)),
                                  ),
                                  Text(
                                    'ORDER # ${ordercontroller.getorderdetailsbyid.value?.data?.orderid ?? ""}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.sp,
                                        color: const Color(0xff2E3192)),
                                  ),
                                ],
                              ),
                              Text(
                                ordercontroller.getorderdetailsbyid.value?.data
                                        ?.user?.address ??
                                    "",
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14.sp,
                                    color: const Color(0xff757474)),
                              ),
                              Text(
                                '${ordercontroller.getorderdetailsbyid.value?.data?.user?.phoneCode ?? ""}-${ordercontroller.getorderdetailsbyid.value?.data?.user?.phoneNumber ?? ""}',
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
                            ordercontroller.updateorderstatusloading.value
                                ? SizedBox(
                                    height: 3.h,
                                    width: 6.w,
                                    child: customcircularprogress(),
                                  )
                                : SizedBox(
                                    height: 5.h,
                                    width: 35.w,
                                    child: Center(
                                        child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        hintText: "Accepted",
                                        hintStyle: TextStyle(
                                          fontSize: 16.sp,
                                          color: Color(0xff2E3192),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                              color: Color(0xff2E3192)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                              color: Color(0xff2E3192)),
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(left: 8, right: 2),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      value: selectedoption,
                                      onChanged: (newValue) {
                                        selectedoption = newValue!;
                                        ordercontroller.updateOrderStatus(
                                            id: ordercontroller
                                                    .getorderdetailsbyid
                                                    .value
                                                    ?.data
                                                    ?.id ??
                                                0,
                                            status: newValue.toString());
                                      },
                                      items: options.map((statusoptions) {
                                        return DropdownMenuItem<String>(
                                          value: statusoptions["id"],
                                          child: Text(
                                            statusoptions["status"],
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Color(0xff2E3192),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      icon: CircleAvatar(
                                        child: Image.asset(
                                            "assets/images/arrowdropdown.png"),
                                      ),
                                    )),
                                  ),
                            // CustomElevetedButton(
                            //     ontap: () {},
                            //     height: 3.5.h,
                            //     width: 32.w,
                            //     fontSize: 14.sp,
                            //     borderradius: 15,
                            //     color: const Color(0xff2E3192),
                            //     buttonName: ordercontroller
                            //             .getorderdetailsbyid
                            //             .value
                            //             ?.data
                            //             ?.orderProductIds
                            //             ?.first
                            //             .status ??
                            //         "")
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
                              itemCount: ordercontroller.getorderdetailsbyid
                                  .value?.data?.orderProductIds?.length,
                              itemBuilder: (context, index) {
                                final detailsdata = ordercontroller
                                    .getorderdetailsbyid
                                    .value
                                    ?.data
                                    ?.orderProductIds?[index];
                                return Padding(
                                  padding:  EdgeInsets.only(bottom: 2.h),
                                  child: SizedBox(
                                    height: 13.h,
                                    width: Get.width,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 13.h,
                                          width: 33.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Color(0xff1375EA)
                                                      .withOpacity(0.25)),
                                              borderRadius:
                                                  BorderRadius.circular(15.62),
                                              image: DecorationImage(
                                                  image: NetworkImage(detailsdata
                                                              ?.product?.media ==
                                                          null
                                                      ? AppConstants.noimage
                                                      : detailsdata
                                                              ?.product
                                                              ?.media
                                                              ?.first
                                                              .originalUrl ??
                                                          AppConstants.noimage),
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
                                              Text(
                                                detailsdata?.product?.title ?? "",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 15.sp),
                                              ),
                                              Text(
                                                detailsdata?.product
                                                                ?.discountPrice ==
                                                            null ||
                                                        detailsdata?.product
                                                                ?.discountPrice ==
                                                            "0"
                                                    ? '${currencytext()}${detailsdata?.product?.price ?? ""}'
                                                    : '${currencytext()}${detailsdata?.product?.discountPrice ?? ""}',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 17.sp,
                                                    color:
                                                        const Color(0xff2E3192)),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    detailsdata?.product
                                                                ?.discountPrice ==
                                                            null
                                                        ? 'Save ${currencytext()} 0 ( ${detailsdata?.product?.disPercentage ?? ""}% off )'
                                                        : 'Save ${currencytext()} ${'${((double.parse(detailsdata?.product?.price.toString() ?? "0.00")) - (double.parse(detailsdata?.product?.discountPrice.toString() ?? "0.00"))).toStringAsFixed(2)}'} ( ${detailsdata?.product?.disPercentage.toString() ?? ""}% off )',
                                                    style: TextStyle(
                                                        fontSize: 12.sp,
                                                        color: Color(0xffEF0D0D)),
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
                                                        color: Color(0xff757474)),
                                                  ),
                                                  Container(
                                                    color:
                                                        const Color(0xff2E3192),
                                                    child: Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                                2),
                                                        child: Text(
                                                          detailsdata?.quantity
                                                                  .toString() ??
                                                              "",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight.w600,
                                                              fontSize: 13.sp,
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
                                                child: SingleChildScrollView(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  child: Row(children: [
                                                    ListView.builder(
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        scrollDirection:
                                                            Axis.horizontal,
                                                        shrinkWrap: true,
                                                        itemCount: detailsdata
                                                            ?.orderAttribute
                                                            ?.length,
                                                        itemBuilder:
                                                            (context, index) {
                                                          final attributedata =
                                                              detailsdata
                                                                      ?.orderAttribute?[
                                                                  index];
                                                          return Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 1.w),
                                                            child: Text(
                                                              "${attributedata
                                                                      ?.attribute
                                                                      ?.name ??
                                                                  ""}, ",
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
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              }),
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
                                          'Subtotal (${ordercontroller.getorderdetailsbyid.value?.data?.orderProductIds?.length} items)',
                                      amount:
                                          '${currencytext()}${ordercontroller.getorderdetailsbyid.value?.data?.subtotalPrice ?? ""}'),
                                  customamountrow(
                                      title: 'Shipping',
                                      amount:
                                          '${currencytext()}${ordercontroller.getorderdetailsbyid.value?.data?.shippingCost ?? ""}'),
                                  customamountrow(
                                      title: 'Discount',
                                      amount:
                                          '${currencytext()}${ordercontroller.getorderdetailsbyid.value?.data?.discount ?? ""}'),
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
                                        '${currencytext()}${((double.parse(ordercontroller.getorderdetailsbyid.value?.data?.totalPrice.toString() ?? "0.00")) + (double.parse(ordercontroller.getorderdetailsbyid.value?.data?.shippingCost.toString() ?? "0.00"))).toStringAsFixed(2)}',
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
              ordercontroller
                                      .getorderdetailsbyid.value?.data?.note ==
                                  null || ordercontroller
                                      .getorderdetailsbyid.value!.data!.note!.isEmpty  ? const SizedBox() :              Text(
                            'Note',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 16.sp),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                 ordercontroller
                                      .getorderdetailsbyid.value?.data?.note ==
                                  null || ordercontroller
                                      .getorderdetailsbyid.value!.data!.note!.isEmpty  ? const SizedBox() :            Container(
                            decoration: BoxDecoration(
                                color: const Color(0xffF5F5F5),
                                borderRadius: BorderRadius.circular(20.79)),
                            width: Get.width,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 15),
                              child: Text(
                                ordercontroller.getorderdetailsbyid.value?.data
                                        ?.note ??
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
