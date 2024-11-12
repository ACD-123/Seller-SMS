import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/models/activeproducts_model.dart';
import 'package:smsseller/models/brandslist_model.dart';
import 'package:smsseller/models/categorywiseattributes_model.dart';
import 'package:smsseller/models/deletedproducts_model.dart';
import 'package:smsseller/models/getcategories_model.dart';
import 'package:smsseller/models/getsubcategory_model.dart';
import 'package:smsseller/models/inactiveproduct_model.dart';
import 'package:smsseller/models/productpreview_model.dart';
import 'package:smsseller/models/productwisefeedbacks_model.dart';
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

////////get seller sub category api
  Future<GetSubCategoryModel?> getSellerSubCategoriesList(String id) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint:
            "${AppConstants.getsellersubcategorieslist}$id?page_size=9999999999",
      );
      if (res.statusCode == 200) {
        final listofsellersubcategories = getSubCategoryModelFromJson(res.body);
        return listofsellersubcategories;
      } else {
        throw Exception(
            "No data field found in the GetSellerSubCategoriesList");
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
      print(res.body);
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

      ///height,width,length,weight is default because moeed said shipping is not yet confirm so from backend side said post defualt 1.
      "width": "1",
      "length": "1",
      "weight": "1",
      "discount_price": discountprice,
      "product_attributes": attrbiutesdata,
      "description": description,
      "created_type": "mobile"
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

///////////////create attributes color images
  Future<String?> productAttributesImages({
    required File attributesColorimages,
  }) async {
    try {
      print("Sent Images to Api:$attributesColorimages");
      final res = await apiClient.postImagesToServer(
        endPoint: AppConstants.productColorimages,
        data: {},
        files: {
          "image": attributesColorimages,
        },
      );
      print(res.body);
      if (res.statusCode == 200) {
        final responseData = jsonDecode(res.body);
        final imageUrl = responseData['data']['image'];
        return imageUrl;
      } else {
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
        return null;
      }
    } on SocketException {
      showErrrorSnackbar(message: 'No Internet Connection');
      return null;
    } catch (e) {
      print("Product Color Images:${e.toString()}");
      showErrrorSnackbar(
          message:
              "An unexpected error occurred ProductColorImages. Please try again later.");
      return null;
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

////////get deletedproducts
  Future<DeletedProductsModel?> getDeletedProducts(int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getdeletedproducts}?page_size=12&page=$page",
      );
      if (res.statusCode == 200) {
        final listofdeletedproducts = deletedProductsModelFromJson(res.body);
        return listofdeletedproducts;
      } else {
        throw Exception("No data field found in the GetDeletedProducts");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

/////updateproductapi
  Future updateproduct({
    required BuildContext context,
    required String id,
    required String title,
    required String stock,
    required String categoryid,
    required String brandid,
    required String price,
    required String discountprice,
    required List<Map<String, dynamic>> productattributes,
    required String description,
    required List<File?> productimages,
    required List<dynamic> oldimageids,
  }) async {
    final attrbiutesdata = jsonEncode(productattributes);
    final mapData = {
      "id": id,
      "title": title,
      "stock": stock,
      "category_id": categoryid,
      "brand_id": brandid,
      "price": price,
      "height": "1",

      ///height,width,length,weight is default because moeed said shipping is not yet confirm so from backend side said post defualt 1.
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
        Get.offAllNamed(RouteConstants.sellerdashboard);
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

//////delete product api
  Future deleteProduct({
    required String id,
    required String status,
  }) async {
    final mapData = {
      "id": id,
      "status": status,
    };

    print(mapData);
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.deleteproduct, data: mapData);
      if (res.statusCode == 200) {
// Get.back();
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

////////////product wise feedbacks api
  Future<ProductWiseFeedbackModel?> getProductWiseFeedbacks(
      {required String guid,
      required String filter,
      required String page}) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint:
            "${AppConstants.getproductwisefeedback}$guid?filter=$filter&page=$page",
      );
      if (res.statusCode == 200) {
        final listofproductwisefeedbacks =
            productWiseFeedbackModelFromJson(res.body);
        return listofproductwisefeedbacks;
      } else {
        throw Exception("No data field found in the GetProductWiseFeedbacks");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
