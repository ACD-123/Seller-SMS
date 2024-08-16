import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/custombutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/models/selectcategory_model.dart';

class SellerSetupShop extends StatefulWidget {
  const SellerSetupShop({super.key});

  @override
  State<SellerSetupShop> createState() => _SellerSetupShopState();
}

class _SellerSetupShopState extends State<SellerSetupShop> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: 'Setup Shop'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    onTap: () {
                      storecontroller.uploadsellersetupshopcoverImage(context);
                    },
                    child: Obx(
                      () => Container(
                        height: 14.h,
                        width: Get.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7.84),
                            border: Border.all(
                              color: Color(0xffD4D4D4),
                            )),
                        child: storecontroller
                                    .sellersetupshopuploadedcoverImage.value ==
                                null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    'assets/images/plusicon.png',
                                    height: 7.h,
                                  ),
                                  Text(
                                    'Upload Cover pic',
                                    style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Color(0xff878787),
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: Image.file(
                                  File(storecontroller
                                      .sellersetupshopuploadedcoverImage
                                      .value!
                                      .path),
                                  fit: BoxFit.fill,
                                )),
                      ),
                    )),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'About your shop',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff878787),
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 14.h,
                  width: Get.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.84),
                      border: Border.all(
                        color: Color(0xffD4D4D4),
                      )),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return "Please Enter About Shop";
                      }
                      return null;
                    },
                    maxLines: 7,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      border: InputBorder.none,
                      hintText: "Write Something...",
                      hintStyle:
                          TextStyle(fontSize: 14.sp, color: Color(0xffD0D0D0)),
                    ),
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Select Categories',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff878787),
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Container(
                  height: 5.h,
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xff1375EA)),
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xffF5F5F5)),
                  child: TextFormField(
                    controller:
                        storecontroller.searchcategorykeycontroller.value,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        'assets/images/homesearchicon.png',
                        scale: 1.5,
                        color: Color(0xff000000),
                      ),
                      contentPadding: const EdgeInsets.only(
                          right: 15, left: 15, top: 10, bottom: 12),
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      hintText: "Search Categories",
                      hintStyle: TextStyle(
                        fontSize: 14.sp,
                      ),
                    ),
                    onSaved: (value) {},
                  ),
                ),
                Obx(() => storecontroller.categoriesSearchbykeyloading.value
                    ? Padding(
                        padding: EdgeInsets.only(top: 1.h),
                        child: Center(
                          child: customcircularprogress(),
                        ),
                      )
                    : storecontroller.categoriesSearchbykey.value == null
                        ? const SizedBox()
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: storecontroller.categoriesSearchbykey
                                .value?.data?.categories?.length,
                            itemBuilder: (context, index) {
                              final categorydata = storecontroller
                                  .categoriesSearchbykey
                                  .value
                                  ?.data
                                  ?.categories?[index];
                              return GestureDetector(
                                onTap: () {
                                  storecontroller.createshopselectedCategories
                                      .add(SelectCategory(
                                          id: categorydata?.id ?? 0,
                                          name: categorydata?.name.toString() ??
                                              "",
                                          image: categorydata?.media?.isEmpty ??
                                                  false
                                              ? AppConstants.noimage
                                              : categorydata
                                                      ?.media?.first.originalUrl
                                                      .toString() ??
                                                  AppConstants.noimage));
                                  storecontroller.createshopselectedCategoryIds
                                      .add(categorydata?.id ?? 0);
                                  storecontroller
                                      .searchcategorykeycontroller.value
                                      .clear();
                                  storecontroller.categoriesSearchbykey.value =
                                      null;
                                },
                                child: ListTile(
                                  title:
                                      Text(categorydata?.name.toString() ?? ""),
                                ),
                              );
                            })),
                SizedBox(
                  height: 2.h,
                ),
                Obx(() => storecontroller.createshopselectedCategories.isEmpty
                    ? SizedBox()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                              height: 7.h,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: storecontroller
                                      .createshopselectedCategories.length,
                                  itemBuilder: (context, index) {
                                    final addcatgeorydata = storecontroller
                                        .createshopselectedCategories[index];

                                    return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Container(
                                                height: 6.h,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.37),
                                                    color: Color(0xffF0EFEF)),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                        child: Image.network(
                                                          addcatgeorydata.image,
                                                          height: 5.h,
                                                          width: 15.w,
                                                          fit: BoxFit.fill,
                                                        )),
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                    Text(
                                                      addcatgeorydata.name,
                                                      style: TextStyle(
                                                          color: const Color(
                                                              0xff484BA0),
                                                          fontSize: 14.sp),
                                                    ),
                                                    SizedBox(
                                                      width: 1.w,
                                                    ),
                                                  ],
                                                )),
                                            Positioned(
                                              right: -5,
                                              top: -0,
                                              child: GestureDetector(
                                                onTap: () {
                                                  storecontroller
                                                      .sellersetupshopremoveCategory(
                                                          index);
                                                  storecontroller
                                                      .sellersetupshopremoveCategoryIds(
                                                          index);
                                                },
                                                child: CircleAvatar(
                                                  radius: 11.sp,
                                                  backgroundColor:
                                                      Color(0xff2E3192),
                                                  child: Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 13.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ));
                                  }),
                            )
                          ],
                        ),
                      )),
                SizedBox(
                  height: 1.h,
                ),
                Text(
                  'Add Banner Images',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff878787),
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Obx(() => GestureDetector(
                      onTap: () {
                        storecontroller
                            .uploadsellersetupshopbannerimages(context);
                      },
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            Container(
                                height: 15.h,
                                child: Row(
                                  children: [
                                    Container(
                                      height: 15.h,
                                      width: 40.w,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(7.84),
                                          border: Border.all(
                                            color: Color(0xffD4D4D4),
                                          )),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            'assets/images/imagesicon.png',
                                            height: 3.h,
                                            color: Color(0xff2E3192),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Text(
                                            'Add Images',
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Color(0xffA09696),
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            'Browse',
                                            style: TextStyle(
                                                decoration:
                                                    TextDecoration.underline,
                                                decorationColor:
                                                    Color(0xff2572B9),
                                                fontSize: 14.sp,
                                                color: Color(0xff2572B9),
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    ),
                                    storecontroller
                                            .sellersetupshopuploadedbannerimages
                                            .isEmpty
                                        ? SizedBox()
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            itemCount: storecontroller
                                                .sellersetupshopuploadedbannerimages
                                                .length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index) {
                                              final bannerimages = storecontroller
                                                      .sellersetupshopuploadedbannerimages[
                                                  index];
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 1.w),
                                                child: Stack(
                                                  clipBehavior: Clip.none,
                                                  children: [
                                                    ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(4),
                                                        child: Image.file(
                                                          File(bannerimages
                                                                  ?.path ??
                                                              ""),
                                                          fit: BoxFit.fill,
                                                          width: 40.w,
                                                          height: 15.h,
                                                        )),
                                                    Positioned(
                                                      right: -5,
                                                      top: -0,
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          storecontroller
                                                              .setupshopremovebannerImage(
                                                                  index);
                                                        },
                                                        child: CircleAvatar(
                                                          radius: 13.sp,
                                                          backgroundColor:
                                                              Color(0xff2E3192),
                                                          child: Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 16.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            })
                                  ],
                                )),
                          ],
                        ),
                      ),
                    )),
                SizedBox(
                  height: 4.h,
                ),
                custombutton(
                    hinttext: "Create",
                    ontap: () {
                      if (formKey.currentState!.validate()) {
                        storecontroller.sellersetupshopuploadedbannerimages
                                    .isEmpty ||
                                storecontroller
                                    .createshopselectedCategoryIds.isEmpty ||
                                storecontroller
                                        .sellersetupshopuploadedcoverImage
                                        .value ==
                                    null
                            ? showErrrorSnackbar(
                                message: "Please Fill All Fields")
                            : Get.toNamed(RouteConstants.sellerdashboard);
                      }
                    }),
                SizedBox(
                  height: 2.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
