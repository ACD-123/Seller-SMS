import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/repositries/authenication_repo.dart';
import 'package:smsseller/services/local_storage.dart';

class AuthenticationController extends GetxController {
  AuthRepo authRepo;
  File? uploadedProfileImage;
  bool isChecked = false;
  final isLoading = false.obs;
  final loginformKey = GlobalKey<FormState>();
  bool isEmailSelected = true;
  AuthenticationController({
    required this.authRepo,
  });

  @override
  void onInit() async {
    super.onInit();

    signupstreetaddrescontroller.value.addListener(() {
      fetchPlaces(signupstreetaddrescontroller.value.text);
    });
  }

  final countryController = TextEditingController();
  final stateController = TextEditingController();
  final cityController = TextEditingController();
  final zipCodeController = TextEditingController();
  final TextEditingController regpasswordController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final RxString statusmessage = ''.obs;
//////////////////////street address places api
  final RxString signupstreetaddres = "".obs;
  final signupcountryregioncontroller = TextEditingController().obs;
  final signupstateprovincecontroller = TextEditingController().obs;
  final signupcitycontroller = TextEditingController().obs;
  final signupzipcodecontroller = TextEditingController().obs;
  final signupstreetaddrescontroller = TextEditingController().obs;
  final places = List<Map<String, dynamic>>.empty(growable: true).obs;
  final selectedPlace = Map<String, dynamic>().obs;

  void fetchPlaces(String input) async {
    if (input.isEmpty) {
      places.clear();
      return;
    }
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=${AppConstants.placesbaseapiurl}');
    final response = await get(url);
    if (response.statusCode == 200) {
      final predictions =
          json.decode(response.body)['predictions'] as List<dynamic>;
      places.assignAll(predictions.cast<Map<String, dynamic>>());
    }
  }

  void setSelectedPlace(String placeId) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&fields=address_components&key=${AppConstants.placesbaseapiurl}');
    final response = await get(url);

    if (response.statusCode == 200) {
      final placeDetails =
          json.decode(response.body)['result'] as Map<String, dynamic>;
      selectedPlace.value = placeDetails;

      final addressComponents = placeDetails['address_components'] as List;
      clearfields();
      for (var component in addressComponents) {
        final types = component['types'] as List;
        if (types.contains('country')) {
          signupcountryregioncontroller.value.text = component['long_name'];
        } else if (types.contains('administrative_area_level_1')) {
          signupstateprovincecontroller.value.text = component['long_name'];
        } else if (types.contains('locality')) {
          signupcitycontroller.value.text = component['long_name'];
        } else if (types.contains('postal_code')) {
          signupzipcodecontroller.value.text = component['long_name'];
        }
      }

      if (signupzipcodecontroller.value.text.isEmpty) {
        signupzipcodecontroller.value.text = 'ZipCode';
      }
      if (signupcountryregioncontroller.value.text.isEmpty) {
        signupcountryregioncontroller.value.text = 'Country';
      }
      if (signupcitycontroller.value.text.isEmpty) {
        signupcitycontroller.value.text = 'City';
      }
      if (signupstateprovincecontroller.value.text.isEmpty) {
        signupstateprovincecontroller.value.text = 'State';
      }
    }
  }

  clearfields() {
    signupzipcodecontroller.value.clear();
    signupcountryregioncontroller.value.clear();
    signupcitycontroller.value.clear();
    signupstateprovincecontroller.value.clear();
  }

///////////signup password visiblity
  final RxBool signuppasswordvisible = false.obs;
  final RxBool signupconfirmpasswordvisible = false.obs;
  void signupConfirmPasswordVisibility() {
    signupconfirmpasswordvisible.value = !signupconfirmpasswordvisible.value;
  }

  void signupPasswordVisibility() {
    signuppasswordvisible.value = !signuppasswordvisible.value;
  }

  //////////signup api
  var signuploading = false.obs;
  final RxString signupphonecode = "".obs;
  final RxString signupphonecountrycode = "".obs;
  Future<void> Signup({
    required String name,
    required String email,
    required String password,
    required String phonecode,
    required String phonecountrycode,
    required String phonenumber,
  }) async {
    try {
      signuploading.value = true;
      await authRepo.signup(
        phonecountrycode: signupphonecountrycode.toString(),
          name: name.toString(),
          email: email.toString(),
          password: password.toString(),
          phonecode: phonecode.toString(),
          phonenumber: phonenumber.toString(),
          zipcode: signupzipcodecontroller.value.text.toString(),
          address: signupstreetaddres.value.toString(),
          city: signupcitycontroller.value.text.toString(),
          state: signupstateprovincecontroller.value.text.toString(),
          country: signupcountryregioncontroller.value.text.toString());

      signuploading.value = false;
    } finally {
      signuploading.value = false;
    }
  }

  //////////verify otp api
  var verifyotploading = false.obs;
  final otpcontroller = TextEditingController().obs;
  Future<void> VerifyOTP(
      {required BuildContext context,
      required String email,
      required String type,
      required String popupmessage}) async {
    try {
      verifyotploading.value = true;
      await authRepo.VerifyOTP(
          otp: otpcontroller.value.text.toString(),
          email: email,
          type: type,
          context: context,
          popupmessage: popupmessage);

      verifyotploading.value = false;
    } finally {
      verifyotploading.value = false;
    }
  }

