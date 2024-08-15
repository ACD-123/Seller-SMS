import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

GestureDetector custombutton({
  required String hinttext,VoidCallback? ontap
}){
  return
  GestureDetector(
                    onTap: ontap,
                    child: Container(
                      height: 5.5.h,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
                      color: Color(0xff2E3192)),
                    
                      child: Center(child: Text(hinttext,style: TextStyle(
                            fontSize: 15.sp,
                            color: Color(0xffFFFFFF),
                          ))),
                    ),
                  );
}