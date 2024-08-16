import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/models/categoriessearchbykey_model.dart';
import 'package:smsseller/models/selectcategory_model.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/repositries/storerepo.dart';
// import 'package:sms/views/seller/sellerchatlistscreen.dart';
import 'package:smsseller/repositries/storerepo.dart';
import 'package:smsseller/seller/sellerchatlistscreen.dart';

class StoreController extends GetxController {
  StoreRepo storeRepo;

  StoreController({required this.storeRepo});
  @override
  void onInit() async {
    super.onInit();
    searchcategorykeycontroller.value.addListener(() {
      getCategoriesSearchbykey(
          searchcategorykeycontroller.value.text.toString());
    });
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
  var todaysalesselectedmonth = "January".obs;
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

  var itemssoldselectedmonth = "January".obs;

  ////////////////seller order history container selection logic
  RxInt issellerselectedOrdercount = 1.obs;

  void setsellerSelectedOrdercount(int orderIndex) {
    issellerselectedOrdercount.value = orderIndex;
  }
///////////seller order history active orders list

  List<Map<String, dynamic>> selleractiveorderslist = [
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage1.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Pending'
    },
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage2.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Pending'
    },
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage3.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Pending'
    },
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage1.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Pending'
    },
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage2.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Pending'
    },
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage3.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Pending'
    },
  ];

//////////seller orderhistory completed orders list
  List<Map<String, dynamic>> sellercompletedorderslist = [
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage1.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Delivered'
    },
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage2.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Delivered'
    },
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage3.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Delivered'
    },
  ];

//////////seller orderhistory refunded orders list
  List<Map<String, dynamic>> sellerrefundorderslist = [
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage1.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Delivered'
    },
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage2.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Delivered'
    },
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage3.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Delivered'
    },
    {
      "orderid": "Order #: 15s5d8e1",
      "image": "assets/images/orderhistoryproductimage1.png",
      "productname":
          'Originals Gamepad Edition Men\'s Stan Cream  US 7 #GX6394',
      "orderstatus": 'Delivered'
    },
  ];

  // seller orderhistory orderslist show logic
  List<Map<String, dynamic>> getSelectedsellerOrderList() {
    switch (issellerselectedOrdercount.value) {
      case 1:
        return selleractiveorderslist;
      case 2:
        return sellercompletedorderslist;
      case 3:
        return sellerrefundorderslist;
      default:
        return selleractiveorderslist;
    }
  }

// seller orderhistory viewdetails button logic
  ontapsellerorderhistoryviewdetailsbutton() {
    switch (issellerselectedOrdercount.value) {
      case 1:
        return RouteConstants.selleractiveorderdetailsscreen;
      case 2:
        return RouteConstants.sellercompletedorderdetailsscreen;
      case 3:
        return RouteConstants.sellerrefundorderdetailsscreen;
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
  final createshopphonecode = ''.obs;
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
        context: context, 
        name: shopnamecontroller.value.text.toString(), 
        address: address, 
        city: city, 
        state: state, 
        country: country, 
        zipcode: zipcode, 
        phonecode:createshopphonecode.toString(), 
        phonenumber: phonenumbercontroller.value.text.toString(), 
        whatyousell: whatyousellcontroller.value.text.toString(), 
        registrationnumber: shopnamecontroller.value.text.toString(), 
        description: "", 
        categories: createshopselectedCategoryIds, 
        mainimage: sellercreateshopuploadedprofileImage.value, 
        coverimage: sellersetupshopuploadedcoverImage.value,
         bannersimages: sellersetupshopuploadedbannerimages);

      sellercreateshoploading.value = false;
    } finally {
      sellercreateshoploading.value = false;
    }
  }

}




