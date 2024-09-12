import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/productcontroller.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/capitalword.dart';
import 'package:smsseller/customcomponents/currencytext.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class ProductPreviewScreen extends StatefulWidget {
  const ProductPreviewScreen({super.key});

  @override
  State<ProductPreviewScreen> createState() => _ProductPreviewScreenState();
}

class _ProductPreviewScreenState extends State<ProductPreviewScreen> {
  final productcontroller = Get.put(ProductController(productRepo: Get.find()));
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  ScrollController scrollcontroller = ScrollController();
final String guid = Get.arguments as String;
  String? selectedfilteroption;

  final List<Map<String, dynamic>> filteroptions = [
    {
      "id": "all",
      "status": "All",
    },
    {
      "id": "1",
      "status": "One Star",
    },
    {
      "id": "2",
      "status": "Two Star",
    },
    {
      "id": "3",
      "status": "Three Star",
    },
    {
      "id": "4",
      "status": "Four Star",
    },
    {
      "id": "5",
      "status": "Five Star",
    },
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     scrollcontroller.addListener(_scrollListener);
  }
void _scrollListener() {
    if (scrollcontroller.offset >= scrollcontroller.position.maxScrollExtent &&
        !scrollcontroller.position.outOfRange) {
      productcontroller.getProductWiseFeedbacks(guid: guid, filter: productcontroller.productwisefiltervalue.value.toString());
    }
  }
@override
  void dispose() {
    productcontroller.productwisefiltervalue.value = '';
    scrollcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollcontroller,
            child: Obx(
          () => productcontroller.getproductpreviewbyidloading.value
              ? Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.h),
                  child: Center(
                    child: customcircularprogress(),
                  ),
                )
              : productcontroller.getproductpreviewbyid.value == null ||
                      productcontroller.getproductpreviewbyid.value?.data ==
                          null
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 40.h),
                      child: Center(
                          child: Text(
                        "No Product Details",
                        style: TextStyle(fontSize: 15.sp),
                      )),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            ImageSlideshow(
                              width: double.infinity,
                              height: 39.h,
                              indicatorColor: Color(0xff2E3192),
                              indicatorBackgroundColor: Color(0xffFFFFFF),
                              children: productcontroller.getproductpreviewbyid
                                          .value?.data?.media?.isEmpty ??
                                      true
                                  ? [
                                      Image.network(
                                        AppConstants.noimage,
                                        fit: BoxFit.fill,
                                      ),
                                    ]
                                  : productcontroller
                                      .getproductpreviewbyid.value!.data!.media!
                                      .map((image) {
                                      return Image.network(
                                        image.originalUrl ??
                                            AppConstants.noimage,
                                        fit: BoxFit.fill,
                                      );
                                    }).toList(),
                            ),
                            Positioned(
                              top: 23,
                              left: 10,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 8.w,
                                  height: 4.h,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 0,
                                      padding: EdgeInsets.zero,
                                      backgroundColor: const Color(0xffEEEAEA),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(9.79),
                                      ),
                                    ),
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Icon(
                                      Icons.arrow_back_ios_new_sharp,
                                      size: 17.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, bottom: 2, right: 16, left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                toCamelCase(productcontroller
                                        .getproductpreviewbyid
                                        .value
                                        ?.data
                                        ?.title ??
                                    ""),
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                toCamelCase(productcontroller
                                        .getproductpreviewbyid
                                        .value
                                        ?.data
                                        ?.description ??
                                    ""),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                                // maxLines: 2,
                                // overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text(
                                    productcontroller.getproductpreviewbyid
                                                .value?.data?.discountPrice ==
                                            "0"
                                        ? "${currencytext()}${productcontroller.getproductpreviewbyid.value?.data?.price ?? ""}"
                                        : "${currencytext()}${productcontroller.getproductpreviewbyid.value?.data?.discountPrice ?? ""}",
                                    style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff2E3192)),
                                  ),
                                  SizedBox(
                                    width: 1.w,
                                  ),
                                  Text(
                                    productcontroller.getproductpreviewbyid
                                                .value?.data?.discountPrice !=
                                            "0"
                                        ? "${currencytext()}${productcontroller.getproductpreviewbyid.value?.data?.price ?? ""}"
                                        : "",
                                    style: TextStyle(
                                        fontSize: 15.sp,
                                        decoration: TextDecoration.lineThrough,
                                        color: Color(0xff2E3192)),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Row(
                                  children: [
                                    RatingBarIndicator(
                                      rating: productcontroller
                                              .getproductpreviewbyid.value?.data
                                              ?.ratingasdouble() ??
                                          0.0,
                                      itemBuilder: (context, index) =>
                                          const Icon(
                                        Icons.star,
                                        color: Color(0xffFFAD33),
                                      ),
                                      itemCount: 5,
                                      itemSize: 16.sp,
                                      direction: Axis.horizontal,
                                    ),
                                    SizedBox(
                                      width: 0.5.w,
                                    ),
                                    Text(
                                        "(${productcontroller.getproductpreviewbyid.value?.data?.ratingCount})",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        )),
                                  ],
                                ),
                              ),
                              Divider(),
                              Text(
                                "Product Details",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              productdescriptiondata(
                                  "Brand",
                                  toCamelCase(productcontroller
                                          .getproductpreviewbyid
                                          .value
                                          ?.data
                                          ?.brand
                                          ?.name ??
                                      "")),
                              SizedBox(
                                height: 1.h,
                              ),
                              productdescriptiondata(
                                  "Category",
                                  toCamelCase(productcontroller
                                          .getproductpreviewbyid
                                          .value
                                          ?.data
                                          ?.category
                                          ?.name ??
                                      "")),
                              SizedBox(
                                height: 1.h,
                              ),
                              productdescriptiondata(
                                  "Stock",
                                  productcontroller.getproductpreviewbyid.value
                                          ?.data?.stock
                                          .toString() ??
                                      ""),
                              SizedBox(
                                height: 1.h,
                              ),
                              ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: productcontroller
                                          .getproductpreviewbyid
                                          .value
                                          ?.data
                                          ?.newattributes
                                          ?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    final attributedata = productcontroller
                                        .getproductpreviewbyid
                                        .value
                                        ?.data
                                        ?.newattributes?[index];
                                    final values = attributedata?.value
                                            ?.map((attr) =>
                                                toCamelCase(attr.name ?? ""))
                                            .toList() ??
                                        [];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 1.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            toCamelCase(
                                                attributedata?.key ?? ""),
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w400,
                                              color: Color(0xff929292),
                                            ),
                                          ),
                                          const Spacer(),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.topRight,
                                              child: Text(
                                                values.join(', '),
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff929292),
                                                ),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                              const Divider(),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Product Reviews",
                                    style: TextStyle(
                                        fontSize: 17.sp,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 4.h,
                                    width: 33.w,
                                    child: Center(
                                        child: DropdownButtonFormField<String>(
                                      decoration: InputDecoration(
                                        hintText: "All",
                                        hintStyle: TextStyle(
                                          fontSize: 16.sp,
                                          color: Color(0xff929292),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                              color: Color(0xffDBDBDB)),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          borderSide: BorderSide(
                                              color: Color(0xffDBDBDB)),
                                        ),
                                        contentPadding:
                                            EdgeInsets.only(left: 8, right: 2),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                        ),
                                      ),
                                      value: selectedfilteroption,
                                      onChanged: (newValue) {
                                        selectedfilteroption = newValue!;
                                        productcontroller
                                            .productwisefeedbackpage.value = 1;
                                        productcontroller
                                            .getProductWiseFeedbacks(
                                                guid: productcontroller
                                                        .getproductpreviewbyid
                                                        .value
                                                        ?.data
                                                        ?.guid
                                                        .toString() ??
                                                    "",
                                                filter: newValue);
                                      },
                                      items: filteroptions.map((statusoptions) {
                                        return DropdownMenuItem<String>(
                                          value: statusoptions["id"],
                                          child: Text(
                                            statusoptions["status"],
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: Color(0xff929292),
                                            ),
                                          ),
                                        );
                                      }).toList(),
                                      icon: CircleAvatar(
                                        radius: 18.sp,
                                        child: Image.asset(
                                          "assets/images/arrowdropdown.png",
                                          height: 0.7.h,
                                          width: 2.w,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    )),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              productcontroller
                                      .getproductwisefeedbacksloading.value
                                  ? Center(
                                      child: SizedBox(
                                        height: 3.h,
                                        width: 5.5.w,
                                        child: customcircularprogress(),
                                      ),
                                    )
                                  : productcontroller.getproductwisefeedbacks
                                                  .value ==
                                              null ||
                                          productcontroller
                                              .getproductwisefeedbacks
                                              .value!
                                              .data!
                                              .feedback!
                                              .isEmpty
                                      ? Center(
                                          child: nodatatext("No Feedbacks"),
                                        )
                                      : ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: productcontroller
                                              .getproductwisefeedbacks
                                              .value
                                              ?.data
                                              ?.feedback
                                              ?.length,
                                          itemBuilder: (context, index) {
                                            final productfeedback =
                                                productcontroller
                                                    .getproductwisefeedbacks
                                                    .value
                                                    ?.data
                                                    ?.feedback?[index];
                                            return Column(
                                              children: [
                                                Card(
                                                  color: Colors.white,
                                                  child: SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(1.h),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              CircleAvatar(
                                                                backgroundImage: NetworkImage(productfeedback
                                                                            ?.user
                                                                            ?.media
                                                                            ?.isEmpty ??
                                                                        true
                                                                    ? AppConstants
                                                                        .noimage
                                                                    : productfeedback
                                                                            ?.user
                                                                            ?.media
                                                                            ?.first
                                                                            .originalUrl ??
                                                                        AppConstants
                                                                            .noimage),
                                                                radius: 20.sp,
                                                              ),
                                                              SizedBox(
                                                                width: 1.w,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      SizedBox(
                                                                        width:
                                                                            28.w,
                                                                        child:
                                                                            Text(
                                                                          toCamelCase(productfeedback?.user?.name ??
                                                                              ""),
                                                                          style:
                                                                              TextStyle(fontSize: 15.sp),
                                                                          maxLines:
                                                                              2,
                                                                          overflow:
                                                                              TextOverflow.ellipsis,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width: MediaQuery.of(context).size.width *
                                                                            0.1,
                                                                      ),
                                                                      Text(
                                                                        toCamelCase(productfeedback?.date ??
                                                                            ""),
                                                                        style: TextStyle(
                                                                            fontSize:
                                                                                16.sp),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  RatingBarIndicator(
                                                                    rating:
                                                                        productfeedback?.ratingAsDouble ??
                                                                            0.0,
                                                                    itemBuilder:
                                                                        (context,
                                                                                index) =>
                                                                            Icon(
                                                                      Icons
                                                                          .star,
                                                                      size:
                                                                          12.sp,
                                                                      color: const Color(
                                                                          0xffFFAD33),
                                                                    ),
                                                                    itemCount:
                                                                        5,
                                                                    itemSize:
                                                                        16.sp,
                                                                    direction: Axis
                                                                        .horizontal,
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 1.h,
                                                          ),
                                                          Text(
                                                            toCamelCase(
                                                                productfeedback
                                                                        ?.comment ??
                                                                    ""),
                                                            style: TextStyle(
                                                                fontSize:
                                                                    14.sp),
                                                          ),
                                                          const Divider(),
                                                          SizedBox(
                                                            height: 0.5.h,
                                                          ),
                                                          productfeedback
                                                                      ?.sellerComment ==
                                                                  null
                                                              ? Padding(
                                                                  padding: const EdgeInsets
                                                                      .symmetric(
                                                                      vertical:
                                                                          5),
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        productcontroller
                                                                            .productwisereplyfeedbackControllers[index],
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          15.sp,
                                                                      color: Colors
                                                                          .black,
                                                                    ),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      fillColor:
                                                                          const Color(
                                                                              0XFFFFFFFF),
                                                                      enabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color:
                                                                                Color(0xFFDBDBDB),
                                                                            width: 2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      focusedBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide: const BorderSide(
                                                                            color:
                                                                                Color(0xFFDBDBDB),
                                                                            width: 2),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      contentPadding: const EdgeInsets
                                                                          .all(
                                                                          15.0),
                                                                      suffixIcon:
                                                                          InkWell(
                                                                        onTap:
                                                                            () {
                                                                          if (productcontroller.productwisereplyfeedbackControllers[index]?.value.text.isNotEmpty ??
                                                                              true) {
                                                                            storecontroller.replySellerFeeback(
                                                                                id: productfeedback?.id ?? 0,
                                                                                reply: productcontroller.productwisereplyfeedbackControllers[index]?.value.text.toString() ?? "");
                                                                          } else {
                                                                            showErrrorSnackbar(message: "Please Enter Your Comment");
                                                                          }
                                                                        },
                                                                        child: Image
                                                                            .asset(
                                                                          'assets/images/chatmessagefieldicon.png',
                                                                          scale:
                                                                              1.6,
                                                                        ),
                                                                      ),
                                                                      border:
                                                                          OutlineInputBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      hintText:
                                                                          'Reply.....',
                                                                      hintStyle:
                                                                          TextStyle(
                                                                              color: Color(0xFF404040).withOpacity(0.5)),
                                                                    ),
                                                                  ),
                                                                )
                                                              : Align(
                                                                  alignment:
                                                                      Alignment
                                                                          .bottomLeft,
                                                                  child:
                                                                      RichText(
                                                                          text: TextSpan(
                                                                              children: [
                                                                        TextSpan(
                                                                          text:
                                                                              'Replied: ',
                                                                          style: TextStyle(
                                                                              fontSize: 14.sp,
                                                                              fontWeight: FontWeight.bold,
                                                                              color: const Color(0xff2E3192)),
                                                                        ),
                                                                        TextSpan(
                                                                          text: toCamelCase(productfeedback?.sellerComment.toString() ??
                                                                              ""),
                                                                          style: TextStyle(
                                                                              fontWeight: FontWeight.w400,
                                                                              fontSize: 14.sp,
                                                                              color: const Color(0xff000000)),
                                                                        ),
                                                                      ]))),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            );
                                          }),
                              productcontroller
                                      .getproductwisefeedbacksreloading.value
                                  ? Center(
                                      child: customcircularprogress(),
                                    )
                                  : const SizedBox(),
                              SizedBox(
                                height: 5.h,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
        )),
      ),
    );
  }
}

///////product description data
Row productdescriptiondata(String title, String subtitle) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff929292)),
      ),
      Text(
        subtitle,
        style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xff929292)),
      ),
    ],
  );
}
