import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:smsseller/constants/route_constants.dart';
// import 'package:sms/constants/route_constants.dart';
// import 'package:sms/repositries/authenication_repo.dart';
// import 'package:sms/views/chats/chatslistscreen.dart';
import 'package:smsseller/repositries/authenication_repo.dart';
import 'package:smsseller/seller/sellerchatlistscreen.dart';

class HomeGuestController extends GetxController {
  final AuthRepo authRepo;
  HomeGuestController({required this.authRepo});

  @override
  void onInit() {
    super.onInit();
  }

  ///////////guesthomefavourite hot sell products logic
  void tapguesthomehotsellproductsFavorite(Map<String, dynamic> productData) {
    bool isFavorite = productData['isfavourite'] ?? false;
    isFavorite = !isFavorite;
    productData['isfavourite'] = isFavorite;
    hotsellproductslist.refresh();
  }

  /////////////homeguest hot sell products
  RxList<Map<String, dynamic>> hotsellproductslist =
      RxList<Map<String, dynamic>>([
    {
      "name": "The north coat",
      "isfavourite": false,
      "image": 'assets/images/hotsellproduct1.png',
      "ratings": "(65)",
      "off": "50%",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gucci Bag",
      "isfavourite": false,
      "image": 'assets/images/hotsellproduct2.png',
      "ratings": "(65)",
      "off": "50%",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "RGB Liquid",
      "isfavourite": false,
      "image": 'assets/images/hotsellproduct3.png',
      "ratings": "(65)",
      "off": "50%",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Book Self",
      "isfavourite": false,
      "image": 'assets/images/hotsellproduct4.png',
      "ratings": "(65)",
      "off": "50%",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gucci Bag",
      "isfavourite": false,
      "image": 'assets/images/hotsellproduct2.png',
      "ratings": "(65)",
      "off": "50%",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "RGB Liquid",
      "isfavourite": false,
      "image": 'assets/images/hotsellproduct3.png',
      "ratings": "(65)",
      "off": "50%",
      "price": "\$260",
      "discountprice": "\$360"
    },
  ]);

///////////////////home guest top selling products
/////////////top selling products
  RxList<Map<String, dynamic>> topsellproductslist =
      RxList<Map<String, dynamic>>([
    {
      "name": "GamePad",
      "isfavourite": false,
      "image": 'assets/images/hometopsellingproduct1.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Keyboard",
      "isfavourite": false,
      "image": 'assets/images/hometopsellingproduct2.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "LED",
      "isfavourite": false,
      "image": 'assets/images/hometopsellingproduct3.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "GamePad",
      "isfavourite": false,
      "image": 'assets/images/hometopsellingproduct1.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Keyboard",
      "isfavourite": false,
      "image": 'assets/images/hometopsellingproduct2.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "LED",
      "isfavourite": false,
      "image": 'assets/images/hometopsellingproduct3.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
  ]);
  ///////////guesthomefavourite TOP sell products logic
  void tapguesthometopsellproductsFavorite(
      Map<String, dynamic> topsellproductsdata) {
    bool isFavorite = topsellproductsdata['isfavourite'] ?? false;
    isFavorite = !isFavorite;
    topsellproductsdata['isfavourite'] = isFavorite;
    topsellproductslist.refresh();
  }

/////////////home guest exploreourproducts
  RxList<Map<String, dynamic>> exploreourproductslist =
      RxList<Map<String, dynamic>>([
    {
      "name": "Dog Food",
      "isfavourite": false,
      "image": 'assets/images/homeexploreproduct1.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Camera",
      "isfavourite": false,
      "image": 'assets/images/homeexploreproduct2.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Kid Car",
      "isfavourite": false,
      "image": 'assets/images/homeexploreproduct3.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Shoes",
      "isfavourite": false,
      "image": 'assets/images/homeexploreproduct4.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Gamepad",
      "isfavourite": false,
      "image": 'assets/images/homeexploreproduct5.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
    {
      "name": "Jacket",
      "isfavourite": false,
      "image": 'assets/images/homeexploreproduct6.png',
      "ratings": "(65)",
      "price": "\$260",
      "discountprice": "\$360"
    },
  ]);

  ///////////guesthomefavourite exploreour products logic
  void tapguesthomeexploreourproductsFavorite(
      Map<String, dynamic> exploreourproducts) {
    bool isFavorite = exploreourproducts['isfavourite'] ?? false;
    isFavorite = !isFavorite;
    exploreourproducts['isfavourite'] = isFavorite;
    exploreourproductslist.refresh();
  }

////////productdetail qunatity logic
  RxInt productdetailquantity = 1.obs;
  addproductdetailquantity() {
    productdetailquantity++;
  }

  removeproductdetailquantity() {
    if (productdetailquantity > 1) {
      productdetailquantity--;
    }
  }

////////productdetail color dropdown
  var selectedproductdetailcolor = "Red";
  final List<String> productdetailcolor = [
    "Red",
    "Black",
    "Blue",
  ];

////////productdetail size dropdown
  var selectedproductdetailsize = "Small";
  final List<String> productdetailsize = [
    "Small",
    "Large",
    "Medium",
  ];

/////productdetail favourite logic
  RxBool productdetailisfavourite = false.obs;

  productdetailfavourite() {
    productdetailisfavourite.value = !productdetailisfavourite.value;
  }

/////productdetail save seller  logic
  RxBool productdetailissaveseller = false.obs;

  productdetailsaveseller() {
    productdetailissaveseller.value = !productdetailissaveseller.value;
  }

/////search save search  logic
  RxBool issavesearch = false.obs;

  updatesavesearch() {
    issavesearch.value = !issavesearch.value;
  }

/////////homeguest category selected logic
  RxInt homeguestselectedCategoryIndex = RxInt(0);

  int get selectedCategoryIndex => homeguestselectedCategoryIndex.value;

  set selectedCategoryIndex(int index) {
    homeguestselectedCategoryIndex.value = index;
    update();
  }

  ////////search filters categories
  String? selectedsearchfilterscategories;
  final List<String> searchfilterscategories = [
    "Electronics",
    "Accessories ",
    "Watches",
  ];

  ////////search filters brands
  String? selectedsearchfiltersbrands;
  final List<String> searchfiltersbrands = [
    "Louis Vuitton",
    "Gucci ",
    "Chanel",
  ];

  ////search filter condition check box logic
// all condition
  RxBool searchfilterconditionall = false.obs;
  void updatesearchfilterconditionall(bool? newValue) {
    searchfilterconditionall.value = newValue!;
  }

// brandnew condition
  RxBool searchfilterconditionbrandnew = false.obs;
  void updatesearchfilterconditionbrandnew(bool? newValue) {
    searchfilterconditionbrandnew.value = newValue!;
  }

// Used condition
  RxBool searchfilterconditionUsed = false.obs;
  void updatesearchfilterconditionUsed(bool? newValue) {
    searchfilterconditionUsed.value = newValue!;
  }

////search filter deliverylocation check box logic
// worldwide condition
  RxBool searchfilterdeliverylocationworldwide = false.obs;
  void updatesearchfilterdeliverylocationworldwide(bool? newValue) {
    searchfilterdeliverylocationworldwide.value = newValue!;
  }

// Asia condition
  RxBool searchfilterdeliverylocationAsia = false.obs;
  void updatesearchfilterdeliverylocationAsia(bool? newValue) {
    searchfilterdeliverylocationAsia.value = newValue!;
  }

// Europe condition
  RxBool searchfilterdeliverylocationEurope = false.obs;
  void updatesearchfilterdeliverylocationEurope(bool? newValue) {
    searchfilterdeliverylocationEurope.value = newValue!;
  }

  // America condition
  RxBool searchfilterconditionAmerica = false.obs;
  void updatesearchfilterdeliverylocationAmerica(bool? newValue) {
    searchfilterconditionAmerica.value = newValue!;
  }

  // Africa condition
  RxBool searchfilterdeliverylocationAfrica = false.obs;
  void updatesearchfilterdeliverylocationAfrica(bool? newValue) {
    searchfilterdeliverylocationAfrica.value = newValue!;
  }

  // Oceana condition
  RxBool searchfilterdeliverylocationOceana = false.obs;
  void updatesearchfilterdeliverylocationOceana(bool? newValue) {
    searchfilterdeliverylocationOceana.value = newValue!;
  }

  ///////////search filter price range
  Rx<RangeValues> currentRangeValues = RangeValues(0, 0).obs;

  void updatesearchfilterpriceRangeValues(RangeValues values) {
    currentRangeValues.value = values;
  }

  ///////addressbook checkboxlogic

  var addressbookselectaddresscheckbox = (-1).obs;

  void updateaddressbookselectaddresscheckbox(int index) {
    if (addressbookselectaddresscheckbox.value == index) {
      addressbookselectaddresscheckbox.value = -1;
    } else {
      addressbookselectaddresscheckbox.value = index;
    }
  }

  ////////////profile setting upload profile image
  var profilesettinguploadedprofileImage = Rx<File?>(null);

  void profilesettingsetprofileImage(File? image) {
    profilesettinguploadedprofileImage.value = image;
  }

  Future<void> profileuploadprofileimage(BuildContext context) async {
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
        profilesettingsetprofileImage(File(pickedFile.path));
      }
    }
  }

