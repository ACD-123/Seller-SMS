import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/productcontroller.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/customelevatedbutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class InventorySeller extends StatefulWidget {
  const InventorySeller({super.key});

  @override
  State<InventorySeller> createState() => _InventorySellerState();
}

class _InventorySellerState extends State<InventorySeller>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final productcontroller = Get.put(ProductController(productRepo: Get.find()));
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));

  @override
  void initState() {
    super.initState();
    productcontroller.getsellerCategoriesList();
    productcontroller.getBrandsList();
    storecontroller.getSellerShopProfileData();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> wishlistproductgridlist = [
    {
      "name": "Shoes",
      "isbanner": true,
      "istoprated": "50% OFF",
      "image": 'assets/images/homeexploreproduct4.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gamepad",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/homeexploreproduct5.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Jacket",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/homeexploreproduct6.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Shoes",
      "isbanner": false,
      "istoprated": "50% OFF",
      "image": 'assets/images/homeexploreproduct4.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gamepad",
      "isbanner": false,
      "istoprated": "50% OFF",
      "image": 'assets/images/homeexploreproduct5.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Jacket",
      "isbanner": false,
      "istoprated": "50% OFF",
      "image": 'assets/images/homeexploreproduct6.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Shoes",
      "isbanner": false,
      "istoprated": "50% OFF",
      "image": 'assets/images/homeexploreproduct4.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gamepad",
      "isbanner": false,
      "istoprated": "50% OFF",
      "image": 'assets/images/homeexploreproduct5.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Jacket",
      "isbanner": true,
      "istoprated": "Top Rated",
      "image": 'assets/images/homeexploreproduct6.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Shoes",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/homeexploreproduct4.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gamepad",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/homeexploreproduct5.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Jacket",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/homeexploreproduct6.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          "Inventory",
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderContent(),
            TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: "Active Products"),
                Tab(text: "Inactive Products"),
              ],
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildActiveProducts(),
                  _buildInactiveProducts(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderContent() {
    return Column(
      children: [
        Obx(
          () => storecontroller.getsellershopprofiledataloading.value
              ? Center(
                  child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.h),
                  child: SizedBox(
                    height: 3.h,
                    width: 5.w,
                    child: customcircularprogress(),
                  ),
                ))
              : storecontroller.getsellershopprofiledata.value == null
                  ? Padding(
                      padding: EdgeInsets.symmetric(horizontal: 1.h),
                      child: const Center(child: Text("No Shop Data")),
                    )
                  : Card(
                      elevation: 1,
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 3),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  storecontroller
                                          .getsellershopprofiledata
                                          .value!
                                          .data!
                                          .sellerData!
                                          .mainImage!
                                          .isEmpty
                                      ? AppConstants.noimage
                                      : storecontroller
                                              .getsellershopprofiledata
                                              .value
                                              ?.data
                                              ?.sellerData
                                              ?.mainImage ??
                                          AppConstants.noimage,
                                  width: 23.w,
                                  height: 7.h,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          storecontroller
                                                  .getsellershopprofiledata
                                                  .value
                                                  ?.data
                                                  ?.sellerData
                                                  ?.shopName ??
                                              "",
                                          style: const TextStyle(
                                            fontSize: 14,
                                          ),
                                        ),
                                        Text(
                                          'Created On',
                                          style: TextStyle(
                                              fontSize: 14.sp,
                                              color: Color(0xff838589)),
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: 1,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            RatingBarIndicator(
                                              rating: storecontroller
                                                      .getsellershopprofiledata
                                                      .value
                                                      ?.data
                                                      ?.sellerData
                                                      ?.ratingAsDouble ??
                                                  0.0,
                                              itemBuilder: (context, index) =>
                                                  Icon(
                                                Icons.star,
                                                color: Color(0xffFFAD33),
                                              ),
                                              itemCount: 5,
                                              itemSize: 16.sp,
                                              direction: Axis.horizontal,
                                            ),
                                            Text(
                                                "(${storecontroller.getsellershopprofiledata.value?.data?.sellerData?.ratingCount.toString() ?? ""})",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                )),
                                          ],
                                        ),
                                        Text(storecontroller
                                                .getsellershopprofiledata
                                                .value
                                                ?.data
                                                ?.sellerData
                                                ?.joined
                                                .toString() ??
                                            "")
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Row(
            children: [
              Obx(
                () => storecontroller.getsellershopprofiledataloading.value
                    ? const SizedBox()
                    : Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 10.h,
                            width: 40.w,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Products',
                                  style: TextStyle(fontSize: 16),
                                ),
                                Text(
                                  storecontroller
                                              .getsellershopprofiledata.value ==
                                          null
                                      ? "No Products"
                                      : storecontroller
                                              .getsellershopprofiledata
                                              .value
                                              ?.data
                                              ?.sellerData
                                              ?.productCount
                                              .toString() ??
                                          "",
                                  style: TextStyle(fontSize: 20.sp),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 17.0, right: 2.0),
                child: Row(
                  children: [
                    ElevetedButton(
                      color: Color(0xff2E3192),
                      buttonName: 'Add Products',
                      textColor: Colors.white,
                      ontap: () {
                        Get.toNamed(RouteConstants.stepper);
                      },
                      fontSize: 14,
                      width: MediaQuery.of(context).size.width * 0.45,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInactiveProducts() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: wishlistproductgridlist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15,
              childAspectRatio: 0.68,
              mainAxisSpacing: 20,
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            final wishlistproductsdata = wishlistproductgridlist[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteConstants.productdetailscreen);
              },
              child: Container(
                height: 29.h,
                width: 30.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteConstants.stepper);
                              },
                              child: CircleAvatar(
                                  radius: 14.sp,
                                  backgroundColor: const Color(0xffEEEAEA),
                                  child: Center(
                                      child: Icon(
                                    Icons.edit,
                                    size: 17.sp,
                                    color: const Color(0xff484BA0),
                                  ))),
                            )),
                        Container(
                          height: 15.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xff000000)
                                      .withOpacity(0.2))),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                wishlistproductsdata['image'],
                                height: 15.h,
                                width: 30.w,
                                // fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      wishlistproductsdata['name'],
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(wishlistproductsdata['price'],
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xff2E3192),
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 0.5.w,
                        ),
                        Text(wishlistproductsdata['discountprice'],
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xff2E3192),
                                decorationColor: Color(0xff2E3192),
                                decoration: TextDecoration.lineThrough))
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star_purple500_sharp,
                                      color: const Color(0xffFFAD33),
                                      size: 13.sp,
                                    ))),
                        SizedBox(
                          width: 0.5.w,
                        ),
                        Text(wishlistproductsdata['ratings'],
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
    );
  }

  Widget _buildActiveProducts() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
          // physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: wishlistproductgridlist.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15,
              childAspectRatio: 0.62,
              mainAxisSpacing: 20,
              crossAxisCount: 3),
          itemBuilder: (context, index) {
            final wishlistproductsdata = wishlistproductgridlist[index];
            return GestureDetector(
              onTap: () {
                Get.toNamed(RouteConstants.productdetailscreen);
              },
              child: Container(
                height: 29.h,
                width: 30.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 15.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xff000000)
                                      .withOpacity(0.2))),
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                wishlistproductsdata['image'],
                                height: 15.h,
                                width: 30.w,
                                // fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                            top: 5,
                            right: 5,
                            child: GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteConstants.stepper);
                              },
                              child: CircleAvatar(
                                  radius: 14.sp,
                                  backgroundColor: const Color(0xffEEEAEA),
                                  child: Center(
                                      child: Icon(
                                    Icons.edit,
                                    size: 17.sp,
                                    color: const Color(0xff484BA0),
                                  ))),
                            )),
                      ],
                    ),
                    Text(
                      wishlistproductsdata['name'],
                      style: TextStyle(
                          fontSize: 13.sp, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                        Text(wishlistproductsdata['price'],
                            style: TextStyle(
                                fontSize: 14.sp,
                                color: Color(0xff2E3192),
                                fontWeight: FontWeight.w500)),
                        SizedBox(
                          width: 0.5.w,
                        ),
                        Text(wishlistproductsdata['discountprice'],
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xff2E3192),
                                decorationColor: Color(0xff2E3192),
                                decoration: TextDecoration.lineThrough))
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                            children: List.generate(
                                5,
                                (index) => Icon(
                                      Icons.star_purple500_sharp,
                                      color: const Color(0xffFFAD33),
                                      size: 13.sp,
                                    ))),
                        SizedBox(
                          width: 0.5.w,
                        ),
                        Text(wishlistproductsdata['ratings'],
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
    );
  }
}
