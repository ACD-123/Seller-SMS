import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/ordercontroller.dart';
import 'package:smsseller/customcomponents/pickimages.dart';
import 'package:smsseller/models/categoriessearchbykey_model.dart';
import 'package:smsseller/models/faqmodel.dart';
import 'package:smsseller/models/getcoupon_model.dart';
import 'package:smsseller/models/getcouponbyid_model.dart';
import 'package:smsseller/models/privacypolicy_model.dart';
import 'package:smsseller/models/selectcategory_model.dart';
import 'package:smsseller/models/selleritemssoldstats_model.dart';
import 'package:smsseller/models/sellerprofiledata_model.dart';
import 'package:smsseller/models/sellershopabout_model.dart';
import 'package:smsseller/models/sellershopfeedback_model.dart';
import 'package:smsseller/models/sellershopproduct_model.dart';
import 'package:smsseller/models/sellershopprofiledata_model.dart';
import 'package:smsseller/models/sellertotalsalestats_model.dart';
import 'package:smsseller/models/transection_model.dart';
import 'package:smsseller/repositries/storerepo.dart';
import 'package:smsseller/seller/sellerchatlistscreen.dart';

class StoreController extends GetxController {
  StoreRepo storeRepo;

  StoreController({required this.storeRepo});
  final ordercontroller = Get.put(OrderController(orderRepo: Get.find()));
  @override
  void onInit() async {
    super.onInit();
    searchcategorykeycontroller.value.addListener(() {
      getCategoriesSearchbykey(
          searchcategorykeycontroller.value.text.toString());
    });
    todaysalesselectedmonth.value = selectmonthslist[getCurrentMonthIndex()];
    itemssoldselectedmonth.value = selectmonthslist[getCurrentMonthIndex()];
  }

///////////seller createshop profile image
  var sellercreateshopuploadedprofileImage = Rx<File?>(null);

  void sellercreateshopsetprofileImage(File? image) {
    sellercreateshopuploadedprofileImage.value = image;
  }

  Future<void> uploadsellercreateshopprofileimage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    if (pickedImage != null) {
      final pickedFile = await picker.pickImage(source: pickedImage);
      if (pickedFile != null) {
        sellercreateshopsetprofileImage(File(pickedFile.path));
      }
    }
  }

  ///////////create bank dropdown list

  var selectedbank;
  final List<String> selectbanklist = [
    "Bank of America",
    "National Bank",
    "Capitec Bank",
  ];

  ///////////seller dashboard months dropdown list
  int getCurrentMonthIndex() {
    final now = DateTime.now();
    return now.month - 1;
  }

  RxString todaysalesselectedmonth = ''.obs;
  final List<String> selectmonthslist = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  var itemssoldselectedmonth = "".obs;

/////////////////////seller setup shop cover image

  var sellersetupshopuploadedcoverImage = Rx<File?>(null);

  void sellersetupshopcoverImage(File? image) {
    sellersetupshopuploadedcoverImage.value = image;
  }

  Future<void> uploadsellersetupshopcoverImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    if (pickedImage != null) {
      final pickedFile = await picker.pickImage(source: pickedImage);
      if (pickedFile != null) {
        sellersetupshopcoverImage(File(pickedFile.path));
      }
    }
  }

/////////sellersetup shop add catgeoryies list
  RxList<Map<String, dynamic>> sellersetupshopaddcategoriesList =
      <Map<String, dynamic>>[
    {"title": "Electronics", "image": 'assets/images/homecatgeoryicon2.png'},
    {
      "title": "Fashion Accessories  ",
      "image": 'assets/images/homecatgeoryicon3.png'
    },
    {"title": "DSLR Camera", "image": 'assets/images/homecatgeoryicon5.png'},
  ].obs;

