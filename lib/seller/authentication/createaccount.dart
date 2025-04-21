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
import '../../customcomponents/custom_textfield.dart';

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
  TextEditingController orangepayaccountcontroller = TextEditingController();
  final isObsCure = true.obs;

  @override
  void initState() {
    super.initState();
    logincontroller.googleaccesstoken.value = '';
    logincontroller.googleemail.value = '';
    logincontroller.googlefullname.value = '';
    orangepayaccountcontroller.clear();
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
                      'Enter Your Details Below',
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),

                  CustomTextField(
                    controller: fullnamecontroller,
                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Full Name can\'t be empty';
                      }
                      return null;
                    },
                    hintText: 'Full Name',
                    prefix: Icon(Icons.person,
                        size: 18.sp, color: Color(0xff1375EA)),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                  ),
                  SizedBox(height: 1.h),

                  SizedBox(
                    height: 1.h,
                  ),

                  EmailCustomTextField(
                    icon: Icons.email,
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
                      logincontroller.signupphonecountrycode.value =
                          phone.countryISOCode;
                    },
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  TextFormField(
                    controller: orangepayaccountcontroller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Account Number can\'t be empty';
                      }
                      return null;
                    },
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xF3F3F3), width: 0),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(18.0),
                        border: InputBorder.none,
                        hintText: 'Orange Pay Account No:',
                        hintStyle:
                            TextStyle(color: Colors.grey[500], fontSize: 14),
                        prefixIcon: Icon(
                          Icons.wallet,
                          size: 18.sp,
                          color: Color(0xff1375EA),
                        )),
                  ),

            
                  SizedBox(
                    height: 1.h,
                  ),
                  Obx(
                    () => CustomTextFieldPassword(
                      icon: Icons.lock,
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
                      icon: Icons.lock,
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
                      icon: Icons.location_city,
                      editingController:
                          logincontroller.signupstreetaddrescontroller.value,
                      validator: (v) {
                        if (logincontroller.signupstreetaddres.value.isEmpty) {
                          return 'Street Address can\'t be empty';
                        }

                        return null;
                      },
                      hintText: logincontroller.signupstreetaddres.value.isEmpty
                          ? 'Street Address'
                          : logincontroller.signupstreetaddres.value,
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
                                logincontroller.signupstreetaddres.value =
                                    place['description'];
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
                    icon: Icons.public,
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
                  ),
                  SizedBox(
                    height: 1.h,
                  ),

                  EmailCustomTextField(
                    icon: Icons.location_city,
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
                  ),
                  
                  SizedBox(
                    height: 1.h,
                  ),

                  EmailCustomTextField(
                    icon: Icons.location_city_outlined,
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
                  ),

                  SizedBox(
                    height: 1.h,
                  ),

                  EmailCustomTextField(
                    icon: Icons.code_rounded,
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
                                        orangepay: orangepayaccountcontroller
                                            .value.text
                                            .toString(),
                                        phonecountrycode: logincontroller
                                            .signupphonecountrycode.value
                                            .toString(),
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
                    height: 2.h,
                  ),

                  // const Center(child: Text('Continue With')),
                  // Center(
                  //   child: ElevetedButton(
                  //     buttonName: 'Login With Facebook',
                  //     textColor: Colors.white,
                  //     ontap: () async {
                  //      showSuccessSnackbar(message: "Comming Soon");
                  //     },
                  //     fontSize: 14,

                  //     width: MediaQuery.of(context).size.width * 0.7,
                  //     color: const Color(0xff3B5998),
                  //     // gradientColors: [Color(0xFF8B2CA0), Color(0xFF00C3C9)],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: MediaQuery.of(context).size.height * 0.02,
                  // ),

                  Obx(
                    () => Center(
                      child: logincontroller.socialloginloading.value
                          ? customcircularprogress()
                          : GestureDetector(
                              onTap: () {
                                logincontroller.socialaccountnocontroller.value
                                    .clear();
                                logincontroller
                                    .socialphonenumbercontroller.value
                                    .clear();
                                logincontroller.socialphonecode.value = '';
                                logincontroller.socialphonecountrycode.value =
                                    '';
                                //  showSuccessSnackbar(message: "Comming Soon");
                                logincontroller.handlegoogleSignIn(context);
                              },
                              child: Container(
                                height: 6.h,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(17),
                                    color: const Color(0xffFEFEFE),
                                    border: Border.all(
                                        color: const Color(0xffACACAC))),
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
                    ),
                  ),

                  SizedBox(
                    height: 1.h,
                  ),
                  Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Already have an Account? '),
                        GestureDetector(
                          onTap: () {
                            Get.offAllNamed(RouteConstants.loginscreen);
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Color(0xff2E3192),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