  ///////////address book screeen3 add new addrs slect adres type container logic
  var addnewaddresselecradrestype = 0.obs;

  void updataddnewaddresselectadrestype(int index) {
    addnewaddresselecradrestype.value = index;
  }

  //////////payment setting choose payment method container color logic
  var choosepaymentmethod = 0.obs;

  void updatechoosepaymentmethod(int index) {
    choosepaymentmethod.value = index;
  }

  ////////////////chats list remove logic
  ////chatslist
  RxList<ChatsList> chatslist = [
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
  void chatslistremove(int index) {
    chatslist.removeAt(index);
  }

  /////////////payment method add card screen favourite logic
  RxBool paymentmethodaddcardfavouriteicon = false.obs;
  void updatepaymentmethodaddcardfavouriteicon() {
    paymentmethodaddcardfavouriteicon.value =
        !paymentmethodaddcardfavouriteicon.value;
  }

  //////////addnew card payment method container color logic
  var addnewcardpaymentmethod = 0.obs;

  void updateaddnewcardpaymentmethod(int index) {
    addnewcardpaymentmethod.value = index;
  }

  ////addnewcard payment method expirydate

  var expirydateaddnewcardpaymentmethod = Rxn<DateTime>();

  void updateexpirydateaddnewcardpaymentmethod(DateTime date) {
    expirydateaddnewcardpaymentmethod.value = date;
  }

/////////////////addnewcard remeber this card for future orders

  RxBool remeberthiscardforfutureordersaddnewcard = false.obs;

  updateremeberthiscardforfutureordersaddnewcard(bool value) {
    remeberthiscardforfutureordersaddnewcard.value = value;
  }

  ///////////seller dashboard months dropdown list
  var usertodayspendingselectedmonth = "January".obs;
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

  var useritempurchaseselectedmonth = "January".obs;

//////////USER ORDER HISTORY
  ////////////////USER order history container selection logic
  RxInt isuserselectedOrdercount = 1.obs;

  void setuserSelectedOrdercount(int orderIndex) {
    isuserselectedOrdercount.value = orderIndex;
  }
///////////user order history active orders list

  List<Map<String, dynamic>> useractiveorderslist = [
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

//////////user orderhistory completed orders list
  List<Map<String, dynamic>> usercompletedorderslist = [
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

//////////user orderhistory refunded orders list
  List<Map<String, dynamic>> userrefundorderslist = [
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

  // user orderhistory orderslist show logic
  List<Map<String, dynamic>> getSelecteduserOrderList() {
    switch (isuserselectedOrdercount.value) {
      case 1:
        return useractiveorderslist;
      case 2:
        return usercompletedorderslist;
      case 3:
        return userrefundorderslist;
      default:
        return useractiveorderslist;
    }
  }

// user orderhistory viewdetails button logic
  ontapuserorderhistoryviewdetailsbutton() {
    switch (isuserselectedOrdercount.value) {
      case 1:
        return RouteConstants.useractiveorderdetails;
      case 2:
        return RouteConstants.usercompletedorderdetails;
      case 3:
        return RouteConstants.userrefundorderdetails;
    }
  }
}