/////////////////////seller setup shop add banner  images

  var sellersetupshopuploadedbannerimages = RxList<File?>([]);
  void setupshopremovebannerImage(int index) {
    sellersetupshopuploadedbannerimages.removeAt(index);
  }

  Future<void> uploadsellersetupshopbannerimages(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    if (pickedImage != null) {
      final pickedFile = await picker.pickImage(source: pickedImage);
      if (pickedFile != null) {
        sellersetupshopuploadedbannerimages.add(File(pickedFile.path));
      }
    }
  }

  ////sellerchatslist
  RxList<ChatsList> sellerchatslist = [
    ChatsList(
      userName: 'John doe',
      userDescription:
          'Buyers are more likely to purchase more of the same........',
      time: '9:38 am',
      imageUrl: 'assets/images/chatslistprofilepic1.png',
    ),
    ChatsList(
      userName: 'John doe',
      userDescription:
          'Buyers are more likely to purchase more of the same........',
      time: '9:38 am',
      imageUrl: 'assets/images/chatslistprofilepic2.png',
    ),
    ChatsList(
      userName: 'John doe',
      userDescription:
          'Buyers are more likely to purchase more of the same........',
      time: '9:38 am',
      imageUrl: 'assets/images/chatslistprofilepic1.png',
    ),
    ChatsList(
      userName: 'John doe',
      userDescription:
          'Buyers are more likely to purchase more of the same........',
      time: '9:38 am',
      imageUrl: 'assets/images/chatslistprofilepic2.png',
    ),
    ChatsList(
      userName: 'John doe',
      userDescription:
          'Buyers are more likely to purchase more of the same........',
      time: '9:38 am',
      imageUrl: 'assets/images/chatslistprofilepic1.png',
    ),
    ChatsList(
      userName: 'John doe',
      userDescription:
          'Buyers are more likely to purchase more of the same........',
      time: '9:38 am',
      imageUrl: 'assets/images/chatslistprofilepic2.png',
    ),
    ChatsList(
      userName: 'John doe',
      userDescription:
          'Buyers are more likely to purchase more of the same........',
      time: '9:38 am',
      imageUrl: 'assets/images/chatslistprofilepic1.png',
    ),
    ChatsList(
      userName: 'John doe',
      userDescription:
          'Buyers are more likely to purchase more of the same........',
      time: '9:38 am',
      imageUrl: 'assets/images/chatslistprofilepic2.png',
    ),
  ].obs;
  void sellerchatslistremove(int index) {
    sellerchatslist.removeAt(index);
  }

/////////////////////user report seller  shop attach image

  var userreportsellerattachedimage = Rx<File?>(null);

  void userreportsellerattachimage(File? image) {
    userreportsellerattachedimage.value = image;
  }

  Future<void> uploaduserreportsellerattachedimage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    if (pickedImage != null) {
      final pickedFile = await picker.pickImage(source: pickedImage);
      if (pickedFile != null) {
        userreportsellerattachedimage(File(pickedFile.path));
      }
    }
  }

///////////////get categories searchbykey
  final searchcategorykeycontroller = TextEditingController().obs;
  final Rx<CategoriesSearchByKeyModel?> categoriesSearchbykey =
      Rx<CategoriesSearchByKeyModel?>(null);
  final RxBool categoriesSearchbykeyloading = false.obs;
  getCategoriesSearchbykey(String key) async {
    try {
      if (key.isEmpty) {
        categoriesSearchbykey.value = null;
        return;
      }
      categoriesSearchbykeyloading(true);
      await storeRepo.getCategoriessearchbykey(key.toString()).then((value) {
        categoriesSearchbykey.value = value;
        categoriesSearchbykeyloading(false);
      });
    } catch (e) {
      categoriesSearchbykeyloading(false);
    }
  }

///////select category
  RxList<SelectCategory> createshopselectedCategories = <SelectCategory>[].obs;
  RxList<int> createshopselectedCategoryIds = <int>[].obs;
  void sellersetupshopremoveCategory(int index) {
    createshopselectedCategories.removeAt(index);
  }

  void sellersetupshopremoveCategoryIds(int index) {
    createshopselectedCategoryIds.removeAt(index);
  }

