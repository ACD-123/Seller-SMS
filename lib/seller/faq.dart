import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Faq extends StatelessWidget {
  const Faq({super.key});

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
          "Faq",
          style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.w400),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ExpansionTile(
                title: Text(
                  'Become A Seller',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff474747),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                   padding:  EdgeInsets.only(top: 1.h,bottom: 1.h,left: 3.w,right: 1.w),
                    child: Text(
                        'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'
                        ,
                  style: TextStyle(
                    color: const Color(0xff8D8D8D),
                    fontSize: 14.sp,
                  ),),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              ExpansionTile(
                title: Text(
                  'Start Selling with Us',
                  style: TextStyle(
                    color: const Color(0xff474747),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                padding:  EdgeInsets.only(top: 1.h,bottom: 1.h,left: 3.w,right: 1.w),
                    child: Text(
                        'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'
                           ,
                  style: TextStyle(
                    color: const Color(0xff8D8D8D),
                    fontSize: 14.sp,
                  ),),
                  ),
                ],
              ),
               SizedBox(
                height: 2.h,
              ),
              ExpansionTile(
                title: Text(

                  'Sell Your Products Here',
                  style: TextStyle(
                    color: const Color(0xff474747),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: <Widget>[
                  Padding(
                    padding:  EdgeInsets.only(top: 1.h,bottom: 1.h,left: 3.w,right: 1.w),
                    child: Text(
                        'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using Content here, content here, making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for lorem ipsum will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).'
                        
                         ,
                  style: TextStyle(
                    color: const Color(0xff8D8D8D),
                    fontSize: 14.sp,
                  ),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
