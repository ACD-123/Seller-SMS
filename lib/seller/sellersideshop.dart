import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/seller/aboutseller.dart';
import 'package:smsseller/seller/feedbacksellerside.dart';
import 'package:smsseller/seller/sellershop.dart';

class SellerSideShop extends StatefulWidget {
  
  @override
  State<SellerSideShop> createState() => _SellerShopState();
}

class _SellerShopState extends State<SellerSideShop> 
    with SingleTickerProviderStateMixin{
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
   late TabController _tabController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     _tabController = TabController(length: 3, vsync: this);
    storecontroller.getSellerShopAbout();
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
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading: Padding(
          padding: const EdgeInsets.only(top: 10.0, right: 12),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/arrowback1.png',
            ),
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0),
          child: Text(
            'Shop Preview',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background image
            Obx(
              () => SizedBox(
                height: MediaQuery.of(context).size.height * 0.26,
                child: Stack(
                  children: [
                    // Background image
                    Container(
                      height: 18.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(storecontroller.getsellershopabout
                                      .value?.data?.coverImage?.isEmpty ??
                                  false
                              ? AppConstants.noimage
                              : storecontroller.getsellershopabout.value?.data
                                      ?.coverImage ??
                                  AppConstants.noimage),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),

                    // Shop Information
                    Positioned(
                      top: 100,
                      left: 10,
                      right: 10,
                      child: Card(
                        elevation: 1,
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 28),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.network(
                                    storecontroller.getsellershopabout.value
                                                ?.data?.mainImage?.isEmpty ??
                                            false
                                        ? AppConstants.noimage
                                        : storecontroller.getsellershopabout
                                                .value?.data?.mainImage ??
                                            AppConstants.noimage,
                                    width: 20.w,
                                    height: 7.h,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 1.h,
                                    ),
                                    SizedBox(
                                      width: 55.w,
                                      child: Text(
                                        storecontroller.getsellershopabout.value
                                                ?.data?.shopName ??
                                            "",
                                        style: TextStyle(
                                          fontSize: 15.sp,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 0.3.h,
                                    ),
                                    Row(
                                      children: [
                                        RatingBarIndicator(
                                          rating: storecontroller
                                                  .getsellershopabout
                                                  .value
                                                  ?.data
                                                  ?.ratingAsDouble() ??
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
                                        SizedBox(
                                          width: 30.w,
                                          child: Text(
                                            '(${storecontroller.getsellershopabout.value?.data?.ratingCount ?? ""})',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 8.w,
                                        ),
                                        // GestureDetector(
                                        //   onTap: () {
                                        //     Navigator.push(
                                        //       context,
                                        //       MaterialPageRoute(
                                        //           builder: (context) =>
                                        //               ReportSeller()),
                                        //     );
                                        //   },
                                        //   child: Container(
                                        //     decoration: BoxDecoration(
                                        //         borderRadius:
                                        //             BorderRadius.circular(10),
                                        //         border: Border.all(
                                        //             color: Color(0xffD16363))),
                                        //     width: 100,
                                        //     height: 30,
                                        //     child: Center(
                                        //         child: Row(
                                        //       mainAxisAlignment:
                                        //           MainAxisAlignment.spaceEvenly,
                                        //       children: [
                                        //         Text(
                                        //           'Report',
                                        //           style: TextStyle(
                                        //               color: Color(0xffD16363)),
                                        //         ),
                                        //         Image.asset(
                                        //             'assets/images/reporticon.png')
                                        //       ],
                                        //     )),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 2.h,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Tabs
             TabBar(
              controller: _tabController,
              tabs: [
                Tab(text: "Shop"),
                Tab(text: "About"),
                Tab(text: "Feedback"),
              ],
            ),
            SizedBox(
              height: 57.h,
              child: TabBarView(
                controller: _tabController,
                children:  [
                  SellerShop(),
                        AboutSeller(),
                        SellerFeedback(),
                ],
              ),
            ),
           
          ],
        ),
      ),
    );
  }
}