/////////////sellercreateshop api
  final phonenumbercontroller = TextEditingController().obs;
  final shopnamecontroller = TextEditingController().obs;
  final whatyousellcontroller = TextEditingController().obs;
  final shopregistrationnumcontroller = TextEditingController().obs;
  final shippingdomesticcontroller = TextEditingController().obs;
  final shippingnationcontroller = TextEditingController().obs;
  final createaboutshop = TextEditingController().obs;
  final createshopphonecode = ''.obs;
  final createshopphonecountrycode = ''.obs;
  final RxBool sellercreateshoploading = false.obs;
  Future<void> sellerCreateShop({
    required BuildContext context,
    required String address,
    required String city,
    required String state,
    required String country,
    required String zipcode,
  }) async {
    try {
      sellercreateshoploading.value = true;
      await storeRepo.createsellershop(
          shippingdomestic: shippingdomesticcontroller.value.text.toString(),
          shippingnation: shippingnationcontroller.value.text.toString(),
          context: context,
          name: shopnamecontroller.value.text.toString(),
          address: address,
          city: city,
          state: state,
          country: country,
          zipcode: zipcode,
          phonecountrycode: createshopphonecountrycode.value.toString(),
          phonecode: createshopphonecode.value.toString(),
          phonenumber: phonenumbercontroller.value.text.toString(),
          whatyousell: whatyousellcontroller.value.text.toString(),
          registrationnumber: shopnamecontroller.value.text.toString(),
          description: createaboutshop.value.text.toString(),
          categories: createshopselectedCategoryIds,
          mainimage: sellercreateshopuploadedprofileImage.value,
          coverimage: sellersetupshopuploadedcoverImage.value,
          bannersimages: sellersetupshopuploadedbannerimages);

      sellercreateshoploading.value = false;
    } finally {
      sellercreateshoploading.value = false;
    }
  }

///////////////get seller shop profile data
  final Rx<SellerShopProfileData?> getsellershopprofiledata =
      Rx<SellerShopProfileData?>(null);
  final RxBool getsellershopprofiledataloading = false.obs;
  getSellerShopProfileData() async {
    try {
      getsellershopprofiledataloading(true);
      await storeRepo.getSellerShopProfileData().then((value) {
        getsellershopprofiledata.value = value;
        getsellershopprofiledataloading(false);
      });
    } catch (e) {
      getsellershopprofiledataloading(false);
    }
  }

///////////////get seller profile data
  final Rx<SellerProfileData?> getsellerprofiledata =
      Rx<SellerProfileData?>(null);
  final RxBool getsellerprofiledataloading = false.obs;
  getSellerProfileData() async {
    try {
      getsellerprofiledataloading(true);
      await storeRepo.getSellerProfileData().then((value) {
        getsellerprofiledata.value = value;
        getsellerprofiledataloading(false);
      });
    } catch (e) {
      getsellerprofiledataloading(false);
    }
  }

///////////seller  profile screen image
  var sellershopuploadedprofileImage = Rx<File?>(null);

  void sellershopprofileImage(File? image) {
    sellershopuploadedprofileImage.value = image;
  }

  Future<void> uploadsellershopprofileImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedImage = await showDialog<ImageSource>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  child: const Text("Camera"),
                  onTap: () {
                    Navigator.of(context).pop(ImageSource.camera);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
    if (pickedImage != null) {
      final pickedFile = await picker.pickImage(source: pickedImage);
      if (pickedFile != null) {
        sellershopprofileImage(File(pickedFile.path));
      }
    }
  }

///////////update seller profile data

  final updatesellerprofilephonenumber = TextEditingController().obs;
  final updatesellerprofilename = TextEditingController().obs;
  final updateorangepayaccountno = TextEditingController().obs;
  final updatesellerprofilephonecode = ''.obs;
  final updatesellerprofilephonecountrycode = ''.obs;

  final RxBool updateSellerProfileDataloading = false.obs;
  Future<void> updateSellerProfileData({
    required BuildContext context,
    required String address,
    required String city,
    required String state,
    required String country,
    required String zipcode,
  }) async {
    try {
      updateSellerProfileDataloading.value = true;
      await storeRepo
          .updatesellerprofiledata(
              context: context,
              orangepay: updateorangepayaccountno.value.text.isEmpty
                  ? getsellerprofiledata.value?.data?.orangepay.toString() ?? ""
                  : updateorangepayaccountno.value.text.toString(),
              phonecountrycode:
                  updatesellerprofilephonecountrycode.value.isEmpty
                      ? getsellerprofiledata.value?.data?.phonecountrycode
                              .toString() ??
                          ""
                      : updatesellerprofilephonecountrycode.value.toString(),
              name: updatesellerprofilename.value.text.isEmpty
                  ? getsellerprofiledata.value?.data?.name.toString() ?? ""
                  : updatesellerprofilename.value.text.toString(),
              address: address.isEmpty
                  ? getsellerprofiledata.value?.data?.address.toString() ?? ""
                  : address,
              city: city.isEmpty
                  ? getsellerprofiledata.value?.data?.city.toString() ?? ""
                  : city,
              state: state.isEmpty
                  ? getsellerprofiledata.value?.data?.state.toString() ?? ""
                  : state,
              country: country.isEmpty
                  ? getsellerprofiledata.value?.data?.country.toString() ?? ""
                  : country,
              zipcode: zipcode.isEmpty
                  ? getsellerprofiledata.value?.data?.zipCode.toString() ?? ""
                  : zipcode,
              phonecode: updatesellerprofilephonecode.value.isEmpty
                  ? getsellerprofiledata.value?.data?.phoneCode.toString() ?? ""
                  : updatesellerprofilephonecode.value.toString(),
              phonenumber: updatesellerprofilephonenumber.value.text.isEmpty
                  ? getsellerprofiledata.value?.data?.phoneNumber.toString() ??
                      ""
                  : updatesellerprofilephonenumber.value.text.toString(),
              profileimage: sellershopuploadedprofileImage.value)
          .then((value) => getSellerProfileData());

      updateSellerProfileDataloading.value = false;
    } finally {
      updateSellerProfileDataloading.value = false;
    }
  }

