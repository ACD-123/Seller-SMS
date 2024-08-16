import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/controller/authcontroller.dart';
import 'package:smsseller/customcomponents/customelevatedbutton.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({super.key});
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final email = Get.arguments as String;
  final authcontroller =
      Get.put(AuthenticationController(authRepo: Get.find()));
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool rememberMe = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _isObscure2 = !_isObscure2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.transparent, // Set the background color to transparent
        elevation: 0.0, // Remove the shadow
        title: const Padding(
          padding: EdgeInsets.only(top: 8.0), // Adjust the padding as needed
          child: Text(
            'Setup Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black,
            ),
          ),
        ), // Your app bar title
        leading: Padding(
          padding:const EdgeInsets.only(top: 10.0, right: 15),
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
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.06),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: authcontroller.changepasswordcontroller.value,
                cursorColor: Colors.green,
                obscureText: _isObscure,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _togglePasswordVisibility,
                    child: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xffDBDBDB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:const  BorderSide(color: Color(0xffDBDBDB)),
                  ),
                ),
                validator: (password) {
                  if (password == null || password.isEmpty) {
                    return "Please Enter Password";
                  }
                  return null;
                },
              ),
           const   SizedBox(
                height: 20,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: authcontroller.changeconfpasswordcontroller.value,
                obscureText: _isObscure2,
                decoration: InputDecoration(
                  suffixIcon: GestureDetector(
                    onTap: _toggleConfirmPasswordVisibility,
                    child: Icon(
                      _isObscure2 ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                  ),
                  hintText: 'Confirm Password',
                  hintStyle:const TextStyle(
                    color: Colors.grey,
                  ),
                  contentPadding: const EdgeInsets.all(15),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xffDBDBDB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: const BorderSide(color: Color(0xffDBDBDB)),
                  ),
                ),
                validator: (conpassword) {
                  if (conpassword !=
                      authcontroller.changepasswordcontroller.value.text) {
                    return "Password Does Not match";
                  }
                  return null;
                },
              ),
             const SizedBox(
                height: 35,
              ),
              Obx(
                () => authcontroller.changepasswordloading.value
                    ? Center(
                        child: customcircularprogress(),
                      )
                    : ElevetedButton(
                        color: const Color(0xff2E3192),
                        buttonName: 'Confirm',
                        textColor: Colors.white,
                        ontap: () {
                          if (formKey.currentState!.validate()) {
                            authcontroller.changePassword(
                                email: email, context: context);
                          }
                        },
                        fontSize: 14,
                        width: MediaQuery.of(context).size.width,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
