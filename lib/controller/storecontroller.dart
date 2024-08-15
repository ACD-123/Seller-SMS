import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smsseller/constants/route_constants.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/repositries/storerepo.dart';
// import 'package:sms/views/seller/sellerchatlistscreen.dart';
import 'package:smsseller/repositries/storerepo.dart';
import 'package:smsseller/seller/sellerchatlistscreen.dart';

class StoreController extends GetxController {
  StoreRepo storeRepo;

  StoreController({required this.storeRepo});

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
  void sellersetupshopremoveCategory(int index) {
    sellersetupshopaddcategoriesList.removeAt(index);
  }

/////////////////////seller setup shop add banner  images

  var sellersetupshopuploadedbannerimages = Rx<File?>(null);

  void sellersetupshopbannerimages(File? image) {
    sellersetupshopuploadedbannerimages.value = image;
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
        sellersetupshopbannerimages(File(pickedFile.path));
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
}
