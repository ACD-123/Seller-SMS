import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/customcomponents/pickimages.dart';
import 'package:smsseller/models/brandslist_model.dart';
import 'package:smsseller/models/categorywiseattributes_model.dart';
import 'package:smsseller/models/getcategories_model.dart';
import 'package:smsseller/repositries/productrepo.dart';

class ProductController extends GetxController {
  ProductRepo productRepo;

  ProductController({required this.productRepo});



////////getsellercategories list
  final Rx<GetSellerCategoriesListModel?> getsellercategorieslist =
      Rx<GetSellerCategoriesListModel?>(null);
  final RxBool getsellercategorieslistloading = false.obs;
  getsellerCategoriesList() async {
    try {
      getsellercategorieslistloading(true);
      await productRepo.getSellerCategoriesList().then((value) {
        getsellercategorieslist.value = value;
        getsellercategorieslistloading(false);
      });
    } catch (e) {
      getsellercategorieslistloading(false);
    }
  }

////////getbrands list
  final Rx<GetBrandsListModel?> getbrandslist =
      Rx<GetBrandsListModel?>(null);
  final RxBool getbrandslistloading = false.obs;
  getBrandsList() async {
    try {
      getbrandslistloading(true);
      await productRepo.getBrandsList().then((value) {
        getbrandslist.value = value;
        getbrandslistloading(false);
      });
    } catch (e) {
      getbrandslistloading(false);
    }
  }

////////get categorywise attributes
  final Rx<CategoryWiseAttributesModel?> getcategoryattributes =
      Rx<CategoryWiseAttributesModel?>(null);
  final RxBool getcategoryattributesloading = false.obs;
  getCategoryAttributes(String guid) async {
    try {
      getcategoryattributesloading(true);
      await productRepo.getCategoryWiseAttributes(guid).then((value) {
        getcategoryattributes.value = value;
        getcategoryattributesloading(false);
      });
    } catch (e) {
      getcategoryattributesloading(false);
    }
  }
/////////////////////create product
  var createproductselectedAttributes = <String, List<String>>{}.obs;
     var createselectedcategoryattributesList = <Map<String, dynamic>>[].obs;
 RxString? createproductselectedcategory;
  RxString? createproductselectedbrand; 
 RxString createproductcategory = ''.obs;  
 RxString createproductbrand = ''.obs; 
 final createproductnamecontroller = TextEditingController().obs;
 final createproductstockcontroller = TextEditingController().obs;
 final createproductdescriptioncontroller = TextEditingController().obs;
 final createproductsetpricecontroller = TextEditingController().obs;
 final createproductsalepricecontroller = TextEditingController().obs;
  var createproductuploadimages = RxList<File?>([]);
  void createproductremoveimages(int index) {
    createproductuploadimages.removeAt(index);
  }

  Future<void> uploadcreateproductimages(BuildContext context) async {
    final File? pickedImage = await pickImage(context);
    if (pickedImage != null) {
      createproductuploadimages.add(pickedImage);
    }
  }

RxBool createproductloading = false.obs;
  Future<void> createProduct({
    required BuildContext context,
  }) async {
    try {
      createproductloading.value = true;
      await productRepo.createproduct(context: context, 
      title: createproductnamecontroller.value.text.toString(), 
      stock: createproductstockcontroller.value.text.toString(), 
      categoryid: createproductcategory.value.toString(), 
      brandid: createproductbrand.value.toString(), 
      price:createproductsetpricecontroller.value.text.toString(), 
      discountprice: createproductsalepricecontroller.value.text.toString(),  
      productattributes: createselectedcategoryattributesList, 
      description: createproductdescriptioncontroller.value.text.toString(), 
      productimages: createproductuploadimages).then((value) => getBrandsList());

      createproductloading.value = false;
    } finally {
      createproductloading.value = false;
    }
  }
}
