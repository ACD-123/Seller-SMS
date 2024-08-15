import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

AlertDialog customsuccessalertpopup({required String message}) {
  return AlertDialog(
    backgroundColor: Colors.transparent,
    contentPadding: EdgeInsets.zero,
    content: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 5.h),
          Container(
              height: 6.h,
              child: Image.asset('assets/images/popupdoneimage.png')),
          Padding(
            padding: EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              message,
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    ),
  );
}
