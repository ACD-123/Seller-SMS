import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/productcontroller.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class SellerShop extends StatefulWidget {
  SellerShop({super.key});

  @override
  State<SellerShop> createState() => _SellerShopState();
}

class _SellerShopState extends State<SellerShop> {
  TextEditingController shopproductsearchcontroller = TextEditingController();
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  final productcontroller = Get.put(ProductController(productRepo: Get.find()));
  ScrollController scrollcontroller = ScrollController();

  @override
  void initState() {
    super.initState();
     storecontroller.sellershopproductspage.value = 1;
      WidgetsBinding.instance.addPostFrameCallback((_) {
     storecontroller.getSellerShopProducts();
     });
    scrollcontroller.addListener(() {
      if (scrollcontroller.offset >=
              scrollcontroller.position.maxScrollExtent &&
          !scrollcontroller.position.outOfRange) {
        storecontroller.getSellerShopProducts();
      }
    });
  }
 @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(
          8.0,
        ),
        child: Obx(() => storecontroller.getsellershopproductsloading.value
            ? Center(
                child: customcircularprogress(),
              )
            : storecontroller.getsellersideshopproducts.value == null ||
                    storecontroller.getsellersideshopproducts.value!.data!
                        .products!.isEmpty
                ? Center(child: nodatatext("No Products"),)
                : Column(
                    children: [
                      Expanded(
                        child: GridView.builder(
                          controller: scrollcontroller,
                          physics: const AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: storecontroller.getsellersideshopproducts
                              .value?.data?.products?.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 15,
                                  childAspectRatio: 0.65,
                                  mainAxisSpacing: 20,
                                  crossAxisCount: 3),
                          itemBuilder: (context, index) {
                            final sellershopdata = storecontroller
                                .getsellersideshopproducts
                                .value
                                ?.data
                                ?.products?[index];
                            return GestureDetector(
                              onTap: () {
                                productcontroller.getProductPreviewbyId(
                                    sellershopdata?.guid.toString() ?? "");
                                Get.toNamed(
                                    RouteConstants.productpreviewscreen);
                              },
                              child: SizedBox(
                                height: 29.h,
                                width: 20.w,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 15.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              color: const Color(0xff000000)
                                                  .withOpacity(0.2))),
                                      child: Stack(
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              child: Image.network(
                                                sellershopdata
                                                            ?.media?.isEmpty ??
                                                        false
                                                    ? AppConstants.noimage
                                                    : sellershopdata
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
                                          sellershopdata?.discountPercentage ==
                                                      null ||
                                                  sellershopdata
                                                          ?.discountPercentage ==
                                                      "0"
                                              ? const SizedBox()
                                              : Positioned(
                                                  top: 12,
                                                  left: 0,
                                                  child: Container(
                                                    height: 2.2.h,
                                                    width: 12.w,
                                                    decoration: const BoxDecoration(
                                                        color:
                                                            Color(0xff484BA0),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                                topRight: Radius
                                                                    .circular(
                                                                        4.92),
                                                                bottomRight: Radius
                                                                    .circular(
                                                                        4.92))),
                                                    child: Center(
                                                        child: Text(
                                                      "${sellershopdata?.discountPercentage ?? ""}%",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 11.sp),
                                                    )),
                                                  ),
                                                )
                                        ],
                                      ),
                                    ),
                                    Text(
                                      sellershopdata?.title ?? "",
                                      style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          sellershopdata?.discountPrice == "0"
                                              ? "\$${sellershopdata?.price.toString() ?? ""}"
                                              : "\$${sellershopdata?.discountPrice.toString() ?? ""}",
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: const Color(0xff2E3192),
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          width: 0.5.w,
                                        ),
                                        Text(
                                            sellershopdata?.discountPrice != "0"
                                                ? "\$${sellershopdata?.price.toString() ?? ""}"
                                                : "",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: const Color(0xff2E3192),
                                                decorationColor:
                                                    const Color(0xff2E3192),
                                                decoration:
                                                    TextDecoration.lineThrough))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: sellershopdata
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
                                            sellershopdata?.ratingCount
                                                    .toString() ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      storecontroller.getsellershopproductsreloading.value
                          ? Center(
                              child: customcircularprogress(),
                            )
                          : const SizedBox()
                    ],
                  )));
  }
}
