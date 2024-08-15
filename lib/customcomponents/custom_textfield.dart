// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';
// import 'package:notnew/helpers/typ_defs.dart';

// // import 'package:fundraiser/helpers/typ_defs.dart';

// class EmailCustomTextField extends StatelessWidget {
//   const EmailCustomTextField({
//     Key? key,
//     required this.hintText,
//     required this.editingController,
//     required this.validator,
//     required this.icon,
//     this.enabled = true,
//   }) : super(key: key);

//   final String hintText;
//   final TextEditingController editingController;
//   final FieldValidator validator;
//   final IconData icon;
//   final bool enabled;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: editingController,
//       // readOnly: enabled,
//       autovalidateMode: AutovalidateMode.onUserInteraction,
//       validator: validator,
//       style: const TextStyle(
//         fontSize: 18,
//         color: Colors.black,
//       ),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: Colors.grey[200],
//         enabledBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Color(0xF3F3F3), width: 0),
//           borderRadius: BorderRadius.circular(6.0),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: const BorderSide(color: Color(0xF3F3F3), width: 1.5),
//           borderRadius: BorderRadius.circular(6.0),
//         ),
//         isDense: true,
//         contentPadding: const EdgeInsets.all(18.0),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(6.0),
//         ),
//         hintText: hintText,
//         hintStyle: TextStyle(color: Colors.grey[500]),
//         prefixIcon: Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Icon(
//             icon,
//             size: 20,
//             color: Colors.black,
//           ),
//         ),
//       ),
//     );
//   }
// }
