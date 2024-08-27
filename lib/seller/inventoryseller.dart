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
import 'package:smsseller/seller/activeproducts.dart';
import 'package:smsseller/seller/inactiveproducts.dart';
import 'package:smsseller/seller/outofstockproducts.dart';

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
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
              tabs: const [
                Tab(text: "Active"),
                Tab(text: "Out of Stock"),
                Tab(text: "InActive "),
              ],
            ),
            SizedBox(
              height: 57.h,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  ActiveProducts(),
                  OutofStockProducts(),
                  InActiveProducts()
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
}
