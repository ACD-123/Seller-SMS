import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

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
          "Pricay Policy",
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(18.sp),
                decoration: BoxDecoration(
                    color: const Color(0xff1375EA).withOpacity(0.25),
                    borderRadius: BorderRadius.circular(26)),
                child: Text(
                  'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use  Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: const Color(0xff726E6E),
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'Last Updated : 21-3-23',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff2E3192),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Why do we use it?',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff726E6E),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Why do we use it? It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text,  ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xff726E6E),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Where does it come from?',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: Color(0xff726E6E),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                'Why do we use it? It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text,  ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xff726E6E),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
