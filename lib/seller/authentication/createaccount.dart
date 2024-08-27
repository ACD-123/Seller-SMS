import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/customcomponents/customelevatedbutton.dart';
import 'package:smsseller/customcomponents/customwidgets.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/customcomponents/passwordtextfield.dart';
import 'package:smsseller/seller/authentication/forgotemailverification.dart';

class Signup extends StatefulWidget {
  Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final logincontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));
  TextEditingController emailTextEditingContoller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmpasswordcontroller = TextEditingController();
  TextEditingController phonnumbercontroller = TextEditingController();
  TextEditingController fullnamecontroller = TextEditingController();
  final isObsCure = true.obs;

  @override
  void initState() {
    super.initState();
    fullnamecontroller.clear();
    phonnumbercontroller.clear();
    passwordcontroller.clear();
    confirmpasswordcontroller.clear();
    emailTextEditingContoller.clear();
    logincontroller.signupstreetaddres.value = '';
    logincontroller.signupcountryregioncontroller.value.clear();
    logincontroller.signupstateprovincecontroller.value.clear();
    logincontroller.signupcitycontroller.value.clear();
    logincontroller.signupzipcodecontroller.value.clear();
  }

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
                      'Create an account',
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
                      'Enter you detail below',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  EmailCustomTextField(
                    editingController: fullnamecontroller,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Full Name can\'t be empty';
                      }
                      return null;
                    },
                    hintText: 'Full Name',
                    image: 'assets/images/fullnameicon.png',
                  ),
                  SizedBox(
                    height: 1.h,
                  ),

                  EmailCustomTextField(
                    editingController: emailTextEditingContoller,
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
                  ),
                  SizedBox(
                    height: 1.h,
                  ),

                  IntlPhoneField(
                    validator: (v) {
                      if (phonnumbercontroller.value.text.isEmpty) {
                        return 'Phone Number can\'t be empty';
                      }
                      return null;
                    },
                    controller: phonnumbercontroller,
                    
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Phone Number',
                      border: InputBorder.none,
                      hintStyle:
                          TextStyle(color: Colors.grey[500], fontSize: 16.sp),
                    ),
                    initialCountryCode: 'KE',
                    onChanged: (phone) {
                      logincontroller.signupphonecode.value = phone.countryCode;
                      logincontroller.signupphonecountrycode.value = phone.countryISOCode;
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),

                  Obx(
                    () => CustomTextFieldPassword(
                      image: 'assets/images/pasword.png',
                      hintText: 'Password',
                      controller: passwordcontroller,
                      callback: () {
                        logincontroller.signupPasswordVisibility();
                      },
                      fieldValidator: (v) {
                        if (v!.isEmpty) {
                          return 'Password can\'t be empty';
                        }
                        return null;
                      },
                      hiddenPassword:
                          !logincontroller.signuppasswordvisible.value,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),

                  Obx(
                    () => CustomTextFieldPassword(
                      image: 'assets/images/pasword.png',
                      hintText: 'Confirm Password',
                      controller: confirmpasswordcontroller,
                      callback: () {
                        logincontroller.signupConfirmPasswordVisibility();
                      },
                      fieldValidator: (v) {
                        if (v != passwordcontroller.text) {
                          return "Password Does Not match";
                        }
                        return null;
                      },
                      hiddenPassword:
                          !logincontroller.signupconfirmpasswordvisible.value,
                      prefixIcon: true,
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),

                  Obx(
                    () => EmailCustomTextField(
                      editingController:
                          logincontroller.signupstreetaddrescontroller.value,
                      validator: (v) {
                        if (logincontroller
                            .signupstreetaddres.value.isEmpty) {
                          return 'Street Address can\'t be empty';
                        }

                        return null;
                      },
                      hintText:
                          logincontroller.signupstreetaddres.value.isEmpty
                              ? 'Street Address'
                              : logincontroller.signupstreetaddres.value,
                      image: 'assets/images/streetaddresicon.png',
                    ),
                  ),
                  SizedBox(
                    height: 1.h,
                  ),

                  Obx(
                    () {
                      if (logincontroller.places.isNotEmpty) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: logincontroller.places.length,
                          itemBuilder: (context, index) {
                            final place = logincontroller.places[index];
                            return ListTile(
                              title: Text(place['description']),
                              onTap: () {
                                logincontroller
                                    .setSelectedPlace(place['place_id']);
                                logincontroller.signupstreetaddres.value = place['description'];
                                logincontroller
                                    .signupstreetaddrescontroller.value
                                    .clear();
                                logincontroller.places.clear();
                              },
                            );
                          },
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  EmailCustomTextField(
                      enabled: false,
                      editingController:
                          logincontroller.signupcountryregioncontroller.value,
                      validator: (v) {
                        if (v!.isEmpty) {
                          return 'Country or Region can\'t be empty';
                        }

                        return null;
                      },
                      hintText: 'Country or Region',
                      image: 'assets/images/countryregionicon.png'),
                  SizedBox(
                    height: 1.h,
                  ),

                  EmailCustomTextField(
                    enabled: false,
                    editingController:
                        logincontroller.signupstateprovincecontroller.value,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'State/Province can\'t be empty';
                      }

                      return null;
                    },
                    hintText: 'State/Province',
                    image: 'assets/images/stateprovineicon.png',
                  ),
                  SizedBox(
                    height: 1.h,
                  ),

                  EmailCustomTextField(
                    enabled: false,
                    editingController:
                        logincontroller.signupcitycontroller.value,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'City can\'t be empty';
                      }

                      return null;
                    },
                    hintText: 'City',
                    image: 'assets/images/cityicon.png',
                  ),

                  SizedBox(
                    height: 1.h,
                  ),

                  EmailCustomTextField(
                    enabled: false,
                    editingController:
                        logincontroller.signupzipcodecontroller.value,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Zip Code can\'t be empty';
                      }

                      return null;
                    },
                    hintText: 'Zip Code',
                    image: 'assets/images/zipcodeicon.png',
                  ),

                  const SizedBox(
                    height: 35,
                  ),
                  Obx(
                    () => logincontroller.signuploading.value
                        ? Center(child: CircularProgressIndicator())
                        : ElevetedButton(
                            buttonName: 'Continue',
                            textColor: Colors.white,
                            ontap: () async {
                              if (formKey.currentState!.validate()) {
                                phonnumbercontroller.value.text.isEmpty
                                    ? showErrrorSnackbar(
                                        message: "Please Enter Phone Number")
                                    : logincontroller.Signup(
                                      phonecountrycode: logincontroller.signupphonecountrycode.value.toString(),
                                        name: fullnamecontroller.value.text
                                            .toString(),
                                        email: emailTextEditingContoller
                                            .value.text
                                            .toString(),
                                        password: passwordcontroller.value.text
                                            .toString(),
                                        phonecode: logincontroller
                                            .signupphonecode.value
                                            .toString(),
                                        phonenumber: phonnumbercontroller
                                            .value.text
                                            .toString());
                              }
                            },
                            fontSize: 14,
                            width: MediaQuery.of(context).size.width * 0.92,
                            color: const Color(0xff2E3192),
                          ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  // const Center(child: Text('Continue With')),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Center(
                    child: ElevetedButton(
                      buttonName: 'Login With Facebook',
                      textColor: Colors.white,
                      ontap: () async {
                       showSuccessSnackbar(message: "Comming Soon");
                      },
                      fontSize: 14,

                      width: MediaQuery.of(context).size.width * 0.7,
                      color: const Color(0xff3B5998),
                      // gradientColors: [Color(0xFF8B2CA0), Color(0xFF00C3C9)],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Center(
                    child: ElevetedButton(
                      buttonName: 'Login With Google',
                      textColor: Colors.black,
                      ontap: ()  {
                        showSuccessSnackbar(message: "Comming Soon");
                      },
                      fontSize: 14,
                      borderColor: Colors.black,
                      width: MediaQuery.of(context).size.width * 0.7,
                      color: Colors.white,
                      // gradientColors: [Color(0xFF8B2CA0), Color(0xFF00C3C9)],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Center(child: const Text('Already have an Account ')),
                  GestureDetector(
                    onTap: (){
                      Get.offAllNamed(RouteConstants.loginscreen);
                    },
                    child: Center(
                      child: const Text(
                        'Login ',
                        style: TextStyle(color: Color(0xff2E3192)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
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
