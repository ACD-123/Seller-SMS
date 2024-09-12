import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/capitalword.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class AboutSeller extends StatefulWidget {
  const AboutSeller({super.key});

  @override
  State<AboutSeller> createState() => _AboutSellerState();
}

class _AboutSellerState extends State<AboutSeller> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Obx(
          () => storecontroller.getsellershopaboutloading.value
              ? Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Center(
                    child: customcircularprogress(),
                  ),
                )
              : storecontroller.getsellershopabout.value == null
                  ? Padding(
                      padding: EdgeInsets.only(top: 20.h),
                      child: Center(
                        child: nodatatext("No About Data"),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'About Us',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff2E3192),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteConstants.sellerupdateshop);
                                },
                                child: Row(
                                  children: [
                                    Text(
                                      'Edit Info',
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff2E3192),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 1.w,
                                    ),
                                    Icon(
                                      Icons.edit,
                                      color: Color(0xff2E3192),
                                      size: 15.sp,
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          toCamelCase(storecontroller.getsellershopabout.value?.data
                                  ?.shopDescription ??
                              ""),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Row(
                              //   children: [
                              //     Text(
                              //       'Seller:',
                              //       style: TextStyle(
                              //         fontSize: 14.sp,
                              //       ),
                              //     ),
                              //     SizedBox(
                              //       width: 20.w,
                              //       child: Text(
                              //         storecontroller.getsellershopabout.value
                              //                 ?.data?.shopName ??
                              //             "",
                              //         style: TextStyle(
                              //           fontWeight: FontWeight.bold,
                              //           fontSize: 14.sp,
                              //         ),
                              //         overflow: TextOverflow.ellipsis,
                              //       ),
                              //     )
                              //   ],
                              // ),
                              Row(
                                children: [
                                  Text(
                                    'Joined since: ',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                  Text(
                                    toCamelCase(storecontroller.getsellershopabout.value
                                            ?.data?.joined ??
                                        ""),
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.sp,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Row(
                                  children: [
                                    Text(
                                      'Location: ',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 80.w,
                                      child: Text(
                                        storecontroller.getsellershopabout.value
                                                ?.data?.country ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        const Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2E3192),
                          ),
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                        SizedBox(
                          // height: 40.h,
                          child: GridView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              mainAxisSpacing: 1.h,
                              crossAxisSpacing: 1.w,
                            ),
                            itemCount: storecontroller.getsellershopabout.value
                                ?.data?.category?.length,
                            itemBuilder: (context, index) {
                              final categorydata = storecontroller
                                  .getsellershopabout
                                  .value
                                  ?.data
                                  ?.category?[index];
                              return Container(
                                height: 20.h,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.network(
                                      categorydata?.media?.isEmpty ?? false
                                          ? AppConstants.noimage
                                          : categorydata
                                                  ?.media?.first.originalUrl ??
                                              AppConstants.noimage,
                                      fit: BoxFit.fill,
                                      width: 20.w,
                                      height: 6.h,
                                    ),
                                    SizedBox(height: 1.h),
                                    Text(
                                      toCamelCase(categorydata?.name ?? ""),
                                      style: TextStyle(fontSize: 14.sp),
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        ImageSlideshow(
                          isLoop: true,
                          width: double.infinity,
                          height: 20.h,
                        
                          indicatorColor: const Color(0xff2E3192),
                          indicatorBackgroundColor: Colors.grey,
                          children: storecontroller
                                  .getsellershopabout.value?.data?.banners
                                  ?.map((bannerimage) {
                                return Image.network(
                                  bannerimage,
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                        child:
                                            nodatatext('Image not available'));
                                  },
                                );
                              }).toList() ??
                              [
                                Center(
                                    child: nodatatext('No banners available'))
                              ],
                        ),
                        SizedBox(
                          height: 1.h,
                        ),
                      ],
                    ),
        )),
      );
  }
}