///////////////get seller total sales stats
  final Rx<SellerTotalSalesStatsModel?> getsellertotalsalesstats =
      Rx<SellerTotalSalesStatsModel?>(null);
  final RxBool getsellertotalsalesstatsloading = false.obs;
  getSellerTotalSalesStats(String month) async {
    try {
      getsellertotalsalesstatsloading(true);
      await storeRepo.getSellerTotalSalesStats(month).then((value) {
        getsellertotalsalesstats.value = value;
        getsellertotalsalesstatsloading(false);
      });
    } catch (e) {
      getsellertotalsalesstatsloading(false);
    }
  }

///////////////get seller items sold stats
  final Rx<SellerItemsSoldStatsModel?> getselleritemssoldstats =
      Rx<SellerItemsSoldStatsModel?>(null);
  final RxBool getselleritemssoldstatsloading = false.obs;
  getSellerItemsSoldStats(String month) async {
    try {
      getselleritemssoldstatsloading(true);
      await storeRepo.getSellerItemsSoldStats(month).then((value) {
        getselleritemssoldstats.value = value;
        getselleritemssoldstatsloading(false);
      });
    } catch (e) {
      getselleritemssoldstatsloading(false);
    }
  }

///////seller side shop products
  final Rx<SellerShopProductsModel?> getsellersideshopproducts =
      Rx<SellerShopProductsModel?>(null);
  final RxBool getsellershopproductsloading = false.obs;
  final RxBool getsellershopproductsreloading = false.obs;
  RxInt sellershopproductspage = 1.obs;
  getSellerShopProducts() async {
    if (getsellershopproductsreloading.value ||
        getsellershopproductsloading.value) return;
    if (sellershopproductspage.value > 1 &&
        sellershopproductspage.value >
            (getsellersideshopproducts.value?.data?.pagination?.totalPages ??
                0)) {
      return;
    }
    try {
      sellershopproductspage.value > 1
          ? getsellershopproductsreloading.value = true
          : getsellershopproductsloading.value = true;
      final value = await storeRepo.getSellerShopProducts(
          getsellershopprofiledata.value?.data?.sellerData?.guid ?? "",
          sellershopproductspage.value);
      if (sellershopproductspage.value > 1) {
        getsellersideshopproducts.value?.data?.products
            ?.addAll(value?.data?.products ?? []);
      } else {
        getsellersideshopproducts.value = value;
      }
      sellershopproductspage.value++;
      getsellershopproductsreloading.value = false;
      getsellershopproductsloading.value = false;
    } catch (e) {
      getsellershopproductsreloading.value = false;
      getsellershopproductsloading.value = false;
    }
  }

///////////////get seller shop about
  final Rx<SellerShopAboutModel?> getsellershopabout =
      Rx<SellerShopAboutModel?>(null);
  final RxBool getsellershopaboutloading = false.obs;
  getSellerShopAbout() async {
    try {
      getsellershopaboutloading(true);
      await storeRepo
          .getSellerShopAbout(
              getsellershopprofiledata.value?.data?.sellerData?.guid ?? "")
          .then((value) {
        getsellershopabout.value = value;
        getsellershopaboutloading(false);
      });
    } catch (e) {
      getsellershopaboutloading(false);
    }
  }

