import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/models/categoriessearchbykey_model.dart';
import 'package:smsseller/services/apiservices.dart';

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
    required String whatyousell,
    required String registrationnumber,
    required String description,
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
      "sell": whatyousell,
      "registration_number": registrationnumber,
      "categories": categories,
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
        showSuccessDialogAndNavigateToLogin(context, "Shop Successfully Setup");
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