///////////re-sent otp
  var resendotploading = false.obs;
  Future<void> ReSendOTP({
    required String email,
    required String type,
  }) async {
    try {
      resendotploading.value = true;
      await authRepo.ReSendOTP(email: email.toString(), type: type.toString());

      resendotploading.value = false;
    } finally {
      resendotploading.value = false;
    }
  }

///////send otp
  var sendotploading = false.obs;
  Future<void> sendOTP({
    required String email,
    required String type,
  }) async {
    try {
      sendotploading.value = true;
      await authRepo.SendOTP(email: email.toString(), type: type.toString());

      sendotploading.value = false;
    } finally {
      sendotploading.value = false;
    }
  }

///////////login password visiblity
  final RxBool loginpasswordvisible = false.obs;
  void loginPasswordVisibility() {
    loginpasswordvisible.value = !loginpasswordvisible.value;
  }

////////remeber me logic
  RxBool remembermeischecked = false.obs;
  ////////saveremebe data
  saveremembermecredentials(
      {required String email,
      required String password,
      required bool isremeberme}) {
    LocalStorage().setString("rememberemail", email);
    LocalStorage().setString("rememberpasswrod", password);
    LocalStorage().setBool("isrememberme", isremeberme);
  }

  ///clear remeber me data
  clearremebermecredentials() {
    LocalStorage().remove("rememberemail");
    LocalStorage().remove("rememberpasswrod");
    LocalStorage().remove("isrememberme");
  }

  //////////login api
  var loginloading = false.obs;
  final loginemailcontroller = TextEditingController().obs;
  final loginpasswordcontroller = TextEditingController().obs;
  Future<void> login() async {
    try {
      loginloading.value = true;
      await authRepo.login(
          email: loginemailcontroller.value.text.toString(),
          password: loginpasswordcontroller.value.text.toString());
      remembermeischecked.value
          ? saveremembermecredentials(
              email: loginemailcontroller.value.text.toString(),
              password: loginpasswordcontroller.value.text.toString(),
              isremeberme: remembermeischecked.value)
          : clearremebermecredentials();

      loginloading.value = false;
    } finally {
      loginloading.value = false;
    }
  }

  ///load rememberme
  loadremebermecredentials() {
    loginemailcontroller.value.text = LocalStorage().getString("rememberemail");
    loginpasswordcontroller.value.text =
        LocalStorage().getString("rememberpasswrod");
    remembermeischecked.value = LocalStorage().getBool("isrememberme");
  }

///////change password
  var changepasswordloading = false.obs;
  final changepasswordcontroller = TextEditingController().obs;
  final changeconfpasswordcontroller = TextEditingController().obs;
  Future<void> changePassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      changepasswordloading.value = true;
      await authRepo.changepassword(
          email: email,
          password: changepasswordcontroller.value.text.toString(),
          newpassword: changeconfpasswordcontroller.value.text.toString(),
          context: context);

      changepasswordloading.value = false;
    } finally {
      changepasswordloading.value = false;
    }
  }

///////////in app change password
  var inappchangepasswordloading = false.obs;
  final inappcurrentpasswordcontroller = TextEditingController().obs;
  final inappnewpasswordcontroller = TextEditingController().obs;
  final inappconfirmnewpasswordcontroller = TextEditingController().obs;
  Future<void> inAppChangePassword(  BuildContext context,) async {
    try {
      inappchangepasswordloading.value = true;
      await authRepo.inAppChangePassword(
        context: context,
        oldpassword: inappcurrentpasswordcontroller.value.text.toString(), 
        password: inappnewpasswordcontroller.value.text.toString(), 
        confirmpassword: inappconfirmnewpasswordcontroller.value.text.toString());

      inappchangepasswordloading.value = false;
    } finally {
      inappchangepasswordloading.value = false;
    }
  }
////////signout
signout(){
   LocalStorage().remove("istrustedseller");
   LocalStorage().remove("token");
   LocalStorage().remove("sellerguid"); 
  LocalStorage().remove("user_id");
   Get.offAllNamed(RouteConstants.loginscreen);
}
}