//////seller side shop feedback
  final RxString sellersidefeedbackfiltervalue = ''.obs;
  final Rx<SellerShopFeedbackModel?> getsellersideshoppfeedback =
      Rx<SellerShopFeedbackModel?>(null);
  final RxBool getsellersideshopfeedbackloading = false.obs;
  final RxBool getsellersideshopfeedbackreloading = false.obs;
  RxInt sellershopfeedbackspage = 1.obs;
  getSellerShopFeedback(String filter) async {
    if (getsellersideshopfeedbackreloading.value ||
        getsellersideshopfeedbackloading.value) return;
    if (sellershopfeedbackspage.value > 1 &&
        sellershopfeedbackspage.value >
            (getsellersideshoppfeedback.value?.data?.pagination?.totalPages ??
                0)) {
      return;
    }
    try {
      sellershopfeedbackspage.value > 1
          ? getsellersideshopfeedbackreloading.value = true
          : getsellersideshopfeedbackloading.value = true;
      final value = await storeRepo.getSellerShopFeedback(
          getsellershopprofiledata.value?.data?.sellerData?.guid ?? "",
          sellershopfeedbackspage.value,
          filter);
      if (sellershopfeedbackspage.value > 1) {
        getsellersideshoppfeedback.value?.data?.feedback
            ?.addAll(value?.data?.feedback ?? []);
        sellersidefeedbackfiltervalue.value = filter;
        reasonfeedbackcontroller();
      } else {
        getsellersideshoppfeedback.value = value;
        sellersidefeedbackfiltervalue.value = filter;
        reasonfeedbackcontroller();
      }
      sellershopfeedbackspage.value++;
      getsellersideshopfeedbackloading.value = false;
      getsellersideshopfeedbackreloading.value = false;
    } catch (e) {
      getsellersideshopfeedbackreloading.value = false;
      getsellersideshopfeedbackloading.value = false;
    }
  }

////////// reply feedback api
  Map<int, TextEditingController> replyfeedbackControllers = {};
  void reasonfeedbackcontroller() {
    for (int i = 0;
        i < (getsellersideshoppfeedback.value?.data?.feedback?.length ?? 0);
        i++) {
      replyfeedbackControllers[i] = TextEditingController();
    }
  }

////////reply seller feedback
  final RxBool replysellerfeedbackloading = false.obs;
  Future<void> replySellerFeeback({
    required int id,
    required String reply,
  }) async {
    try {
      replysellerfeedbackloading.value = true;
      await storeRepo.replysellerFeedback(
          id: id.toString(), comment: reply.toString());

      replysellerfeedbackloading.value = false;
    } finally {
      replysellerfeedbackloading.value = false;
    }
  }

