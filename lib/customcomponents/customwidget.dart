import 'package:flutter/material.dart';
// import 'package:sms/customcomponents/customelevatedbutton.dart';
import 'package:smsseller/customcomponents/customelevatedbutton.dart';

class CustomWidgeet extends StatelessWidget {
  const CustomWidgeet({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ignore: prefer_const_constructors
          Text('This is scroll view'),
          ElevetedButton(
            buttonName: '',
            color: Colors.red,
          )
        ],
      ),
    );
  }
}
