import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/customcomponents/whitecustomdialogpopup.dart';
import 'package:smsseller/models/subcriptionpaymenturl_model.dart';
import 'package:smsseller/services/apiservices.dart';
import 'package:smsseller/services/local_storage.dart';
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
    required String phonecountrycode,
    required String orangepay,
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
      "phone_country_code": phonecountrycode.toString(),
      "orange_pay": orangepay.toString(),
      "zip_code": zipcode.toString(),
      "address": address.toString(),
      "city": city.toString(),
      "state": state.toString(),
      "country": country.toString(),
      "is_user": "0"
    };
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.signup, data: mapData);
      if (res.statusCode == 200) {
        Get.toNamed(RouteConstants.emailverificaiton, arguments: email);
        showSuccessSnackbar(message: "Please Verify your Email");
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
    required String popupmessage,
  }) async {
    final mapData = {
      "email": email.toString(),
      "otp": otp.toString(),
      "type": type,
      "is_user": "0"
    };
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.verifyotp, data: mapData);
      if (res.statusCode == 200) {
        if (type == "1") {
          showSuccessSnackbar(message: "Email Verified");
          Get.toNamed(RouteConstants.changepassword, arguments: email);
        } else {
          showSuccessDialogAndNavigateToLogin(
              context, popupmessage, RouteConstants.loginscreen);
        }
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
    final mapData = {"email": email, "type": type, "is_user": "0"};
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

//////////////social login API
  Future socialLogin({
    required String email,
    required String name,
    required String accesstoken,
    required String phonecode,
    required String phonenumber,
    required String countrycode,
    required String orangepay,
  }) async {
    final mapData = {
      "email": email.toString(),
      "name": name,
      "access_token": accesstoken,
      "provider": "Google",
      "phone_code": phonecode,
      "phone_country_code": countrycode,
      "phone_number": phonenumber,
      "orange_pay": orangepay,
      "is_user": 0
    };
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.sociallogin, data: mapData);
      if (res.statusCode == 200) {
        final message = jsonDecode(res.body)['message'];
        showSuccessSnackbar(message: message);
        final token = jsonDecode(res.body)['data']['token'];
        final istrustedseller =
            jsonDecode(res.body)['data']['is_trusted_seller'];
        final issubscription = jsonDecode(res.body)['data']['is_subscribed'];
        istrustedseller == false
            ? Get.offAllNamed(RouteConstants.selerwelcome)
            : Get.offAllNamed(RouteConstants.sellerdashboard);
        LocalStorage().setString("token", token);
        LocalStorage().setBool("istrustedseller", istrustedseller);
        LocalStorage().setInt("isSubscription", issubscription);
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

//////////////send OTP API
  Future SendOTP({
    required String email,
    required String type,
  }) async {
    final mapData = {"email": email, "type": type, "is_user": "0"};
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.resendotp, data: mapData);
      if (res.statusCode == 200) {
        showSuccessSnackbar(message: "OTP Sent");
        Get.toNamed(RouteConstants.forgotemailverification, arguments: email);
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

/////////////Login Api
  Future login({
    required String email,
    required String password,
  }) async {
    final mapData = {"email": email, "password": password, "is_user": "0"};
    try {
      print("email"+email);
      print("password"+password);


      final res = await apiClient.postToServer(
          endPoint: AppConstants.login, data: mapData);
      if (res.statusCode == 200) {
        Get.offAllNamed(RouteConstants.selerwelcome);
        showSuccessSnackbar(message: "Login");
        final token = jsonDecode(res.body)['data']['token'];
        final istrustedseller =
            jsonDecode(res.body)['data']['is_trusted_seller'];
        final issubscription = jsonDecode(res.body)['data']['is_subscribed'];
        istrustedseller == false
            ? Get.offAllNamed(RouteConstants.selerwelcome)
            : Get.offAllNamed(RouteConstants.sellerdashboard);
        LocalStorage().setString("token", token);
        LocalStorage().setBool("istrustedseller", istrustedseller);
        LocalStorage().setInt("isSubscription", issubscription);
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

/////////////changepassword Api
  Future changepassword({
    required String email,
    required String password,
    required String newpassword,
    required BuildContext context,
  }) async {
    final mapData = {
      "email": email,
      "password": password,
      "new_password": newpassword,
      "is_user": "0"
    };
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.changepassword, data: mapData);
      if (res.statusCode == 200) {
        showSuccessDialogAndNavigateToLogin(
            context, 'Password Successfully Setup', RouteConstants.loginscreen);
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

//////////////in app change password
  Future inAppChangePassword({
    required String oldpassword,
    required String password,
    required String confirmpassword,
    required BuildContext context,
  }) async {
    final mapData = {
      "password": password,
      "password_confirmation": confirmpassword,
      "old_password": oldpassword,
      "is_user": "0"
    };
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.inappchangepassword, data: mapData);
      if (res.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            Future.delayed(Duration(seconds: 1), () {
              Get.back();
            });

            return customsuccessalertpopup(
              message: "Password Successfully Changed",
            );
          },
        );
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

////////////get subscription payment url api
  Future<GetSubscriptionPaymentUrlModel?> getSubscriptionPaymentUrl() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getsubscriptionpaymenturl,
      );
      if (res.statusCode == 200) {
        final listofpaymenturl =
            getSubscriptionPaymentUrlModelFromJson(res.body);
        return listofpaymenturl;
      } else {
        throw Exception("No data field found in the GetSubscriptionPaymentUrl");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//////////////update fcm API
  Future updateFCM({
    required String fcmtoken,
  }) async {
    final mapData = {
      "fcm_token": fcmtoken,
    };
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.updatefcm, data: mapData);
      if (res.statusCode == 200) {
        print(res.body);
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

///////google login details api
  Future<Map<String, dynamic>> googleLoginDetails({
    required String email,
  }) async {
    final mapData = {"email": email, "is_user": "0"};
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.googlelogindetails, data: mapData);
      if (res.statusCode == 200) {
        print(res.body);
        return jsonDecode(res.body);
      } else {
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
        return {'status': false, 'data': []};
      }
    } on SocketException {
      return showErrrorSnackbar(message: 'No Internet Connection');
    } catch (e) {
      showErrrorSnackbar(message: e.toString());
      return {'status': false, 'data': []};
    }
  }

//////////////logout
  Future logout() async {
    final mapData = {"type": "mobile"};
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.logout, data: mapData);
      if (res.statusCode == 200) {
        final message = jsonDecode(res.body)['message'];
        showSuccessSnackbar(message: message);
        LocalStorage().remove("istrustedseller");
        LocalStorage().remove("token");
        LocalStorage().remove("sellerguid");
        LocalStorage().remove("user_id");
        LocalStorage().remove("isSubscription");
        Get.offAllNamed(RouteConstants.loginscreen);
      } else {
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } on SocketException {
      return showErrrorSnackbar(message: 'No Internet Connection');
    } catch (e) {
      showErrrorSnackbar(
          message:
              "An unexpected error occurred Logout. Please try again later.");
      throw Exception("Logout: $e");
    }
  }
}