/////////update seller shop data
  var updatesellershopmainimage = Rx<File?>(null);
  // Map<int, RxBool> iseditreplyfeedback = {};
  // void iseditreplylist() {
  //   iseditreplyfeedback.clear(); // Optional: clear the map if needed
  //   for (int i = 0;
  //       i < (getsellersideshoppfeedback.value?.data?.feedback?.length ?? 0);
  //       i++) {
  //     iseditreplyfeedback[i] = RxBool(false);
  //     print("Key $i added to iseditreplyfeedback map.");
  //   }
  // }

  // iseditreplyfeedbacktrue(int index) {
  //   if (iseditreplyfeedback.containsKey(index)) {
  //     iseditreplyfeedback[index]?.value = true;
  //   } else {
  //     print("Key $index not found in iseditreplyfeedback.");
  //   }
  // }

  Future<void> updateSellershopmainimage(BuildContext context) async {
    final File? pickedImage = await pickImage(context);
    if (pickedImage != null) {
      updatesellershopmainimage(File(pickedImage.path));
    }
  }

  var updatesellershopcoverimage = Rx<File?>(null);
  Future<void> updateSellershopcoverimage(BuildContext context) async {
    final File? pickedImage = await pickImage(context);
    if (pickedImage != null) {
      updatesellershopcoverimage(File(pickedImage.path));
    }
  }

  RxList<SelectCategory> updateshopselectedCategories = <SelectCategory>[].obs;
  RxList<int> updateshopselectedCategoriesIds = <int>[].obs;
  void updateSellershopremoveCategory(int index) {
    if (index >= 0 && index < updateshopselectedCategories.length) {
      updateshopselectedCategories.removeAt(index);
      updateshopselectedCategoriesIds.removeAt(index);
    }
  }

  // void updateSellerremoveCategoryIds(int index) {
  //   if (index >= 0 && index < updateshopselectedCategoriesIds.length) {
  //     updateshopselectedCategoriesIds.removeAt(index);
  //   }
  //    print("Removed Categories Id:${updateshopselectedCategoriesIds}");
  // }

  var updatesellershopuploadedbannerimages = RxList<File?>([]);
  void updateshopremovebannerImage(int index) {
    updatesellershopuploadedbannerimages.removeAt(index);
  }

  RxList<int> updateshopremovedbannersimage = <int>[].obs;
  void updateshopremovegetbannerImage(int index, int id) {
    getsellershopprofiledata.update((value) {
      value?.data?.sellerData?.banners?.removeAt(index);
    });
    updateshopremovedbannersimage.add(id);
  }

  getsellershopcategoriesandstore() {
    updateshopselectedCategories.addAll(getsellershopprofiledata
        .value!.data!.sellerData!.categories!
        .map((categorydata) => SelectCategory(
            id: categorydata.id ?? 0,
            name: categorydata.name ?? "",
            image: categorydata.media?.first.originalUrl ??
                AppConstants.noimage)));
    updateshopselectedCategoriesIds.addAll(getsellershopprofiledata
        .value!.data!.sellerData!.categories!
        .map((categorydata) => categorydata.id ?? 0));
  }

  var updatesellershopuploadbannerimages = RxList<File?>([]);
  void updatesellerShopremovebannerImage(int index) {
    updatesellershopuploadbannerimages.removeAt(index);
  }

  Future<void> updatesellershopUploadBanner(BuildContext context) async {
    final File? pickedImage = await pickImage(context);
    if (pickedImage != null) {
      updatesellershopuploadbannerimages.add(pickedImage);
    }
  }

  final updateshopnamecontroller = TextEditingController().obs;
  final updateshopwhatyousellcontroller = TextEditingController().obs;
  final updateshopregistrationnumcontroller = TextEditingController().obs;
  final updateshopphonenumbercontroller = TextEditingController().obs;
  final updateaboutshopcontroller = TextEditingController().obs;
  final updateshopshippingdomesticcontroller = TextEditingController().obs;
  final updateshopshippingnationcontroller = TextEditingController().obs;
  final updateshopphonecode = ''.obs;
  final updateshopphonecountrycode = ''.obs;
  final RxBool updatesellershoploading = false.obs;
  Future<void> updateSellerShop({
    required BuildContext context,
    required String address,
    required String city,
    required String state,
    required String country,
    required String zipcode,
  }) async {
    try {
      updatesellershoploading.value = true;
      await storeRepo.updateSellershop(
          shippingdomestic:
              updateshopshippingdomesticcontroller.value.text.isEmpty
                  ? getsellershopprofiledata
                          .value?.data?.sellerData?.shippingdomestic ??
                      ''
                  : updateshopshippingdomesticcontroller.value.text.toString(),
          shippingnation: updateshopshippingnationcontroller.value.text.isEmpty
              ? getsellershopprofiledata.value?.data?.sellerData?.shippingnation ??
                  ''
              : updateshopshippingnationcontroller.value.text.toString(),
          context: context,
          name: updateshopnamecontroller.value.text.isEmpty
              ? getsellershopprofiledata.value?.data?.sellerData?.shopName ?? ''
              : updateshopnamecontroller.value.text.toString(),
          address: address.isEmpty
              ? getsellershopprofiledata.value?.data?.sellerData?.address ?? ''
              : address,
          city: city.isEmpty
              ? getsellershopprofiledata.value?.data?.sellerData?.city ?? ''
              : city,
          state: state.isEmpty
              ? getsellershopprofiledata.value?.data?.sellerData?.state ?? ''
              : state,
          country: country.isEmpty
              ? getsellershopprofiledata.value?.data?.sellerData?.country ?? ''
              : country,
          zipcode: zipcode.isEmpty
              ? getsellershopprofiledata.value?.data?.sellerData?.zipCode ?? ''
              : zipcode,
          phonecode: updateshopphonecode.value.isEmpty
              ? getsellershopprofiledata.value?.data?.sellerData?.phoneCode ??
                  ''
              : updateshopphonecode.value.toString(),
          phonenumber: updateshopphonenumbercontroller.value.text.isEmpty
              ? getsellershopprofiledata.value?.data?.sellerData?.phoneNumber ?? ''
              : updateshopphonenumbercontroller.value.text.toString(),
          phonecountrycode: updateshopphonecountrycode.value.isEmpty ? getsellershopprofiledata.value?.data?.sellerData?.phoneCountryCode ?? '' : updateshopphonecountrycode.value.toString(),
          whatyousell: updateshopwhatyousellcontroller.value.text.isEmpty ? getsellershopprofiledata.value?.data?.sellerData?.sell ?? '' : updateshopwhatyousellcontroller.value.text.toString(),
          registrationnumber: updateshopregistrationnumcontroller.value.text.isEmpty ? getsellershopprofiledata.value?.data?.sellerData?.registrationNumber ?? '' : updateshopregistrationnumcontroller.value.text.toString(),
          description: updateaboutshopcontroller.value.text.isEmpty ? getsellershopprofiledata.value?.data?.sellerData?.shopDescription ?? '' : updateaboutshopcontroller.value.text.toString(),
          categories: updateshopselectedCategoriesIds,
          mainimage: updatesellershopmainimage.value,
          coverimage: updatesellershopcoverimage.value,
          bannersimages: updatesellershopuploadbannerimages,
          deletedids: updateshopremovedbannersimage);

      updatesellershoploading.value = false;
    } finally {
      updatesellershoploading.value = false;
    }
  }

