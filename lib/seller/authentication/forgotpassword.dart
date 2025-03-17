import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/customcomponents/customelevatedbutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/customcomponents/passwordtextfield.dart';

class ForgotPasswordScreens extends StatefulWidget {
  ForgotPasswordScreens({super.key});

  @override
  State<ForgotPasswordScreens> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreens> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingContoller = TextEditingController();
  final authcontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(true);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  Center(
                    child: ShowUpAnimation(
                      delayStart: const Duration(milliseconds: 1000),
                      animationDuration: const Duration(milliseconds: 1000),
                      curve: Curves.fastLinearToSlowEaseIn,
                      direction: Direction.horizontal,
                      offset: 0.2,
                      child: Image.asset('assets/images/signinlogo.png'),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  const Center(
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                          color: Color(0xff1375EA),
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  const Center(
                    child: Text(
                      'No Problem! We have got your back',
                      style: TextStyle(fontSize: 11),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  EmailCustomTextField(
                    icon: Icons.phone,
                    editingController: emailTextEditingContoller,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Email cant be empty';
                      } else if (!v.isEmail) {
                        return 'Invalid Email';
                      }
              
                      return null;
                    },
                    hintText: 'Phone Number',
                
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Obx(
                    () => authcontroller.sendotploading.value
                        ? Center(child: customcircularprogress())
                        : ElevetedButton(
                            buttonName: 'Send Code',
                            textColor: Colors.white,
                            ontap: () async {
                              if (formKey.currentState!.validate()) {
                                authcontroller.sendOTP(
                                    email: emailTextEditingContoller.value.text
                                        .toString(),
                                    type: "1");
                              }
                            },
                            fontSize: 14,
                            width: MediaQuery.of(context).size.width * 0.92,
                            color: const Color(0xff2E3192),
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
