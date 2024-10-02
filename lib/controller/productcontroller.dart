import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/customcomponents/pickimages.dart';
import 'package:smsseller/models/activeproducts_model.dart';
import 'package:smsseller/models/brandslist_model.dart';
import 'package:smsseller/models/categorywiseattributes_model.dart';
import 'package:smsseller/models/deletedproducts_model.dart';
import 'package:smsseller/models/getcategories_model.dart';
import 'package:smsseller/models/getsubcategory_model.dart';
import 'package:smsseller/models/inactiveproduct_model.dart';
import 'package:smsseller/models/productpreview_model.dart';
import 'package:smsseller/models/productwisefeedbacks_model.dart';
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

////////getseller subcategories list
  final Rx<GetSubCategoryModel?> getsellersubcategorieslist =
      Rx<GetSubCategoryModel?>(null);
  final RxBool getsellersubcategorieslistloading = false.obs;

  getsellerSubCategoriesList(String id) async {
    try {
      getsellersubcategorieslistloading(true);
      await productRepo.getSellerSubCategoriesList(id).then((value) {
        getsellersubcategorieslist.value = value;
        print("SubCategories:${value?.data?.subCategories?.length}");
        getsellersubcategorieslistloading(false);
      });
    } catch (e) {
      getsellersubcategorieslistloading(false);
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
  RxString? createproductselectedsubcategory;
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
        getactivedeleteproductswitchboolvalue();
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
      final value =
          await productRepo.getInActiveProducts(inactiveproductpage.value);
      if (inactiveproductpage.value > 1) {
        getinactiveproducts.value?.data?.products
            ?.addAll(value?.data?.products ?? []);
      getoutofstockdeleteproductswitchboolvalue();
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


////////get deletedproducts
  final Rx<DeletedProductsModel?> getdeletedproducts =
      Rx<DeletedProductsModel?>(null);
  final RxBool getdeletedproductsloading = false.obs;
  final RxBool getdeletedproductsreloading = false.obs;
  RxInt deletedproductpage = 1.obs;
  getDeletedProducts() async {
    if (getdeletedproductsreloading.value || getdeletedproductsloading.value)
      return;
    if (deletedproductpage.value > 1 &&
        deletedproductpage.value >
            (getdeletedproducts.value?.data?.pagination?.totalPages ?? 0)) {
      return;
    }
    try {
      deletedproductpage.value > 1
          ? getdeletedproductsreloading.value = true
          : getdeletedproductsloading.value = true;
      final value =
          await productRepo.getDeletedProducts(deletedproductpage.value);
      if (deletedproductpage.value > 1) {
        getdeletedproducts.value?.data?.products
            ?.addAll(value?.data?.products ?? []);
        getinactivedeleteproductswitchboolvalue();
        
      } else {
        getdeletedproducts.value = value;
      }
      deletedproductpage.value++;
      getdeletedproductsreloading.value = false;
      getdeletedproductsloading.value = false;
    } catch (e) {
      getdeletedproductsreloading.value = false;
      getdeletedproductsloading.value = false;
    }
  }

///////////////update product api
  RxString updateproductcategory = ''.obs;
  RxString updateproductbrand = ''.obs;
  var updateproductuploadimages = RxList<File?>([]);
  void updateproductremoveimages(int index) {
    updateproductuploadimages.removeAt(index);
  }

  void updateproductbranddropdown(String value) {
    updateproductbrand.value = value;
    print(updateproductbrand);
  }

  void updateproductcategorydropdown(String value) {
updateproductselectedAttributes.clear();
    updateselectedcategoryattributesList.clear();
    updateproductcategory.value = value;
    var selectedCategory = getsellercategorieslist.value?.data
        ?.firstWhere((category) => category.id.toString() == value);
    getCategoryAttributes(selectedCategory?.guid ?? "");
    getsellerSubCategoriesList(value);
  }
  void updateproductsubcategorydropdown(String value) {
updateproductselectedAttributes.clear();
    updateselectedcategoryattributesList.clear();
    updateproductcategory.value = value;
    var selectedsubCategory = getsellersubcategorieslist.value?.data?.subCategories
        ?.firstWhere((subcategory) => subcategory.id.toString() == value);
    getCategoryAttributes(selectedsubCategory?.guid ?? "");
  }

  Future<void> uploadupdateproductimages(BuildContext context) async {
    final File? pickedImage = await pickImage(context);
    if (pickedImage != null) {
      updateproductuploadimages.add(pickedImage);
    }
  }

  void removeoldupdateproductimages(
      {required int oldimageid, required int index}) {
    updateoldproductimageids.add(oldimageid);
    getproductpreviewbyid.value?.data?.media?.removeAt(index);
    getproductpreviewbyid.refresh();
  }

  var updateproductselectedAttributes = <String, List<String>>{}.obs;
  var updateselectedcategoryattributesList = <Map<String, dynamic>>[].obs;
  void mapNewAttributesToSelectedAttributes() {
    final newAttributes =
        getproductpreviewbyid.value?.data?.newattributes ?? [];
    for (var attribute in newAttributes) {
      final attributeValues = attribute.value;
      for (var value in attributeValues ?? []) {
         final id = value.id;
        final name = value.name;
        final attributeId = value.attributeid;

        updateselectedcategoryattributesList.add({
          'id': id,
          'name': name,
          'attribute_id': attributeId,
        });

      ////attribute add in dropdow 
        final categoryname = attribute.key ??'';
      final currentAttributes =
          updateproductselectedAttributes.putIfAbsent(categoryname, () => []);

      if (!currentAttributes.contains('${categoryname}_$name')) {
        updateproductselectedAttributes[categoryname] = [
          ...currentAttributes,
          '${categoryname}_$name',
        ];}
      print(updateproductselectedAttributes);
      }
    }
  }
final Set<String> _usedIds = {};

String generateUniqueRandomString(int length) {
  const characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final random = Random();

  String newId;
  do {
    newId = List.generate(length, (index) => characters[random.nextInt(characters.length)]).join();
  } while (_usedIds.contains(newId));

  _usedIds.add(newId);
  return newId;
}
  RxList updateoldproductimageids = RxList<int?>([]);
  final updateproductnamecontroller = TextEditingController().obs;
  final updateproductstockcontroller = TextEditingController().obs;
  final updateproductdescriptioncontroller = TextEditingController().obs;
  final updateproductsetpricecontroller = TextEditingController().obs;
  final updateproductsalepricecontroller = TextEditingController().obs;

  RxBool updateproductloading = false.obs;
  Future<void> updateProduct({
    required BuildContext context,
    required String id,
  }) async {
    try {
      updateproductloading.value = true;
      await productRepo
          .updateproduct(
              context: context,
              id: id.toString(),
              title: updateproductnamecontroller.value.text.isEmpty
                  ? getproductpreviewbyid.value?.data?.title.toString() ?? ""
                  : updateproductnamecontroller.value.text.toString(),
              stock: updateproductstockcontroller.value.text.isEmpty
                  ? getproductpreviewbyid.value?.data?.stock.toString() ?? ""
                  : updateproductstockcontroller.value.text.toString(),
              categoryid: updateproductcategory.value.toString(),
              brandid: updateproductbrand.value.toString(),
              price: updateproductsetpricecontroller.value.text.isEmpty
                  ? getproductpreviewbyid.value?.data?.price.toString() ?? ""
                  : updateproductsetpricecontroller.value.text.toString(),
              discountprice: updateproductsalepricecontroller.value.text.isEmpty
                  ? getproductpreviewbyid.value?.data?.discountPrice
                          .toString() ??
                      ""
                  : updateproductsalepricecontroller.value.text.toString(),
              productattributes: updateselectedcategoryattributesList,
              description: updateproductdescriptioncontroller.value.text.isEmpty
                  ? getproductpreviewbyid.value?.data?.description.toString() ??
                      ""
                  : updateproductdescriptioncontroller.value.text.toString(),
              productimages: updateproductuploadimages,
              oldimageids: updateoldproductimageids)
          ;
        

      updateproductloading.value = false;
    } finally {
      updateproductloading.value = false;
    }
  }



//////////delet product api
///////activeproduct switch button value
  Map<int, RxBool> deleteproductswitchbutton = {};
  void getactivedeleteproductswitchboolvalue() {
    for (int i = 0;
        i < (getactiveproducts.value?.data?.products?.length ?? 0);
        i++) {
      deleteproductswitchbutton[i] = RxBool(true);
    }
    
  }
void isdeleteactiveproduct(int index, bool value) {
  if (deleteproductswitchbutton.containsKey(index)) {
      deleteproductswitchbutton[index]?.value = value;
    }

}
///////outof product switch button value
  Map<int, RxBool> outofstockdeleteproductswitchbutton = {};
  void getoutofstockdeleteproductswitchboolvalue() {
    for (int i = 0;
        i < (getinactiveproducts.value?.data?.products?.length ?? 0);
        i++) {
      outofstockdeleteproductswitchbutton[i] = RxBool(true);
    }
    
  }
void outofstockisdeleteactiveproduct(int index, bool value) {
  if (outofstockdeleteproductswitchbutton.containsKey(index)) {
      outofstockdeleteproductswitchbutton[index]?.value = value;
    }

}

///////inactive switch button value
  Map<int, RxBool> inactivedeleteproductswitchbutton = {};
  void getinactivedeleteproductswitchboolvalue() {
    for (int i = 0;
        i < (getdeletedproducts.value?.data?.products?.length ?? 0);
        i++) {
      inactivedeleteproductswitchbutton[i] = RxBool(false);
    
    }
    
  }
void inactiveisdeleteactiveproduct(int index, bool value) {
  if (inactivedeleteproductswitchbutton.containsKey(index)) {
      inactivedeleteproductswitchbutton[index]?.value = value;
    }

}
RxBool deletedproductloading = false.obs;
  Future<void> deleteProduct({
    required int id,
    required int status
  }) async {
    try {
      deletedproductloading.value = true;
      await productRepo
          .deleteProduct(id: id.toString(), status: status.toString())
      ;  
      

      deletedproductloading.value = false;
    } finally {
      deletedproductloading.value = false;
    }
  }

///////////get product wise feedbacks
 final Rx<ProductWiseFeedbackModel?> getproductwisefeedbacks =
      Rx<ProductWiseFeedbackModel?>(null);
  final RxBool getproductwisefeedbacksloading = false.obs;
  final RxBool getproductwisefeedbacksreloading = false.obs;
  final RxInt productwisefeedbackpage = 1.obs;
  Future<void> getProductWiseFeedbacks({required String guid,required String filter}) async {
    if (getproductwisefeedbacksreloading.value || getproductwisefeedbacksloading.value)
      return;
    if (productwisefeedbackpage.value > 1 &&
        productwisefeedbackpage.value >
            (getproductwisefeedbacks.value?.data?.pagination?.totalPages ?? 0)) {
      return;
    }

    try {
      productwisefeedbackpage.value > 1
          ? getproductwisefeedbacksreloading.value = true
          : getproductwisefeedbacksloading.value = true;
      final value = await productRepo.getProductWiseFeedbacks(
        guid: guid, filter: filter, page: productwisefeedbackpage.value.toString());
      if (productwisefeedbackpage.value > 1) {
        getproductwisefeedbacks.value?.data?.feedback
            ?.addAll(value?.data?.feedback ?? []);
       
        productwisefiltervalue.value = filter;
         reasonproductwisefeedbackcontroller();
      } else {
        getproductwisefeedbacks.value = value;
      
        productwisefiltervalue.value = filter;
          reasonproductwisefeedbackcontroller();
      }
      productwisefeedbackpage.value++;
      getproductwisefeedbacksreloading.value = false;
      getproductwisefeedbacksloading.value = false;
    } catch (e) {
      getproductwisefeedbacksreloading.value = false;
      getproductwisefeedbacksloading.value = false;
    }
  }
////////// product wise reply feedback api
 final RxString productwisefiltervalue = ''.obs;
  Map<int, TextEditingController> productwisereplyfeedbackControllers = {};
  void reasonproductwisefeedbackcontroller() {
    for (int i = 0;
        i < (getproductwisefeedbacks.value?.data?.feedback?.length ?? 0);
        i++) {
      productwisereplyfeedbackControllers[i] = TextEditingController();
    }
  }

//////////CREATE PRODUCT subcategory dropdown logic
void createSelectedproductsubCategorydropdown(String value) {
    createselectedcategoryattributesList.clear();
    createproductcategory.value = value;

    var selectedSubCategory = getsellersubcategorieslist.value?.data?.subCategories
        ?.firstWhere((subcategory) => subcategory.id.toString() == value);

    getCategoryAttributes(selectedSubCategory?.guid.toString() ?? "");
  }
}
