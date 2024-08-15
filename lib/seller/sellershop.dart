import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/customcomponents/custom_popup_dialogwhite.dart';
import 'package:smsseller/customcomponents/custom_popup_dialogwhite.dart';

class SellerShop extends StatefulWidget {
  SellerShop({super.key});

  @override
  State<SellerShop> createState() => _SellerShopState();
}

class _SellerShopState extends State<SellerShop> {
  TextEditingController shopproductsearchcontroller = TextEditingController();

  void showSuccessDialogAndNavigateToLogin(context) {
    Get.dialog(
      WhiteCustomPopupDialog(
        icon: Icons.check_circle,
        message: 'Shop setup successful',
        // text: 'We Hope You Enjoy Selling On Our Platform',
      ),
    );

    // Delay for 1 second
    Future.delayed(const Duration(seconds: 1), () {
      // Get.back();
      Get.toNamed(RouteConstants.sellerdashboard);
      // Navigate to the new screen
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => Dashboard()),
      // );
    });
  }

  List<Map<String, dynamic>> wishlistproductgridlist = [
    {
      "name": "Shoes",
      "isbanner": true,
      "istoprated": "50% OFF",
      "image": 'assets/images/Copa_Sense 2.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gamepad",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/GP11_PRD3 1.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Jacket",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/img3.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Shoes",
      "isbanner": true,
      "istoprated": "50% OFF",
      "image": 'assets/images/Copa_Sense 2.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gamepad",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/GP11_PRD3 1.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Jacket",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/img3.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Shoes",
      "isbanner": true,
      "istoprated": "50% OFF",
      "image": 'assets/images/Copa_Sense 2.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gamepad",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/GP11_PRD3 1.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Jacket",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/img3.png',
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
      "name": "Shoes",
      "isbanner": true,
      "istoprated": "50% OFF",
      "image": 'assets/images/Copa_Sense 2.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gamepad",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/GP11_PRD3 1.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Jacket",
      "isbanner": false,
      "istoprated": "Top Rated",
      "image": 'assets/images/img3.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.02,
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceAround,
        //   children: [
        //     Container(
        //       decoration: BoxDecoration(
        //           color: Color(0xff1375EA),
        //           borderRadius: BorderRadius.circular(10)),
        //       height: 100,
        //       // width: 50,
        //       width: 150,
        //       child: Column(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Text(
        //               'Active Products',
        //               style: TextStyle(fontSize: 14.0, color: Colors.white),
        //               overflow: TextOverflow.ellipsis,
        //               maxLines: 1,
        //             ),
        //           ),
        //           Text(
        //             '70',
        //             style: TextStyle(fontSize: 24, color: Colors.white),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Container(
        //       decoration: BoxDecoration(
        //           color: Color(0xff1375EA),
        //           borderRadius: BorderRadius.circular(10)),
        //       height: 100,
        //       width: 150,
        //       // width: 50,

        //       child: Column(
        //         children: [
        //           Padding(
        //             padding: const EdgeInsets.all(8.0),
        //             child: Text(
        //               'Active Products',
        //               style: TextStyle(fontSize: 14.0, color: Colors.white),
        //               overflow: TextOverflow.ellipsis,
        //               maxLines: 1,
        //             ),
        //           ),
        //           Text(
        //             '70',
        //             style: TextStyle(fontSize: 24, color: Colors.white),
        //           ),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),

        Padding(
            padding: const EdgeInsets.all(
              8.0,
            ),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
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
                    // Get.toNamed(RouteConstants.productdetailscreen);
                  },
                  child: Container(
                    height: 29.h,
                    width: 20.w,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 15.h,
                          width: 30.w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: const Color(0xff000000)
                                      .withOpacity(0.2))),
                          child: Stack(
                            children: [
                              Center(
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
                              wishlistproductsdata['isbanner'] == true
                                  ? Positioned(
                                      top: 12,
                                      left: 0,
                                      child: Container(
                                        height: 2.2.h,
                                        width: 12.w,
                                        decoration: const BoxDecoration(
                                            color: Color(0xff484BA0),
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(4.92),
                                                bottomRight:
                                                    Radius.circular(4.92))),
                                        child: Center(
                                            child: Text(
                                          wishlistproductsdata['istoprated'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 11.sp),
                                        )),
                                      ),
                                    )
                                  : const SizedBox(),
                              // Adding the heart icon
                              Positioned(
                                top: 8,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      wishlistproductgridlist.removeAt(index);
                                    });
                                  },
                                  child: Icon(
                                    Icons.delete,
                                    color: Color(0xff2E3192),
                                    size: 18.sp,
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.toNamed(RouteConstants.stepper);
                                    },
                                    child: CircleAvatar(
                                        radius: 14.sp,
                                        backgroundColor:
                                            const Color(0xffEEEAEA),
                                        child: Center(
                                            child: Icon(
                                          Icons.edit,
                                          size: 17.sp,
                                          color: const Color(0xff484BA0),
                                        ))),
                                  )),
                            ],
                          ),
                        ),
                        Text(
                          wishlistproductsdata['name'],
                          style: TextStyle(
                              fontSize: 13.sp, fontWeight: FontWeight.w500),
                        ),
                        Row(
                          children: [
                            Text(
                              wishlistproductsdata['price'],
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xff2E3192),
                                  fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              width: 0.5.w,
                            ),
                            Text(wishlistproductsdata['discountprice'],
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xff2E3192),
                                    decorationColor: const Color(0xff2E3192),
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
                        ),
                      ],
                    ),
                  ),
                );
              },
            )),
        // Padding(
        //   padding: const EdgeInsets.only(bottom: 20, left: 10, right: 10),
        //   child: custombutton(
        //       ontap: () {
        //         showSuccessDialogAndNavigateToLogin(context);
        //         Get.toNamed(RouteConstants.sellerdashboard);
        //       },
        //       hinttext: "Finish"),
        // ),
      ],
    ));
  }
}

class ContainerWithContent extends StatefulWidget {
  final String imagePath;
  final String title;
  final String text1;
  final String text2;
  final String text3;

  ContainerWithContent({
    required this.imagePath,
    required this.title,
    required this.text1,
    required this.text2,
    required this.text3,
  });

  @override
  State<ContainerWithContent> createState() => _ContainerWithContentState();
}

class _ContainerWithContentState extends State<ContainerWithContent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Container(
        height: 200,
        width: 150,
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color.fromARGB(255, 245, 238, 238),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                widget.imagePath,
                height: 160,
                width: 180,
                fit: BoxFit.fill,
              ),
            ), // Load your image here
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text(widget.title, style: const TextStyle(fontSize: 10)),
            ),
            // SizedBox(height: MediaQuery.of(context).size.height*0.01,),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.text1,
                    style: const TextStyle(
                        fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(widget.text2, style: const TextStyle(fontSize: 10)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.02,
                  ),
                  // Image.asset('assets/dot.png'),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.01,
                  // ),
                  // Text(widget.text3,
                  //     style: TextStyle(
                  //         fontSize: 10,
                  //         color: Color(
                  //           0xffEF2A2A,
                  //         ),
                  //         fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