///////////discount coupons
  RxInt discountcouponboxcolor = 1.obs;
  updatediscountcouponboxcolor(int index) {
    discountcouponboxcolor.value = index;
  }

///////////////get faq
  final Rx<FaqModel?> getsellerfaq = Rx<FaqModel?>(null);
  final RxBool getsellerfaqloading = false.obs;
  getFaq() async {
    try {
      getsellerfaqloading(true);
      await storeRepo.getSellerFaq().then((value) {
        getsellerfaq.value = value;
        getsellerfaqloading(false);
      });
    } catch (e) {
      getsellerfaqloading(false);
    }
  }

///////////////get privacy policy api
  final Rx<PrivayPolicyModel?> getsellerprivacypolicy =
      Rx<PrivayPolicyModel?>(null);
  final RxBool getsellerprivacypolicyloading = false.obs;
  getSellerPrivacyPolicy() async {
    try {
      getsellerprivacypolicyloading(true);
      await storeRepo.getSellerPrivacyPolicy().then((value) {
        getsellerprivacypolicy.value = value;
        getsellerprivacypolicyloading(false);
      });
    } catch (e) {
      getsellerprivacypolicyloading(false);
    }
  }

///////////select coupon date
  Future<String?> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      return "${picked.year}-${picked.month}-${picked.day}";
    }
    return null;
  }

///////create coupon api
  final selectstartdate = TextEditingController().obs;
  final selectenddate = TextEditingController().obs;
  final createcouponname = TextEditingController().obs;
  final createcouponcode = TextEditingController().obs;
  final createminorder = TextEditingController().obs;
  final creatediscount = TextEditingController().obs;

  RxBool createcouponloading = false.obs;
  Future<void> createCoupon() async {
    try {
      createcouponloading.value = true;
      await storeRepo
          .creatCoupon(
              title: createcouponname.value.text.toString(),
              code: createcouponcode.value.text.toString(),
              startdate: selectstartdate.value.text.toString(),
              enddate: selectenddate.value.text.toString(),
              discount: creatediscount.value.text.toString(),
              minorder: createminorder.value.text.toString())
          .then((value) => getCoupon());

      createcouponloading.value = false;
    } finally {
      createcouponloading.value = false;
    }
  }

///////////////get coupons api
  final Rx<GetCouponModel?> getcoupons = Rx<GetCouponModel?>(null);
  final RxBool getcouponsloading = false.obs;
  getCoupon() async {
    try {
      getcouponsloading(true);
      await storeRepo.getCoupon().then((value) {
        getcoupons.value = value;
        getcouponsloading(false);
      });
    } catch (e) {
      getcouponsloading(false);
    }
  }

