import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/customcomponents/customelevatedbutton.dart';

class Emailverification extends StatefulWidget {
  Emailverification({
    Key? key,
  }) : super(key: key);

  @override
  State<Emailverification> createState() => _ForgotEmailverificationState();
}

class _ForgotEmailverificationState extends State<Emailverification> {
  final String email = Get.arguments as String;
  FocusNode fieldOneFocusNode = FocusNode();
  FocusNode fieldTwoFocusNode = FocusNode();
  FocusNode fieldThreeFocusNode = FocusNode();
  FocusNode fieldFourFocusNode = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final authcontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));
  String otpPin = '';
  @override
  void initState() {
    super.initState();
    authcontroller.otpcontroller.value.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0.0, // Remove the shadow
        title: Padding(
          padding: EdgeInsets.only(top: 8.0), // Adjust the padding as needed
          child: Text(
            'Verification Code',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
        ), // Your app bar title
        leading: Padding(
          padding: EdgeInsets.only(top: 10.0, right: 15),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/images/arrowback1.png',
            ),
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
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                RichText(
                  text: TextSpan(
                    style: TextStyle(
                        fontSize: 12, color: Colors.black), // Default style
                    children: <TextSpan>[
                      TextSpan(
                        text: 'We have sent ',
                      ),
                      TextSpan(
                        text: '5 digits',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: ' Verification code on your number',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Container(
                    decoration: BoxDecoration(color: Colors.white),
                    height: 48,
                    width: Get.width,
                    child: TextFormField(
                      enabled: false, // Isse input field disable ho jayega
                      decoration: InputDecoration(
                        hintText: email,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(
                          color: Colors.grey,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xffDBDBDB)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Color(0xffDBDBDB)),
                        ),
                        contentPadding: EdgeInsets.all(15),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    )),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Pinput(
                    length: 5,
                    defaultPinTheme: PinTheme(
                      width: 65,
                      height: 65,
                      textStyle: const TextStyle(
                          fontSize: 20,
                          color: Color.fromRGBO(30, 60, 87, 1),
                          fontWeight: FontWeight.w600),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(.5),
                        border: Border.all(color: const Color(0xff2E3192)),
                        borderRadius: BorderRadius.circular(35),
                      ),
                    ),
                    controller: authcontroller.otpcontroller.value,
                    validator: (value) {
                      if (value == null || value.length != 5) {
                        return 'Please enter a 5-digit OTP';
                      }
                      return null;
                    },
                    // 76629
                  ),
                ),
                SizedBox(
                  height: 2,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('If you didn’t receive a code.'),
                     Obx(() => 
                     authcontroller.resendotploading.value ? Padding(
                       padding: const EdgeInsets.only(left: 3),
                       child: SizedBox(height: 2.h,width: 4.w,child: CircularProgressIndicator(),),
                     )
                     :  GestureDetector(
                        onTap: ()  {
                          authcontroller.ReSendOTP(email: email, type: "0");
                        },
                        child: Text(
                          'ResendCode',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xff2E3192),
                            decoration: TextDecoration.underline,
                            decorationThickness:
                                1.0, // Adjust the thickness as needed
                          ),
                        ),
                      )
                     )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Obx(
                  () => authcontroller.verifyotploading.value
                      ? Center(child: const CircularProgressIndicator())
                      : ElevetedButton(
                          buttonName: 'VERIFY',
                          textColor: Colors.white,
                          ontap: () {
                            if (formKey.currentState!.validate()) {
                              authcontroller.VerifyOTP(
                                  context: context, email: email, type: "0",popupmessage: 'Verification Done');
                            }
                          },
                          // },
                          fontSize: 14,
                          color: const Color(0xff2E3192),
                          width: MediaQuery.of(context).size.width * 0.92,
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class OtpInput extends StatefulWidget {
  final TextEditingController controller;
  final bool autoFocus;
  final FocusNode focusNode;
  final FocusNode nextFocusNode;

  OtpInput(this.controller, this.autoFocus, this.focusNode, this.nextFocusNode,
      {Key? key})
      : super(key: key);

  @override
  _OtpInputState createState() => _OtpInputState();
}

class _OtpInputState extends State<OtpInput> {
  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.autoFocus) {
  //     FocusScope.of(context).requestFocus(widget.focusNode);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 60,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          // border: GradientBoxBorder(
          //   gradient: LinearGradient(
          //     colors: [
          //       Color(0xFF8B2CA0),
          //       Color(0xFF00C3C9),
          //     ],
          //   ),
          //  width: 1,
        ),
        child: TextField(
          focusNode: widget.focusNode,
          controller: widget.controller,
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1,
          cursorColor: Theme.of(context).primaryColor,
          decoration: InputDecoration(
            counterText: '',
            hintText: "",
            hintStyle: TextStyle(color: Colors.black, fontSize: 20.0),
            border: InputBorder.none,
          ),
          onChanged: (value) {
            if (value.isNotEmpty) {
              FocusScope.of(context).requestFocus(widget.nextFocusNode);
            }
          },
        ),
      ),
    );
  }
}
