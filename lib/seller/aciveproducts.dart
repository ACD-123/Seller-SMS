
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/productcontroller.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class ActiveProducts extends StatefulWidget {
  const ActiveProducts({super.key});

  @override
  State<ActiveProducts> createState() => _ActiveProductsState();
}

class _ActiveProductsState extends State<ActiveProducts> {
  final productcontroller = Get.put(ProductController(productRepo: Get.find()));
  ScrollController scrollcontroller = ScrollController();

  @override
  void initState() {
    super.initState();
    productcontroller.page.value = 1;
    productcontroller.getActiveProducts();
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
      productcontroller.getActiveProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Obx(() => productcontroller.getactiveproductsloading.value
            ? Center(
                child: customcircularprogress(),
              )
            : productcontroller.getactiveproducts.value == null ||
                    productcontroller
                        .getactiveproducts.value!.data!.products!.isEmpty
                ? const Center(child: Text("No Active Products"))
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                            controller: scrollcontroller,
                            physics: const AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: productcontroller.getactiveproducts.value
                                    ?.data?.products?.length ??
                                0,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 2.w,
                                    childAspectRatio: 3.4.sp,
                                    mainAxisSpacing: 2.h,
                                    crossAxisCount: 3),
                            itemBuilder: (context, index) {
                              final activeproducts = productcontroller
                                  .getactiveproducts
                                  .value
                                  ?.data
                                  ?.products?[index];
                              return GestureDetector(
                                onTap: () {
                                  productcontroller.getProductPreviewbyId(
                                      activeproducts?.guid.toString() ?? "");
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
                                                  activeproducts?.media
                                                              ?.isEmpty ??
                                                          false
                                                      ? AppConstants.noimage
                                                      : activeproducts
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
                                      activeproducts?.guid.toString() ?? "");
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
                                        activeproducts?.title.toString() ?? "",
                                        style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              activeproducts?.discountPrice ==
                                                      "0"
                                                  ? "\$${activeproducts?.price.toString() ?? ""}"
                                                  : "\$${activeproducts?.discountPrice.toString() ?? ""}",
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Color(0xff2E3192),
                                                  fontWeight: FontWeight.w500)),
                                          SizedBox(
                                            width: 0.5.w,
                                          ),
                                          Text(
                                            activeproducts?.discountPrice != "0"
                                                ? "\$${activeproducts?.price.toString() ?? ""}"
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
                                            rating: activeproducts
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
                                              activeproducts?.ratingCount
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
                      productcontroller.getactiveproductsreloadloading.value
                          ? Center(
                              child: customcircularprogress(),
                            )
                          : SizedBox()
                    ],
                  )));
  }
}
