import 'package:flutter/material.dart';

class CustomTextFieldforPhone extends StatelessWidget {
  const CustomTextFieldforPhone({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.number,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (vaplue) {},
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter Email';
        }
        if (value.length > 200) {
          return 'Cannot exceed 200 characters';
        }
        return null;
      },
      style: const TextStyle(
        fontSize: 18,
        color: Colors.black,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
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
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        hintText: 'Phone',
        hintStyle: TextStyle(color: Colors.grey[500]),
        prefixIcon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.phone,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
