import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/customelevatedbutton.dart';

class SetYourProfile extends StatefulWidget {
  SetYourProfile({super.key});

  @override
  State<SetYourProfile> createState() => _SetYourProfileState();
}

class _SetYourProfileState extends State<SetYourProfile> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();
  TextEditingController emailTextEditingContoller = TextEditingController();
  File? _imageFile; // Holds the selected image file

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(ForgotPasswordContoller());
    return WillPopScope(
      onWillPop: () {
        // controller.isLoading.value = false;
        // controller.emailTextEditingContoller.clear();
        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor:
              Colors.transparent, // Set the background color to transparent
          elevation: 0.0, // Remove the shadow
          title: Padding(
            padding: EdgeInsets.only(top: 8.0), // Adjust the padding as needed
            child: Text(
              'Set Profile Picture',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ), // Your app bar title
          leading: Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/arrowback1.png'),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SafeArea(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                    leading: Icon(Icons.photo_library),
                                    title: Text('Pick from gallery'),
                                    onTap: () {
                                      _getImage(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  ListTile(
                                    leading: Icon(Icons.photo_camera),
                                    title: Text('Take a photo'),
                                    onTap: () {
                                      _getImage(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        width: 210,
                        height: 180,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 236, 234, 234),
                          borderRadius: BorderRadius.circular(
                              20), // Adjust the radius as needed
                        ),
                        child: Center(
                          child: _imageFile != null
                              ? Image.file(
                                  _imageFile!,
                                  // width: Get.w,
                                  width: 200,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/plusicon.png',
                                  width: 60,
                                  height: 60,
                                ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  ElevetedButton(
                      buttonName: 'Set Profile',
                      textColor: Colors.white,
                      ontap: () {
                        Get.toNamed(RouteConstants.emailverificaiton);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => BottomNavBarAuction()),
                        // );
                      },
                      fontSize: 14,
                      width: MediaQuery.of(context).size.width * 0.92,
                      color: Color(0xff2E3192)
                      // gradientColors: [Color(0xFF8B2CA0), Color(0xFF00C3C9)],
                      ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  ElevetedButton(
                    borderColor: Colors.black,
                    buttonName: 'Skip',
                    textColor: Colors.grey,
                    ontap: () {
                       Get.toNamed(RouteConstants.emailverificaiton);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => BottomNavBarAuction()),
                      // );
                    },
                    fontSize: 14,
                    width: MediaQuery.of(context).size.width * 0.92,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
