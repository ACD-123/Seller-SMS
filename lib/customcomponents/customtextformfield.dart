import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

SizedBox customtextfield({required String hinttext}) {
  return SizedBox(
    height: 6.h,
    child: TextFormField(
      style: TextStyle(
        fontSize: 15.sp,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        suffixIcon: Image.asset('assets/images/profilesettingediticon.png'),
        fillColor: const Color(0XFFFFFFFF),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFDBDBDB), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFDBDBDB), width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hinttext,
        hintStyle: const TextStyle(color: Color(0xFF474747)),
      ),
    ),
  );
}
