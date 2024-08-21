import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/productcontroller.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class ProductPreviewScreen extends StatefulWidget {
  const ProductPreviewScreen({super.key});

  @override
  State<ProductPreviewScreen> createState() => _ProductPreviewScreenState();
}

class _ProductPreviewScreenState extends State<ProductPreviewScreen> {
  final productcontroller = Get.put(ProductController(productRepo: Get.find()));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                                productcontroller.getproductpreviewbyid.value
                                        ?.data?.title ??
                                    "",
                                style: TextStyle(
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                productcontroller.getproductpreviewbyid.value
                                        ?.data?.description ??
                                    "",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                children: [
                                  Text(
                                    productcontroller.getproductpreviewbyid
                                                .value?.data?.discountPrice ==
                                            "0"
                                        ? "\$${productcontroller.getproductpreviewbyid.value?.data?.price ?? ""}"
                                        : "\$${productcontroller.getproductpreviewbyid.value?.data?.discountPrice ?? ""}",
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
                                        ? "\$${productcontroller.getproductpreviewbyid.value?.data?.price ?? ""}"
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
                                  productcontroller.getproductpreviewbyid.value
                                          ?.data?.brand?.name ??
                                      ""),
                              SizedBox(
                                height: 1.h,
                              ),
                              productdescriptiondata(
                                  "Category",
                                  productcontroller.getproductpreviewbyid.value
                                          ?.data?.category?.name ??
                                      ""),
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
                                            ?.map((attr) => attr.name ?? "")
                                            .toList() ??
                                        [];
                                    return Padding(
                                      padding: EdgeInsets.only(bottom: 1.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            attributedata?.key ?? "",
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
                                  })
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
