import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/customcomponents/customelevatedbutton.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/customelevatedbutton.dart';

class InventorySeller extends StatefulWidget {
  const InventorySeller({super.key});

  @override
  State<InventorySeller> createState() => _InventorySellerState();
}

class _InventorySellerState extends State<InventorySeller>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
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
        Card(
          elevation: 1,
          child: Container(
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
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "SMS Store",
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Text('00 Followers')
                        ],
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
                                        color: const Color(0xffFFAD33),
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
                            width: 10.w,
                          ),
                          Text('01/02/2024')
                        ],
                      ),
                    ],
                  ),
                ],
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
              Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 10.h,
                    width: 40.w,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Text(
                          'Products',
                          style: TextStyle(fontSize: 16),
                        ),
                        Text(
                          '70',
                          style: TextStyle(fontSize: 30),
                        )
                      ],
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
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => ReportSeller()),
                        // );
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
