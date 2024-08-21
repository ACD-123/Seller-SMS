import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/models/activeproducts_model.dart';
import 'package:smsseller/models/brandslist_model.dart';
import 'package:smsseller/models/categorywiseattributes_model.dart';
import 'package:smsseller/models/getcategories_model.dart';
import 'package:smsseller/models/inactiveproduct_model.dart';
import 'package:smsseller/models/productpreview_model.dart';
import 'package:smsseller/services/apiservices.dart';

class ProductRepo extends GetxService {
  HttpApiClient apiClient;
  ProductRepo({required this.apiClient});

////////getcategorieslist api
  Future<GetSellerCategoriesListModel?> getSellerCategoriesList() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getsellercategorieslist,
      );
      if (res.statusCode == 200) {
        final listofsellercategories = getCategoriesListModelFromJson(res.body);
        return listofsellercategories;
      } else {
        throw Exception("No data field found in the GetSellerCategoriesList");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

////////getbrandslist api
  Future<GetBrandsListModel?> getBrandsList() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getbrandslist,
      );
      if (res.statusCode == 200) {
        final listofbrands = getBrandsListModelFromJson(res.body);
        return listofbrands;
      } else {
        throw Exception("No data field found in the GetBrandsList");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

////////get categorywise attributes api
  Future<CategoryWiseAttributesModel?> getCategoryWiseAttributes(
      String guid) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getcategorywiseattributes}$guid",
      );
      if (res.statusCode == 200) {
        final listofsellercategories =
            categoryWiseAttributesModelFromJson(res.body);
        return listofsellercategories;
      } else {
        throw Exception("No data field found in the GetCategoryWiseAttributes");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

//////create product api
  Future createproduct({
    required BuildContext context,
    required String title,
    required String stock,
    required String categoryid,
    required String brandid,
    required String price,
    required String discountprice,
    required List<Map<String, dynamic>> productattributes,
    required String description,
    required List<File?> productimages,
  }) async {
    final attrbiutesdata = jsonEncode(productattributes);
    final mapData = {
      "title": title,
      "stock": stock,
      "category_id": categoryid,
      "brand_id": brandid,
      "price": price,
      "height": "1",
      "width": "1",
      "length": "1",
      "weight": "1",
      "discount_price": discountprice,
      "product_attributes": attrbiutesdata,
      "description": description,
    };
    Map<String, String> stringMapData =
        mapData.map((key, value) => MapEntry(key, value.toString()));
    print(stringMapData);
    try {
      final res = await apiClient.postImagesToServer(
          endPoint: AppConstants.createproduct,
          data: stringMapData,
          files: {
            "images[]": productimages,
          });
      if (res.statusCode == 200) {
        Navigator.pop(context);
        //  Get.offNamedUntil('/inventory', (route) =>
        // route.settings.name != '/inventory' &&
        // route.settings.name != '/stepper');
        final message = jsonDecode(res.body)['message'];
        showSuccessSnackbar(message: message);
      } else {
        print(res.body);
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } on SocketException {
      return showErrrorSnackbar(message: 'No Internet Connection');
    } catch (e) {
      showErrrorSnackbar(message: e.toString());
    }
  }

////////get productpreview by id
  Future<ProductPreviewModel?> getProductPreviewById(String guid) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getproductpreviewbyid}$guid",
      );
      if (res.statusCode == 200) {
        final listofproductpreview = productPreviewModelFromJson(res.body);
        return listofproductpreview;
      } else {
        throw Exception("No data field found in the GetProductPreviewByID");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

////////get activeproducts
  Future<ActiveProductsModel?> getActiveProducts(int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getactiveproducts}?page_size=12&page=$page",
      );
      if (res.statusCode == 200) {
        final listofactiveproducts = activeProductsModelFromJson(res.body);
        return listofactiveproducts;
      } else {
        throw Exception("No data field found in the GetActiveProducts");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

////////get inactiveproducts
  Future<InActiveProductsModel?> getInActiveProducts(int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getinactiveproducts}?page_size=12&page=$page",
      );
      if (res.statusCode == 200) {
        final listofinactiveproducts = inactiveProductsModelFromJson(res.body);
        return listofinactiveproducts;
      } else {
        throw Exception("No data field found in the GetInActiveProducts");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

/////updateproductapi
  Future updateproduct({
    required BuildContext context,
    required String title,
    required String stock,
    required String categoryid,
    required String brandid,
    required String price,
    required String discountprice,
    required List<Map<String, dynamic>> productattributes,
    required String description,
    required List<File?> productimages,
    required List<int> oldimageids,
  }) async {
    final attrbiutesdata = jsonEncode(productattributes);
    final mapData = {
      "title": title,
      "stock": stock,
      "category_id": categoryid,
      "brand_id": brandid,
      "price": price,
      "height": "1",
      "width": "1",
      "length": "1",
      "weight": "1",
      "discount_price": discountprice,
      "product_attributes": attrbiutesdata,
      "description": description,
      "deleted_files": oldimageids
    };
    Map<String, String> stringMapData =
        mapData.map((key, value) => MapEntry(key, value.toString()));
    print(stringMapData);
    try {
      final res = await apiClient.postImagesToServer(
          endPoint: AppConstants.updateproduct,
          data: stringMapData,
          files: {
            "images[]": productimages,
          });
      if (res.statusCode == 200) {
        Navigator.pop(context);
        final message = jsonDecode(res.body)['message'];
        showSuccessSnackbar(message: message);
      } else {
        print(res.body);
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