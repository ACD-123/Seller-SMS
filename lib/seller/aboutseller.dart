import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/custom_popup_dialogwhite.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/customcomponents/custom_popup_dialogwhite.dart';
// import 'package:sms/customcomponents/custombutton.dart';

class AboutSeller extends StatelessWidget {
  const AboutSeller({super.key});

  @override
  Widget build(BuildContext context) {
    // List of categories
    final List<String> categories = [
      'Electronics',
      'Accessories',
      'Gaming',
      'Watches',
      'Electronics',
      'Accessories',
      'Gaming',
      'Watches',
      'Electronics',
      'Accessories',
      'Gaming',
      'Watches',
      'Electronics',
      'Accessories',
      'Gaming',
      'Watches',
    ];
    void showSuccessDialogAndNavigateToLogin(context) {
      Get.dialog(
        WhiteCustomPopupDialog(
          message: 'Shop Successfully Setup',
          image: 'assets/images/sms 5.png',
        ),
      );

      // Delay for 1 second
      Future.delayed(Duration(seconds: 1), () {
        Get.toNamed(RouteConstants.loginscreen);
      });
    }

    // List of images corresponding to the categories
    final List<String> images = [
      'assets/images/electronicimage.png',
      'assets/images/accessoriesiamge.png',
      'assets/images/gamingimage.png',
      'assets/images/watchesimage.png',
      'assets/images/electronicimage.png',
      'assets/images/accessoriesiamge.png',
      'assets/images/gamingimage.png',
      'assets/images/watchesimage.png',
      'assets/images/electronicimage.png',
      'assets/images/accessoriesiamge.png',
      'assets/images/gamingimage.png',
      'assets/images/watchesimage.png',
      'assets/images/electronicimage.png',
      'assets/images/accessoriesiamge.png',
      'assets/images/gamingimage.png',
      'assets/images/watchesimage.png',
    ];

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
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
                        Get.toNamed(RouteConstants.editsellershop);
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
              const Text(
                'This book is a treatise on the theory of ethics, very popular during the Renaissance. The first line of Lorem Ipsum, "Lorem ipsum dolor sit amet..", comes from a line in section 1.10.32. The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. Sections 1.10.32 and 1.10.33 from "de Finibus Bonorum et Malorum" by Cicero are also reproduced in their exact original form, accompanied by English versions from the 1914 translation by H. Rackham.',
                style: TextStyle(fontSize: 10),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const Divider(),
              const Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Seller: ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'Mathew',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 8), // Adds some space between the texts
                    Text(
                      'Joined since: ',
                      style: TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      '2018',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Location: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'London',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
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
                height: 410,
                child: GridView.builder(
                  physics:
                      NeverScrollableScrollPhysics(), // Prevent the grid from scrolling independently
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4, // Number of columns
                    mainAxisSpacing: 8, // Space between rows
                    crossAxisSpacing: 5, // Space between columns
                    childAspectRatio: 1, // Aspect ratio of each item
                  ),
                  itemCount: categories.length, // Number of items
                  itemBuilder: (context, index) {
                    return GridTile(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              images[index], // Image from the list
                              fit: BoxFit.fill,
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(height: 8),
                            Text(
                              categories[index], // Name from the list
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Image.asset('assets/images/aboutimage.png'),
              SizedBox(
                height: 3.h,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(2),
              //   child: custombutton(
              //       ontap: () {
              //         showSuccessDialogAndNavigateToLogin(context);
              //       },
              //       hinttext: "Finish"),
              // ),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
