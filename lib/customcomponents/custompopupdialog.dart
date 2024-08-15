import 'package:flutter/material.dart';

class CustomPopupDialog extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? message1;
  CustomPopupDialog({required this.icon, required this.message, this.message1});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      // backgroundColor: Colors.transparent, // Make the background transparent
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 30,
          ),
          Image.asset('assets/images/sms 5.png'),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          FittedBox(
            child: Text(
              message,
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.01),
          FittedBox(
            child: Text(
              message1!,
              style: TextStyle(fontSize: 11, color: Colors.black),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ],
      ),
    );
  }
}
