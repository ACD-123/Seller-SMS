import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Container customtextformfield({
  required String hinttext,
  final TextEditingController? controller,
  final FormFieldValidator<String>? validator,
  Widget? prefixicon,
  Widget? suffixicon,
  final TextInputType? keyboardType,
   bool? enabled,
}) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0XFFFFFFFF),
        boxShadow: [
          BoxShadow(
              blurRadius: 10,
              offset: const Offset(0, 9),
              color: const Color(0xff000000).withOpacity(0.06))
        ]),
    child: TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      enabled: enabled,
      controller: controller,
      validator: validator,
      style: TextStyle(
        fontSize: 15.sp,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        suffixIcon: suffixicon,
        prefixIcon: prefixicon,
        fillColor: const Color(0XFFFFFFFF),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFDBDBDB), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xFFDBDBDB), width: 1),
          borderRadius: BorderRadius.circular(20),
        ),
        contentPadding: const EdgeInsets.all(15.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        hintText: hinttext,
        hintStyle: const TextStyle(color: Color(0xFF656565)),
      ),
      keyboardType: keyboardType,
    ),
  );
}
