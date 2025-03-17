// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sms/helper/typ_defs.dart';
import 'package:smsseller/helper/typ_defs.dart';

class CustomTextFieldPassword extends StatelessWidget {
  CustomTextFieldPassword({
    Key? key,
    required this.fieldValidator,
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.hiddenPassword,
    this.callback,
    this.prefixIcon = true, 
  }) : super(key: key);

  final String hintText;
  final IconData icon;
  final FieldValidator fieldValidator;
  final TextEditingController controller;
  final bool hiddenPassword;
  final Function()? callback;
  final bool prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: hiddenPassword,
      controller: controller,
      validator: fieldValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xF3F3F3), width: 0),
          borderRadius: BorderRadius.circular(6.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xF3F3F3), width: 1.5),
          borderRadius: BorderRadius.circular(6.0),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(18.0),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500], fontSize: 16),
        prefixIcon: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 18.sp,
color: Color(0xff1375EA)          ),
        ),
        suffixIcon: prefixIcon
            ? InkWell(
                onTap: callback,
                child: Icon(
                  hiddenPassword ? Icons.visibility : Icons.visibility_off,
                  size: 18,
                  color: Colors.grey,
                ),
              )
            : null,
      ),
    );
  }
}

// Usage example:
// CustomTextFieldPassword(
//   fieldValidator: (v) {
//     if (v!.isEmpty) {
//       return 'Password can\'t be empty';
//     }
//     return null;
//   },
//   controller: passwordController,
//   hintText: 'Password',
//   icon: Icons.lock,
//   hiddenPassword: !logincontroller.signuppasswordvisible.value,
//   callback: () {
//     logincontroller.signupPasswordVisibility();
//   },
// ),
