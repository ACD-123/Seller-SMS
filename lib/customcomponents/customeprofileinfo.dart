import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

GestureDetector customprofileinfo(
    {required VoidCallback ontap,
    required String profileimage,
    required String title,
    required String name}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 20.sp,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage(profileimage),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8, left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                          color: Color(0xff2E3192),
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp),
                    ),
                    SizedBox(
                      width: 1.w,
                    ),
                    Icon(
                      Icons.waving_hand,
                      color: Color(0xffFFD232),
                      size: 17.sp,
                    ),
                  ],
                ),
                Text(
                  name,
                  style: TextStyle(
                      color: Color(0xff000000).withOpacity(0.7),
                      fontWeight: FontWeight.w400,
                      fontSize: 13.sp),
                ),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
