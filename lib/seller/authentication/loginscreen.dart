import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/customcomponents/customwidgets.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/customcomponents/passwordtextfield.dart';
import 'package:smsseller/customcomponents/textfieldforphone.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen() : super();

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isEmailSelected = true;
  final loginController =
      Get.put(AuthenticationController(authRepo: Get.find()));

  gettoken() async {
    // print(get)
    final fcmToekn = await FirebaseMessaging.instance.getToken();
    print(fcmToekn);
  }
  @override
  void initState() {
    super.initState();
    gettoken() ;
    loginController.loginemailcontroller.value.clear();
    loginController.loginpasswordcontroller.value.clear();
    loginController.loadremebermecredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: loginController.loginformKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Column(children: [
                SizedBox(
                  height: 4.h,
                ),
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 1000),
                  animationDuration: const Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  direction: Direction.horizontal,
                  offset: 0.2,
                  child: Image.asset('assets/images/signinlogo.png'),
                ),
                SizedBox(
                  height: 2.h,
                ),
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 500),
                  animationDuration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Center(
                    child: const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1375EA),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 500),
                  animationDuration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Center(
                    child: const Text(
                      'Ready to start shopping. Login to get started',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4.5.h,
                ),
                _isEmailSelected
                    ? EmailCustomTextField(
                        enabled: true,
                        editingController:
                            loginController.loginemailcontroller.value,
                        validator: (v) {
                          if (v!.isEmpty) {
                            return 'Email can\'t be empty';
                          } else if (!v.isEmail) {
                            return 'Invalid Email';
                          }
                          return null;
                        },
                        hintText: 'Email Address',
                        image: 'assets/images/emailiconlogin.png',
                      )
                    : const CustomTextFieldforPhone(),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Obx(
                  () => CustomTextFieldPassword(
                    image: 'assets/images/pasword.png',
                    hintText: 'Password',
                    controller: loginController.loginpasswordcontroller.value,
                    callback: () {
                      loginController.loginPasswordVisibility();
                    },
                    fieldValidator: (v) {
                      if (v!.isEmpty) {
                        return 'Password can\'t be empty';
                      }
                      return null;
                    },
                    hiddenPassword: !loginController.loginpasswordvisible.value,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Obx(
                            () => Checkbox(
                              activeColor: Color(0xff1375EA),
                              value: loginController.remembermeischecked.value,
                              onChanged: (bool? value) {
                                loginController.remembermeischecked.value =
                                    value ?? false;
                                if (value == false) {
                                  loginController.clearremebermecredentials();
                                }
                              },
                            ),
                          ),
                          const Text('Remember Me'),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(RouteConstants.forgot);
                        },
                        child: const Text(
                          'Forgot Password ?',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 6.5.h,
                ),
                Obx(() => loginController.loginloading.value
                    ? Center(
                        child: customcircularprogress(),
                      )
                    : ShowUpAnimation(
                        delayStart: const Duration(milliseconds: 500),
                        animationDuration: const Duration(milliseconds: 500),
                        curve: Curves.fastLinearToSlowEaseIn,
                        direction: Direction.vertical,
                        offset: 0.5,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 20.0, right: 20),
                          child: ElevatedButton(
                              onPressed: () {
                                if (loginController.loginformKey.currentState!
                                    .validate()) {
                                  loginController.login();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff2E3192),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                "Login",
                                style: TextStyle(color: Colors.white),
                              )),
                        ))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Obx(() => Center(
                  child: loginController.socialloginloading.value ? 
                  customcircularprogress(): GestureDetector(
                    onTap: () {
                      //  showSuccessSnackbar(message: "Comming Soon");
                            loginController.handlegoogleSignIn();
                    },
                    child: Container(
                      height: 6.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: const Color(0xffFEFEFE),
                          border: Border.all(color: const Color(0xffACACAC))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/googleicon.png',
                            height: 3.5.h,
                            width: 7.w,
                            fit: BoxFit.fill,
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Text(
                            "Login with Gmail",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xff2D2D2D)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),),
                SizedBox(
                  height: 2.h,
                ),
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 500),
                  animationDuration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Center(
                    child: const Text(
                      'Create an Account?',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                ShowUpAnimation(
                  delayStart: const Duration(milliseconds: 500),
                  animationDuration: const Duration(milliseconds: 500),
                  curve: Curves.fastLinearToSlowEaseIn,
                  direction: Direction.vertical,
                  offset: 0.5,
                  child: Center(
                    child: InkWell(
                      onTap: () {
                        Get.toNamed(RouteConstants.signup);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => SignUpScreen()),
                        // );
                      },
                      child: const Text(
                        '  Sign Up',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                          color: Color(0xff2E3192),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                InkWell(
                  onTap: () {
                    Get.toNamed(RouteConstants.privacypolicy);
                  },
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Color(0xff474747),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget socialMediaContain(
    Color borderColor,
    String image,
  ) =>
      Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(120),
          border: Border.all(color: borderColor),
        ),
        child: Image.asset(image),
      );
}
