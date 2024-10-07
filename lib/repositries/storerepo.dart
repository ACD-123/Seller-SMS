import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/models/categoriessearchbykey_model.dart';
import 'package:smsseller/models/faqmodel.dart';
import 'package:smsseller/models/getcoupon_model.dart';
import 'package:smsseller/models/getcouponbyid_model.dart';
import 'package:smsseller/models/privacypolicy_model.dart';
import 'package:smsseller/models/selleritemssoldstats_model.dart';
import 'package:smsseller/models/sellerprofiledata_model.dart';
import 'package:smsseller/models/sellershopabout_model.dart';
import 'package:smsseller/models/sellershopfeedback_model.dart';
import 'package:smsseller/models/sellershopproduct_model.dart';
import 'package:smsseller/models/sellershopprofiledata_model.dart';
import 'package:smsseller/models/sellertotalsalestats_model.dart';
import 'package:smsseller/models/transection_model.dart';
import 'package:smsseller/services/apiservices.dart';
import 'package:smsseller/services/local_storage.dart';

class StoreRepo extends GetxService {
  HttpApiClient apiClient;
  StoreRepo({required this.apiClient});

////////getcategories
  Future<CategoriesSearchByKeyModel?> getCategoriessearchbykey(
      String key) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint:
            "${AppConstants.getcategoriessearchbykey}?search_key=$key&page_size=999999999",
      );
      if (res.statusCode == 200) {
        final listofcategoriessearchbykey =
            categoriesSearchByKeyModelFromJson(res.body);
        return listofcategoriessearchbykey;
      } else {
        throw Exception("No data field found in the GetCategoriesSearchByKey");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

/////////create seller shop
  Future createsellershop({
    required BuildContext context,
    required String name,
    required String address,
    required String city,
    required String state,
    required String country,
    required String zipcode,
    required String phonecode,
    required String phonenumber,
    required String phonecountrycode,
    required String whatyousell,
    required String registrationnumber,
    required String description,
    required String shippingdomestic,
    required String shippingnation,
    required List<int> categories,
    required File? mainimage,
    required File? coverimage,
    required List<File?> bannersimages,
  }) async {
    final mapData = {
      "name": name,
      "description": description,
      "address": address,
      "city": city,
      "state": state,
      "country": country,
      "zip_code": zipcode,
      "phone_code": phonecode,
      "phone_number": phonenumber,
      "phone_country_code": phonecountrycode,
      "sell": whatyousell,
      "registration_number": registrationnumber,
      "categories": categories,
      "shipping_domestic": shippingdomestic,
      "shipping_nation": shippingnation,
    };
    Map<String, String> stringMapData =
        mapData.map((key, value) => MapEntry(key, value.toString()));
    try {
      for(int i = 0; i < 2; i++){
        final res = await apiClient.postImagesToServer(
          endPoint: AppConstants.createsellershop,
          data: stringMapData,
          files: {
            "cover_image": coverimage,
            "main_image": mainimage,
            "banners[]": bannersimages,
          });
      
      if (res.statusCode == 200) {
        showSuccessDialogAndNavigateToLogin(
            context, "Shop Successfully Setup", RouteConstants.sellerdashboard);
      } else {
        print(res.body);
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
      }}
    } on SocketException {
      return showErrrorSnackbar(message: 'No Internet Connection');
    } catch (e) {
      showErrrorSnackbar(message: e.toString());
    }
  }

////////getsellershopprofiledata
  Future<SellerShopProfileData?> getSellerShopProfileData() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getsellershopprofiledata,
      );
      if (res.statusCode == 200) {
        final String sellerguid =
            jsonDecode(res.body)['data']['sellerData']['guid'];
        final String selleruserid = jsonDecode(res.body)['data']['user']
                ['seller']['user_id']
            .toString();

        LocalStorage().setString("sellerguid", sellerguid);
        LocalStorage().setString("user_id", selleruserid);
        final listofsellershopprofiledata =
            sellerShopProfileDataFromJson(res.body);
        return listofsellershopprofiledata;
      } else {
        throw Exception("No data field found in the GetSellerShopProfileData");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

////////getsellerprofiledata
  Future<SellerProfileData?> getSellerProfileData() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getsellerprofiledata,
      );
      if (res.statusCode == 200) {
        final istrustedseller =
            jsonDecode(res.body)['data']['is_trusted_seller'];
        LocalStorage().setBool("istrustedseller", istrustedseller);
        final listofsellerprofiledata = sellerProfileDataFromJson(res.body);
        return listofsellerprofiledata;
      } else {
        throw Exception("No data field found in the GetSellerProfileData");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

////////get seller side shop products
  Future<SellerShopProductsModel?> getSellerShopProducts(
      String guid, int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint:
            "${AppConstants.getsellershopproducts}$guid?page_size=12&page=$page",
      );
      if (res.statusCode == 200) {
        final listofsellershopproducts =
            sellerShopProductsModelFromJson(res.body);
        return listofsellershopproducts;
      } else {
        throw Exception("No data field found in the GetSellerShopProducts");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ////////get seller side shop about
  Future<SellerShopAboutModel?> getSellerShopAbout(String guid) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getsellershopabout}$guid",
      );
      if (res.statusCode == 200) {
        final listofsellershopabout = sellerShopAboutModelFromJson(res.body);
        return listofsellershopabout;
      } else {
        throw Exception("No data field found in the GetSellerShopAbout");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ////////get seller side shop feedback
  Future<SellerShopFeedbackModel?> getSellerShopFeedback(
      String guid, int page, String filter) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint:
            "${AppConstants.getsellershopfeedback}$guid?filter=$filter&page=$page",
      );
      if (res.statusCode == 200) {
        final listofsellershopfeedback =
            sellerShopFeedbackModelFromJson(res.body);
        return listofsellershopfeedback;
      } else {
        throw Exception("No data field found in the GetSellerShopFeedback");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /////////update seller profile data
  Future updatesellerprofiledata({
    required BuildContext context,
    required String name,
    required String address,
    required String orangepay,
    required String city,
    required String state,
    required String country,
    required String zipcode,
    required String phonecode,
    required String phonenumber,
    required String phonecountrycode,
    required File? profileimage,
  }) async {
    final mapData = {
      "name": name,
      "orange_pay": orangepay,
      "phone_code": phonecode,
      "phone_number": phonenumber,
      "phone_country_code": phonecountrycode,
      "address": address,
      "city": city,
      "state": state,
      "country": country,
      "zip_code": zipcode,
    };
    Map<String, String> stringMapData =
        mapData.map((key, value) => MapEntry(key, value.toString()));
    print(stringMapData);
    try {
      final res = await apiClient.postImagesToServer(
          endPoint: AppConstants.updatesellerprofiledata,
          data: stringMapData,
          files: {
            "image": profileimage,
          });
      if (res.statusCode == 200) {
        Get.back();
        final message = jsonDecode(res.body)['message'];
        showSuccessSnackbar(message: message);
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

////////get seller total sales stats
  Future<SellerTotalSalesStatsModel?> getSellerTotalSalesStats(
      String month) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: '${AppConstants.getsellertotalsalestats}$month',
      );
      if (res.statusCode == 200) {
        final listofsellertotalsalesstats =
            sellerTotalSalesStatsModelFromJson(res.body);
        return listofsellertotalsalesstats;
      } else {
        throw Exception("No data field found in the GetSellerTotalSaleStats");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ////////get seller items sold stats
  Future<SellerItemsSoldStatsModel?> getSellerItemsSoldStats(
      String month) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: '${AppConstants.getselleritemssoldstats}$month',
      );
      if (res.statusCode == 200) {
        final listofselleritemssoldstats =
            sellerItemsSoldStatsModelFromJson(res.body);
        return listofselleritemssoldstats;
      } else {
        throw Exception("No data field found in the GetSellerItemsSoldStats");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  /////////reply sellerfeedback

  Future replysellerFeedback({
    required String id,
    required String comment,
  }) async {
    final mapData = {"id": id, "comment": comment};

    try {
      final res = await apiClient.postToServer(
        endPoint: AppConstants.replysellerfeedback,
        data: mapData,
      );
      if (res.statusCode == 200) {
        final message = jsonDecode(res.body)['message'];
        showSuccessSnackbar(message: message);
        Get.offAllNamed(RouteConstants.sellerdashboard);
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

///////////update seller shop
  Future updateSellershop({
    required BuildContext context,
    required String name,
    required String address,
    required String city,
    required String state,
    required String country,
    required String zipcode,
    required String phonecode,
    required String phonenumber,
    required String phonecountrycode,
    required String whatyousell,
    required String registrationnumber,
    required String description,
    required String shippingdomestic,
    required String shippingnation,
    required List<int> categories,
    required File? mainimage,
    required File? coverimage,
    required List<File?> bannersimages,
    required List<int> deletedids,
  }) async {
    final mapData = {
      "name": name,
      "description": description,
      "address": address,
      "city": city,
      "state": state,
      "country": country,
      "zip_code": zipcode,
      "phone_code": phonecode,
      "phone_number": phonenumber,
      "phone_country_code": phonecountrycode,
      "sell": whatyousell,
      "registration_number": registrationnumber,
      "categories": categories,
      "deleted_files": deletedids,
      "shipping_domestic": shippingdomestic,
      "shipping_nation": shippingnation,
    };
    Map<String, String> stringMapData =
        mapData.map((key, value) => MapEntry(key, value.toString()));
    try {
      final res = await apiClient.postImagesToServer(
          endPoint: AppConstants.createsellershop,
          data: stringMapData,
          files: {
            "cover_image": coverimage,
            "main_image": mainimage,
            "banners[]": bannersimages,
          });
      if (res.statusCode == 200) {
        showSuccessDialogAndNavigateToLogin(context,
            "Shop Successfully Updated", RouteConstants.sellerdashboard);
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

  ////////get seller faq api
  Future<FaqModel?> getSellerFaq() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getfaq,
      );
      if (res.statusCode == 200) {
        final listoffaq = faqModelFromJson(res.body);
        return listoffaq;
      } else {
        throw Exception("No data field found in the GetSellerFaq");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ////////get seller privacy policy api
  Future<PrivayPolicyModel?> getSellerPrivacyPolicy() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getprivacypolicy,
      );
      if (res.statusCode == 200) {
        final listofprivacypolicy = privayPolicyModelFromJson(res.body);
        return listofprivacypolicy;
      } else {
        throw Exception("No data field found in the GetSellerPrivacyPolicy");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

///////create coupon api
  Future<void> creatCoupon({
    required String title,
    required String code,
    required String startdate,
    required String enddate,
    required String discount,
    required String minorder,
  }) async {
    final userData = {
      "title": title.toString(),
      "code": code.toString(),
      "start_date": startdate.toString(),
      "end_date": enddate.toString(),
      "discount": discount,
      "min_order": minorder
    };
    try {
      final response = await apiClient.postToServer(
        endPoint: AppConstants.createcoupon,
        data: userData,
      );

      if (response.statusCode == 200) {
        Get.back();
        final message = jsonDecode(response.body)['message'];
        showSuccessSnackbar(message: message);
      } else if (response.statusCode == 422) {
        final message = jsonDecode(response.body)['message'];
        showErrrorSnackbar(message: message);
      } else {
        final message = jsonDecode(response.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } catch (e) {
      showErrrorSnackbar(
        message: 'An unexpected error occurred. Please try again later.',
      );
    }
  }

////////get coupon api
  Future<GetCouponModel?> getCoupon() async {
    try {
      DateTime now = DateTime.now();
      int year = now.year;
      int month = now.month;
      int day = now.day;
      String currentDate = '$year-$month-$day';
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getcoupon}$currentDate",
      );
      if (res.statusCode == 200) {
        final listofcoupons = getCouponModelFromJson(res.body);
        return listofcoupons;
      } else {
        throw Exception("No data field found in the GetCouponsList");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

////////get coupon by id api
  Future<GetCouponByIdModel?> getCouponById(String id) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getcouponbyid}$id",
      );
      if (res.statusCode == 200) {
        final listofcouponsbyid = getCouponByIdModelFromJson(res.body);
        return listofcouponsbyid;
      } else {
        throw Exception("No data field found in the GetCouponsByID");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

///////update coupon api
  Future<void> updateCoupon({
    required String id,
    required String title,
    required String code,
    required String startdate,
    required String enddate,
    required String discount,
    required String minorder,
  }) async {
    final userData = {
      "title": title.toString(),
      "code": code.toString(),
      "start_date": startdate.toString(),
      "end_date": enddate.toString(),
      "discount": discount,
      "min_order": minorder
    };
    try {
      final response = await apiClient.postToServer(
        endPoint: "${AppConstants.updatecoupon}$id",
        data: userData,
      );

      if (response.statusCode == 200) {
        Get.back();
        final message = jsonDecode(response.body)['message'];
        showSuccessSnackbar(message: message);
      } else if (response.statusCode == 422) {
        final message = jsonDecode(response.body)['message'];
        showErrrorSnackbar(message: message);
      } else {
        final message = jsonDecode(response.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } catch (e) {
      showErrrorSnackbar(
        message: 'An unexpected error occurred. Please try again later.',
      );
    }
  }

//////////delete coupon
  Future<void> deleteCoupon({required String id}) async {
    try {
      final response = await apiClient.postToServer(
          endPoint: "${AppConstants.deletecoupon}$id", data: null);

      if (response.statusCode == 200) {
        Get.back();
        final message = jsonDecode(response.body)['message'];
        showSuccessSnackbar(message: message);
      } else if (response.statusCode == 422) {
        final message = jsonDecode(response.body)['message'];
        showErrrorSnackbar(message: message);
      } else {
        final message = jsonDecode(response.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } catch (e) {
      showErrrorSnackbar(
        message: 'An unexpected error occurred. Please try again later.',
      );
    }
  }

////////get wallet transections api
  Future<TransectionModel?> getWalletTransection(int page) async {
    try {
      final sellerguid = LocalStorage().getString("sellerguid");
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getwallettransection}$sellerguid?page=$page",
      );
      if (res.statusCode == 200) {
        final listofwallettransections = transectionModelFromJson(res.body);
        return listofwallettransections;
      } else {
        throw Exception("No data field found in the GetWalletTransections");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//////////with draw amount api
  Future<void> withDrawAmount({
    required String amount,
  }) async {
    final userData = {
      "amount": amount.toString(),
    };
    try {
      final String sellerguid = LocalStorage().getString("sellerguid");
      final response = await apiClient.postToServer(
        endPoint: "${AppConstants.withdrawamount}$sellerguid",
        data: userData,
      );

      if (response.statusCode == 200) {
        Get.back();
        final message = jsonDecode(response.body)['message'];
        showSuccessSnackbar(message: message);
      } else if (response.statusCode == 422) {
        final message = jsonDecode(response.body)['message'];
        showErrrorSnackbar(message: message);
      } else {
        final message = jsonDecode(response.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } catch (e) {
      showErrrorSnackbar(
        message: 'An unexpected error occurred. Please try again later.',
      );
    }
  }
}
