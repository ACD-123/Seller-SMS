import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/customcomponents/pickimages.dart';
import 'package:smsseller/models/activeproducts_model.dart';
import 'package:smsseller/models/brandslist_model.dart';
import 'package:smsseller/models/categorywiseattributes_model.dart';
import 'package:smsseller/models/getcategories_model.dart';
import 'package:smsseller/models/inactiveproduct_model.dart';
import 'package:smsseller/models/productpreview_model.dart';
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
  final Rx<GetBrandsListModel?> getbrandslist = Rx<GetBrandsListModel?>(null);
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
      await productRepo
          .createproduct(
              context: context,
              title: createproductnamecontroller.value.text.toString(),
              stock: createproductstockcontroller.value.text.toString(),
              categoryid: createproductcategory.value.toString(),
              brandid: createproductbrand.value.toString(),
              price: createproductsetpricecontroller.value.text.toString(),
              discountprice:
                  createproductsalepricecontroller.value.text.toString(),
              productattributes: createselectedcategoryattributesList,
              description:
                  createproductdescriptioncontroller.value.text.toString(),
              productimages: createproductuploadimages)
        
          .then((value) {
        getActiveProducts();
        getInActiveProducts();
      });

      createproductloading.value = false;
    } finally {
      createproductloading.value = false;
    }
  }

////////get previewbyid api
  final Rx<ProductPreviewModel?> getproductpreviewbyid =
      Rx<ProductPreviewModel?>(null);
  final RxBool getproductpreviewbyidloading = false.obs;
  getProductPreviewbyId(String guid) async {
    try {
      getproductpreviewbyidloading(true);
      await productRepo.getProductPreviewById(guid).then((value) {
        getproductpreviewbyid.value = value;
        getproductpreviewbyidloading(false);
      });
    } catch (e) {
      getproductpreviewbyidloading(false);
    }
  }

////////get active products
  // final Rx<ActiveProductsModel?> getactiveproducts =
  //     Rx<ActiveProductsModel?>(null);
  // final RxBool getactiveproductsloading = false.obs;
  // getActiveProducts() async {
  //   try {
  //     getactiveproductsloading(true);
  //     await productRepo.getActiveProducts().then((value) {
  //       getactiveproducts.value = value;
  //       getactiveproductsloading(false);
  //     });
  //   } catch (e) {
  //     getactiveproductsloading(false);
  //   }
  // }
  final Rx<ActiveProductsModel?> getactiveproducts =
      Rx<ActiveProductsModel?>(null);
  final RxBool getactiveproductsloading = false.obs;
  final RxBool getactiveproductsreloadloading = false.obs;
  final RxInt page = 1.obs;
  Future<void> getActiveProducts() async {
    if (getactiveproductsreloadloading.value || getactiveproductsloading.value)
      return;
    if (page.value > 1 &&
        page.value >
            (getactiveproducts.value?.data?.pagination?.totalPages ?? 0)) {
      return;
    }

    try {
      page.value > 1
          ? getactiveproductsreloadloading.value = true
          : getactiveproductsloading.value = true;
      final value = await productRepo.getActiveProducts(page.value);
      if (page.value > 1) {
        getactiveproducts.value?.data?.products
            ?.addAll(value?.data?.products ?? []);
      } else {
        getactiveproducts.value = value;
      }
      page.value++;
      getactiveproductsreloadloading.value = false;
      getactiveproductsloading.value = false;
    } catch (e) {
      getactiveproductsreloadloading.value = false;
      getactiveproductsloading.value = false;
    }
  }

////////get inactive products
  final Rx<InActiveProductsModel?> getinactiveproducts =
      Rx<InActiveProductsModel?>(null);
  final RxBool getinactiveproductsloading = false.obs;
  final RxBool getinactiveproductsreloading = false.obs;
  RxInt inactiveproductpage = 1.obs;
  getInActiveProducts() async {
      if (getinactiveproductsreloading.value || getinactiveproductsloading.value)
      return;
    if (inactiveproductpage.value > 1 &&
        inactiveproductpage.value >
            (getinactiveproducts.value?.data?.pagination?.totalPages ?? 0)) {
      return;
    }
    try {
       inactiveproductpage.value > 1
          ? getinactiveproductsreloading.value = true
          : getinactiveproductsloading.value = true;
 final   value =   await productRepo.getInActiveProducts(inactiveproductpage.value);
       if (inactiveproductpage.value > 1) {
        getinactiveproducts.value?.data?.products
            ?.addAll(value?.data?.products ?? []);
      } else {
        getinactiveproducts.value = value;
      }
      inactiveproductpage.value++;
      getinactiveproductsreloading.value = false;
      getinactiveproductsloading.value = false;
  
    } catch (e) {
        getinactiveproductsreloading.value = false;
      getinactiveproductsloading.value = false;
  
    }
  }


///////////////update product api
var updateproductuploadimages = RxList<File?>([]);
  void updateproductremoveimages(int index) {
    updateproductuploadimages.removeAt(index);
  }

  Future<void> uploadupdateproductimages(BuildContext context) async {
    final File? pickedImage = await pickImage(context);
    if (pickedImage != null) {
      updateproductuploadimages.add(pickedImage);
    }
  }
 
  RxList updateoldproductimageids =RxList<int?>([]);
 final updateproductnamecontroller = TextEditingController().obs;
  final updateproductstockcontroller = TextEditingController().obs;
  final updateproductdescriptioncontroller = TextEditingController().obs;
  final updateproductsetpricecontroller = TextEditingController().obs;
  final updateproductsalepricecontroller = TextEditingController().obs;
RxBool updateproductloading = false.obs;
  // Future<void> updateProduct({
  //   required BuildContext context,
  // }) async {
  //   try {
  //     updateproductloading.value = true;
  //     await productRepo
  //         .updateproduct(context: context, 
  //         title: title, 
  //         stock: stock, 
  //         categoryid: categoryid,
  //          brandid: brandid, 
  //          price: price,
  //           discountprice: discountprice, 
  //           productattributes: productattributes,
  //            description: description, 
  //            productimages: productimages, 
  //            oldimageids: oldimageids)
  //         .then((value) => )
  //         .then((value) {
  //       getActiveProducts();
  //       getInActiveProducts();
  //     });

  //     updateproductloading.value = false;
  //   } finally {
  //     updateproductloading.value = false;
  //   }
  // }
}
