
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/productcontroller.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class InActiveProducts extends StatefulWidget {
  const InActiveProducts({super.key});

  @override
  State<InActiveProducts> createState() => _InActiveProductsState();
}

class _InActiveProductsState extends State<InActiveProducts> {
  final productcontroller = Get.put(ProductController(productRepo: Get.find()));
  ScrollController scrollcontroller = ScrollController();
  @override
  void initState() {
    super.initState();
     productcontroller.inactiveproductpage.value = 1;
    productcontroller.getInActiveProducts();
    scrollcontroller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollcontroller.offset >= scrollcontroller.position.maxScrollExtent &&
        !scrollcontroller.position.outOfRange) {
      productcontroller.getInActiveProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() => productcontroller.getinactiveproductsloading.value
            ? Center(
                child: customcircularprogress(),
              )
            : productcontroller.getinactiveproducts.value == null ||
                    productcontroller
                        .getinactiveproducts.value!.data!.products!.isEmpty
                ? const Center(child: Text("No InActive Products"))
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                            controller: scrollcontroller,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productcontroller.getinactiveproducts
                                    .value?.data?.products?.length ??
                                0,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 2.w,
                                    childAspectRatio: 3.4.sp,
                                    mainAxisSpacing: 2.h,
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              final inactiveproducts = productcontroller
                                  .getinactiveproducts
                                  .value
                                  ?.data
                                  ?.products?[index];
                              return GestureDetector(
                                onTap: () {
                                  productcontroller.getProductPreviewbyId(
                                      inactiveproducts?.guid ?? "");
                                  Get.toNamed(
                                      RouteConstants.productpreviewscreen);
                                },
                                child: SizedBox(
                                  height: 29.h,
                                  width: 30.w,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            height: 15.h,
                                            width: 30.w,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                border: Border.all(
                                                    color:
                                                        const Color(0xff000000)
                                                            .withOpacity(0.2))),
                                            child: Center(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                                child: Image.network(
                                                  inactiveproducts?.media
                                                              ?.isEmpty ??
                                                          false
                                                      ? AppConstants.noimage
                                                      : inactiveproducts
                                                              ?.media
                                                              ?.first
                                                              .originalUrl ??
                                                          AppConstants.noimage,
                                                  height: 15.h,
                                                  width: 30.w,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                              top: 5,
                                              right: 5,
                                              child: GestureDetector(
                                                onTap: () {
                                                     productcontroller.getProductPreviewbyId(
                                      inactiveproducts?.guid.toString() ?? "");
                                                  Get.toNamed(
                                                      RouteConstants.updatestepper);
                                                },
                                                child: CircleAvatar(
                                                    radius: 14.sp,
                                                    backgroundColor:
                                                        const Color(0xffEEEAEA),
                                                    child: Center(
                                                        child: Icon(
                                                      Icons.edit,
                                                      size: 17.sp,
                                                      color: const Color(
                                                          0xff484BA0),
                                                    ))),
                                              )),
                                        ],
                                      ),
                                      Text(
                                        inactiveproducts?.title.toString() ??
                                            "",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              inactiveproducts?.discountPrice ==
                                                      "0"
                                                  ? "\$${inactiveproducts?.price.toString() ?? ""}"
                                                  : "\$${inactiveproducts?.discountPrice.toString() ?? ""}",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color(0xff2E3192),
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            width: 0.5.w,
                                          ),
                                          Text(
                                            inactiveproducts?.discountPrice !=
                                                    "0"
                                                ? "\$${inactiveproducts?.price.toString() ?? ""}"
                                                : "",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Color(0xff2E3192),
                                                decorationColor:
                                                    Color(0xff2E3192),
                                                decoration:
                                                    TextDecoration.lineThrough),
                                          )
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: inactiveproducts
                                                    ?.ratingAsDouble ??
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
                                              inactiveproducts?.ratingCount
                                                      .toString() ??
                                                  "",
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                              )),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                      productcontroller.getinactiveproductsreloading.value
                          ? Center(
                              child: customcircularprogress(),
                            )
                          : SizedBox()
                    ],
                  )));
  }
}
