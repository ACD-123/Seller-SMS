import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:smsseller/constants/appconstants.dart';
// import 'package:sms/repositries/authenication_repo.dart';
import 'package:smsseller/repositries/authenication_repo.dart';

class AuthenticationController extends GetxController {
  AuthRepo authRepo;
  File? uploadedProfileImage;
  bool isChecked = false;
  final isLoading = false.obs;
  final isObsCure = true.obs;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
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
  Future<void> Signup({
    required String name,
    required String email,
    required String password,
    required String phonecode,
    required String phonenumber,
  }) async {
    try {
      signuploading.value = true;
      await authRepo.signup(
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
  Future<void> VerifyOTP({
    required BuildContext context,
    required String email,
    required String type,
  }) async {
    try {
      verifyotploading.value = true;
      await authRepo.VerifyOTP(
          otp: otpcontroller.value.text.toString(),
          email: email,
          type: type,
          context: context);

      verifyotploading.value = false;
    } finally {
      verifyotploading.value = false;
    }
  }

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
}
