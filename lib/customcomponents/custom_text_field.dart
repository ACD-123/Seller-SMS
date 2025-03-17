import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Color? fillColor;
  final bool? readOnly;
  final bool? obscureText;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final int? minLines;
  final int? maxLines;
  final bool isPaddingApply;
  final String? Function(String?)? validator;
  final TextInputAction? textInputAction;
  final TextInputType? keyboardType;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.readOnly,
    this.onTap,
    this.prefix,
    this.suffix,
    this.minLines,
    this.maxLines,
    this.validator,
    this.obscureText,
    this.fillColor,
    this.isPaddingApply = false,
    this.textInputAction,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false, 
      validator: validator,
      onTap: onTap,
      controller: controller,
      readOnly: readOnly ?? false,
      minLines: minLines ?? 1,
      maxLines: maxLines ?? 1,
      textInputAction: textInputAction ?? TextInputAction.done,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        prefixIconColor: const Color(0xFF9E9E9E),
        suffixIconColor: const Color(0xFF535353),
        suffixIcon: suffix,
        prefixIcon: prefix,
        hintText: hintText,
        hintStyle:
                       TextStyle(color: Colors.grey[500], fontSize: 14),
        filled: true,
        fillColor: fillColor ?? Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white, width: 0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white,),
          borderRadius: BorderRadius.circular(12.0),
        ),
        isDense: true,
        border: InputBorder.none,
      ),
    );
  }
}
