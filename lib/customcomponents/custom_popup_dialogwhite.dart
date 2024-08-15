import 'package:flutter/material.dart';

class WhiteCustomPopupDialog extends StatelessWidget {
  final IconData? icon;
  final String message;
  final String? image;
    final String? submessage;
  // final String text;

  WhiteCustomPopupDialog({this.icon, required this.message,  this.submessage,this.image});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: EdgeInsets.zero, // Remove padding
      content: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 30),
            Container(height: 60, child: Image.asset(image ?? "")),
            Padding(
              padding: EdgeInsets.only(left: 20.0, top: 10, bottom: 5),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Text(
              submessage ?? 
              "",
              style: TextStyle(fontSize: 12),
            ),
            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
