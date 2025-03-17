// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
// import 'package:sms/helper/typ_defs.dart';
import 'package:smsseller/helper/typ_defs.dart';

class EmailCustomTextField extends StatelessWidget {
  const EmailCustomTextField({
    Key? key,
    required this.hintText,
    required this.editingController,
    required this.validator,
    required this.icon,
    this.enabled = true,
  }) : super(key: key);

  final String hintText;
  final TextEditingController editingController;
  final FieldValidator validator;
  final IconData icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: editingController,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color(0xF3F3F3), width: 0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        isDense: true,
        contentPadding: const EdgeInsets.all(18.0),
        border: InputBorder.none,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[500], fontSize: 14),
        prefixIcon: Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            icon,
            size: 18.sp,
color: Color(0xff1375EA)          ),
        ),
      ),
    );
  }
}

// Usage example:
// EmailCustomTextField(
//   enabled: false,
//   editingController: logincontroller.signupcountryregioncontroller.value,
//   validator: (v) {
//     if (v!.isEmpty) {
//       return 'Country or Region can\'t be empty';
//     }
//     return null;
//   },
//   hintText: 'Country or Region',
//   icon: Icons.public,
// ),
