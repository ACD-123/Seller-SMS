import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomPopupMessage2Dialog extends StatelessWidget {
  final IconData icon;
  final String message;
  final String? message1;
  CustomPopupMessage2Dialog(
      {required this.icon, required this.message, this.message1});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent, // Make the background transparent
      content: Container(
        width: Get.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF8B2CA0),
              Color(0xFF00C3C9)
            ], // Define your gradient colors
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius:
              BorderRadius.circular(10.0), // Add border radius as needed
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
            ),
            Image.asset('assets/changepassword.png'),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: FittedBox(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            FittedBox(
              child: Text(
                message1!,
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
