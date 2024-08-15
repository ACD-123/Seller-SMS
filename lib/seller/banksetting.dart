import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/customelevatedbutton.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/customcomponents/customelevatedbutton.dart';

class BankSetting extends StatelessWidget {
  const BankSetting({super.key});

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
          "Bank Setting",
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Image.asset('assets/images/banksettingimg.png')),
            Container(
              width: Get.width,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color.fromARGB(255, 174, 174, 175),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/cardimg.png'),
                    SizedBox(
                      height: 2.h,
                    ),
                    Text(
                      'Bank Name',
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(
                      'Abu Dhabi Islamic Bank',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    // SizedBox(height: MediaQuery.of(context),)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Card Holder Name',
                          style: TextStyle(color: Colors.grey),
                        ),
                        Text(
                          'IBAN Number',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Adam Roberson',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'ADIB07033123456723456',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              width: Get.width,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color.fromARGB(255, 174, 174, 175),
                  )),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/images/africanimg.png'),
                    Text('African Bank'),
                    SizedBox(
                      width: 35.w,
                    ),
                    Image.asset('assets/images/Remove.png'),
                    SizedBox(
                      width: 2.w,
                    ),
                    Image.asset('assets/images/createicon.png'),
                    SizedBox(
                      width: 2.w,
                    ),
                    Image.asset('assets/images/3rd.png'),
                  ]),
            ),
            SizedBox(
              height: 2.h,
            ),
            Container(
              // width: Get.width,
              height: 70,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Color.fromARGB(255, 174, 174, 175),
                  )),
              child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Image.asset('assets/images/africanimg.png'),
                    Text('Bidvest Bank'),
                    SizedBox(
                      width: 35.w,
                    ),
                    Image.asset('assets/images/Remove.png'),
                    SizedBox(
                      width: 2.w,
                    ),
                    Image.asset('assets/images/createicon.png'),
                    SizedBox(
                      width: 2.w,
                    ),
                    Image.asset('assets/images/3rd.png'),
                  ]),
            ),
            SizedBox(
              height: 4.h,
            ),
            ElevetedButton(
              buttonName: 'Add New Bank',
              textColor: Colors.white,
              ontap: () async {
                // showSuccessDialogAndNavigateToLogin(context);
                Get.toNamed(RouteConstants.sellercreatebank);
              },
              fontSize: 14,

              width: MediaQuery.of(context).size.width * 0.50,
              color: const Color(0xff2E3192),
              // gradientColors: [Color(0xFF8B2CA0), Color(0xFF00C3C9)],
            ),
          ],
        ),
      ),
    );
  }
}