///////////////get coupons by id api
  final Rx<GetCouponByIdModel?> getcouponsbyid = Rx<GetCouponByIdModel?>(null);
  final RxBool getcouponsbyidloading = false.obs;
  getCouponById(String id) async {
    try {
      getcouponsbyidloading(true);
      await storeRepo.getCouponById(id).then((value) {
        getcouponsbyid.value = value;
        getcouponsbyidloading(false);
      });
    } catch (e) {
      getcouponsbyidloading(false);
    }
  }

///////update coupon api
  final updatecouponstartdate = TextEditingController().obs;
  final updatecouponenddate = TextEditingController().obs;
  final updatecouponname = TextEditingController().obs;
  final updatecouponcode = TextEditingController().obs;
  final updatecouponminorder = TextEditingController().obs;
  final updatecoupondiscount = TextEditingController().obs;
  RxBool updatecouponloading = false.obs;
  Future<void> updateCoupon() async {
    try {
      updatecouponloading.value = true;
      await storeRepo
          .updateCoupon(
              id: getcouponsbyid.value?.data?.id.toString() ?? "",
              title: updatecouponname.value.text.isEmpty
                  ? getcouponsbyid.value?.data?.title.toString() ?? ""
                  : updatecouponname.value.text.toString(),
              code: updatecouponcode.value.text.isEmpty
                  ? getcouponsbyid.value?.data?.code.toString() ?? ""
                  : updatecouponcode.value.text.toString(),
              startdate: updatecouponstartdate.value.text.isEmpty
                  ? getcouponsbyid.value?.data?.startDate.toString() ?? ""
                  : updatecouponstartdate.value.text.toString(),
              enddate: updatecouponenddate.value.text.isEmpty
                  ? getcouponsbyid.value?.data?.endDate.toString() ?? ""
                  : updatecouponenddate.value.text.toString(),
              discount: updatecoupondiscount.value.text.isEmpty
                  ? getcouponsbyid.value?.data?.discount.toString() ?? ""
                  : updatecoupondiscount.value.text.toString(),
              minorder: updatecouponminorder.value.text.isEmpty
                  ? getcouponsbyid.value?.data?.minOrder.toString() ?? ""
                  : updatecouponminorder.value.text.toString())
          .then((value) => getCoupon());

      updatecouponloading.value = false;
    } finally {
      updatecouponloading.value = false;
    }
  }

/////delete coupon api
  RxBool deletecouponloading = false.obs;
  Future<void> deleteCoupon(String id) async {
    try {
      deletecouponloading.value = true;
      await storeRepo.deleteCoupon(id: id);

      deletecouponloading.value = false;
    } finally {
      deletecouponloading.value = false;
    }
  }

/////////////get wallet transection api
  final Rx<TransectionModel?> getwallettransections =
      Rx<TransectionModel?>(null);
  final RxBool getwallettransectionsloading = false.obs;
  final RxBool getwallettransectionsreloadloading = false.obs;
  final RxInt walletpage = 1.obs;
  final RxString selectedtransectionstatus = "".obs;
  Future<void> getWalletTransections(String status) async {
    selectedtransectionstatus.value = status;
    if (getwallettransectionsreloadloading.value ||
        getwallettransectionsloading.value) return;
    if (walletpage.value > 1 &&
        walletpage.value >
            (getwallettransections.value?.data?.pagination?.totalPages ?? 0)) {
      return;
    }

    try {
      walletpage.value > 1
          ? getwallettransectionsreloadloading.value = true
          : getwallettransectionsloading.value = true;
      final value = await storeRepo.getWalletTransection(walletpage.value,status);
      if (walletpage.value > 1) {
        getwallettransections.value?.data?.transactions
            ?.addAll(value?.data?.transactions ?? []);
      } else {
        getwallettransections.value = value;
      }
      walletpage.value++;
      getwallettransectionsreloadloading.value = false;
      getwallettransectionsloading.value = false;
    } catch (e) {
      getwallettransectionsreloadloading.value = false;
      getwallettransectionsloading.value = false;
    }
  }

/////withdraw amount request api
  RxBool withdrawamountloading = false.obs;
  final withdrawamountcontroller = TextEditingController().obs;
  final withdrawformkey = GlobalKey<FormState>();
  Future<void> withDrawAmount(String id) async {
    try {
      withdrawamountloading.value = true;
      await storeRepo.withDrawAmount(
          amount: withdrawamountcontroller.value.text.toString());

      withdrawamountloading.value = false;
    } finally {
      withdrawamountloading.value = false;
    }
  }
}
