import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:get/get.dart';

import 'package:smsseller/seller/aboutseller.dart';
import 'package:smsseller/seller/feedbacksellerside.dart';
import 'package:smsseller/seller/sellershop.dart';

class SellerSideShop extends StatefulWidget {
  @override
  State<SellerSideShop> createState() => _SellerShopState();
}

class _SellerShopState extends State<SellerSideShop> {
  // final wishlistproductsdata = wishlistproductgridlist[index];
  // final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
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
        actions: [
          GestureDetector(
            onTap: () {
              Share.share("Check out my latest tutorial");
            },
            child: Container(
              height: 15, // Set the desired height here

              child: Image.asset('assets/images/shareicon.png'),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Background image
            Container(
              height: MediaQuery.of(context).size.height * 0.26,
              child: Stack(
                children: [
                  // Background image
                  Container(
                    height: 150,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/sellerbackimg.png"),
                        fit: BoxFit.cover,
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
                              Image.asset(
                                "assets/images/sellerfrontpic.png",
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.03,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // const SizedBox(height: 10),
                                  Text(
                                    "SMS Store",
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1,
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                          children: List.generate(
                                              5,
                                              (index) => Icon(
                                                    Icons.star_purple500_sharp,
                                                    color:
                                                        const Color(0xffFFAD33),
                                                    size: 16.sp,
                                                  ))),
                                      SizedBox(
                                        width: 0.5.w,
                                      ),
                                      Text('(65)',
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                          )),
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
            // Tabs
            DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  TabBar(
                    labelColor: const Color(0xff525c6e),
                    unselectedLabelColor: const Color(0xffacb3bf),
                    indicatorPadding: const EdgeInsets.all(0.0),
                    indicatorWeight: 3.0,
                    labelPadding: const EdgeInsets.only(left: 0.0, right: 0.0),
                    indicator: const ShapeDecoration(
                        shape: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 2,
                            style: BorderStyle.solid,
                          ),
                        ),
                        color: Color(0xff2E3192)),
                    tabs: <Widget>[
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: const Text("Shop"),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: const Text("About"),
                      ),
                      Container(
                        height: 40,
                        alignment: Alignment.center,
                        color: Colors.white,
                        child: const Text("Feedback"),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: TabBarView(
                      children: [
                        SellerShop(),
                        AboutSeller(),
                        SellerFeedback(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
