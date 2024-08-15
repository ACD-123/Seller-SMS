import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/services/apiservices.dart';
// import 'package:sms/services/apiservices.dart';

class AuthRepo extends GetxService {
  HttpApiClient apiClient;
  AuthRepo({required this.apiClient});

//////////signup
  Future signup({
    required String name,
    required String email,
    required String password,
    required String phonecode,
    required String phonenumber,
    required String zipcode,
    required String address,
    required String city,
    required String state,
    required String country,
  }) async {
    final mapData = {
      "name": name,
      "email": email.toString(),
      "password": password.toString(),
      "phone_code": phonecode.toString(),
      "phone_number": phonenumber.toString(),
      "zip_code": zipcode.toString(),
      "address": address.toString(),
      "city": city.toString(),
      "state": state.toString(),
      "country": country.toString()
    };
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.signup, data: mapData);
      if (res.statusCode == 200) {
        Get.toNamed(RouteConstants.emailverificaiton, arguments: email);
        showSuccessSnackbar(message: "Successfully Registered");
      } else {
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } on SocketException {
      return showErrrorSnackbar(message: 'No Internet Connection');
    } catch (e) {
      showErrrorSnackbar(message: e.toString());
    }
  }

//////////////VERIFY OTP API
  Future VerifyOTP({
    required String otp,
    required String email,
    required String type,
    required BuildContext context,
  }) async {
    final mapData = {
      "email": email.toString(),
      "otp": otp.toString(),
      "type": type
    };
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.verifyotp, data: mapData);
      if (res.statusCode == 200) {
        showSuccessDialogAndNavigateToLogin(context);
      } else {
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } on SocketException {
      return showErrrorSnackbar(message: 'No Internet Connection');
    } catch (e) {
      showErrrorSnackbar(message: e.toString());
    }
  }

//////////////re-send OTP API
  Future ReSendOTP({
    required String email,
    required String type,
  }) async {
    final mapData = {"email": email, "type": type};
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.resendotp, data: mapData);
      if (res.statusCode == 200) {
        showSuccessSnackbar(message: "OTP Re-Sent");
      } else {
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } on SocketException {
      return showErrrorSnackbar(message: 'No Internet Connection');
    } catch (e) {
      showErrrorSnackbar(message: e.toString());
    }
  }
}
