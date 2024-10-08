import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/customcomponents/googlelogindetails_popup.dart';
import 'package:smsseller/models/subcriptionpaymenturl_model.dart';
import 'package:smsseller/repositries/authenication_repo.dart';
import 'package:smsseller/services/local_storage.dart';
import 'package:url_launcher/url_launcher.dart';

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
    required String orangepay,
  }) async {
    try {
      signuploading.value = true;
      await authRepo.signup(
          orangepay: orangepay.toString(),
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
  Future<void> inAppChangePassword(
    BuildContext context,
  ) async {
    try {
      inappchangepasswordloading.value = true;
      await authRepo.inAppChangePassword(
          context: context,
          oldpassword: inappcurrentpasswordcontroller.value.text.toString(),
          password: inappnewpasswordcontroller.value.text.toString(),
          confirmpassword:
              inappconfirmnewpasswordcontroller.value.text.toString());

      inappchangepasswordloading.value = false;
    } finally {
      inappchangepasswordloading.value = false;
    }
  }

//////////////google signin

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final RxString googleaccesstoken = ''.obs;
  final RxString googlefullname = ''.obs;
  final RxString googleemail = ''.obs;
  Future<void> handlegoogleSignIn(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        googleaccesstoken.value = googleSignInAuthentication.accessToken!;
        googlefullname.value = googleSignInAccount.displayName ?? 'Unknown';
        googleemail.value = googleSignInAccount.email ?? 'Unknown';
        // ignore: use_build_context_synchronously
        googleLoginDetails(
            email: googleemail.value.toString(), context: context);
        // socialLogin(email: email, name: fullname, accesstoken: accessToken);
        print('Access Token: ${googleaccesstoken.value.toString()}');
        print('Email: ${googleemail.value.toString()}');
        print('Full Name: ${googlefullname.value.toString()}');
      } else {
        print('Google Sign in canceled');
      }
    } catch (error) {
      print('Error Google signing in: $error');
    }
  }

////googlesignout
  Future<void> googlesSignOut() async {
    try {
      await _googleSignIn.signOut();
      print('Google Signed out successfully');
    } catch (error) {
      print('Error signing out: $error');
    }
  }

///////////re-sent otp
  var socialloginloading = false.obs;
  final RxString socialphonecountrycode = ''.obs;
  final RxString socialphonecode = ''.obs;
  final socialphonenumbercontroller = TextEditingController().obs;
  final socialaccountnocontroller = TextEditingController().obs;
  Future<void> socialLogin() async {
    try {
      socialloginloading.value = true;
      await authRepo.socialLogin(
          phonecode: socialphonecode.value.toString(),
          phonenumber: socialphonenumbercontroller.value.text.toString(),
          countrycode: socialphonecountrycode.value.toString(),
          orangepay: socialaccountnocontroller.value.text.toString(),
          email: googleemail.value.toString(),
          name: googlefullname.value.toString(),
          accesstoken: googleaccesstoken.value.toString());

      socialloginloading.value = false;
    } finally {
      socialloginloading.value = false;
    }
  }

////////////update fcm api
  var updatefcmloading = false.obs;
  Future<void> updateFCM({
    required String fcmtoken,
  }) async {
    try {
      updatefcmloading.value = true;
      await authRepo.updateFCM(fcmtoken: fcmtoken.toString());

      updatefcmloading.value = false;
    } finally {
      updatefcmloading.value = false;
    }
  }

  ///get fcm
  gettoken() async {
    final fcmtoken = await FirebaseMessaging.instance.getToken();
    updateFCM(fcmtoken: fcmtoken.toString());
    print(fcmtoken);
  }

  //////////////get subscription payment url api
  final Rx<GetSubscriptionPaymentUrlModel?> getsubscriptionpaymenturl =
      Rx<GetSubscriptionPaymentUrlModel?>(null);
  final RxBool getsubscriptionpaymenturlloading = false.obs;

// Future<void> getSubscriptionPayment() async {
//     try {
//       getsubscriptionpaymenturlloading(true);
//       await authRepo.getSubscriptionPaymentUrl().then((value) {
//         getsubscriptionpaymenturl.value = value;
//  try {
//     final paymentUrl = value?.data?.paymentUrl ?? "";

//     if (paymentUrl != null && paymentUrl.isNotEmpty) {
//       final Uri url = Uri.parse(paymentUrl);
//       if (!await launchUrl(url)) {
//         throw Exception('Could not launch URL');
//       }

//       Get.toNamed(RouteConstants.sellercreateshopscreen);
//     } else {
//       throw Exception('Payment URL is invalid or empty.');
//     }
//   } catch (e) {
//     showErrrorSnackbar(message: "Failed to fetch payment URL: ${e.toString()}");
//   } finally {
//     getsubscriptionpaymenturlloading(false);
//   }
//         // Get.to(() => SubscriptionPaymentWebView(
//         //       url: value?.data?.paymentUrl.toString() ?? "",
//         //     ));
//         getsubscriptionpaymenturlloading(false);
//       });
//     } catch (e) {
//       getsubscriptionpaymenturlloading(false);
//     }
//   }
  Future<void> getSubscriptionPayment() async {
    try {
      getsubscriptionpaymenturlloading(true);
      final value = await authRepo.getSubscriptionPaymentUrl();
      getsubscriptionpaymenturl.value = value;

      try {
        final paymentUrl = value?.data?.paymentUrl ?? "";

        if (paymentUrl.isNotEmpty) {
          final Uri url = Uri.parse(paymentUrl);
          if (!await launchUrl(url)) {
            throw Exception('Could not launch URL');
          }

          Get.offAllNamed(RouteConstants.sellercreateshopscreen);
        } else {
          throw Exception('Payment URL is invalid or empty.');
        }
      } catch (e) {
        getsubscriptionpaymenturlloading(false);
        print(e);
        showErrrorSnackbar(message: "Failed to fetch payment URL");
      } finally {
        getsubscriptionpaymenturlloading(false);
      }
    } catch (e) {
      showErrrorSnackbar(
          message: "Failed to load subscription payment URL: ${e.toString()}");
      getsubscriptionpaymenturlloading(false);
    }
  }

////////////google login payment check api
  final googledetailsformkey = GlobalKey<FormState>();
  var googlelogindetailsloading = false.obs;
  Future<void> googleLoginDetails(
      {required String email, required BuildContext context}) async {
    try {
      googlelogindetailsloading.value = true;
      final response = await authRepo.googleLoginDetails(email: email);
      if (response['data'].isEmpty) {
        await showDialog(
          // ignore: use_build_context_synchronously
          context: context,
          builder: (BuildContext context) {
            return googlelogindetailsPopup();
          },
        );
      } else {
        socialLogin();
      }
      googlelogindetailsloading.value = false;
    } finally {
      googlelogindetailsloading.value = false;
    }
  }

//////////logout
  var logoutloading = false.obs;
  Future<void> logout() async {
    try {
      logoutloading.value = true;
      await authRepo.logout();

      logoutloading.value = false;
    } finally {
      logoutloading.value = false;
    }
  }

////////signout
  signout() {
    googlesSignOut();
    logout();
  }
}
