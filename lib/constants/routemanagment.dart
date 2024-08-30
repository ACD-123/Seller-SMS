import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/seller/authentication/changepassword.dart';
import 'package:smsseller/seller/authentication/createaccount.dart';
import 'package:smsseller/seller/authentication/emailverification.dart';
import 'package:smsseller/seller/authentication/forgotemailverification.dart';
import 'package:smsseller/seller/authentication/forgotpassword.dart';
import 'package:smsseller/seller/authentication/loginscreen.dart';
import 'package:smsseller/seller/authentication/setprofile.dart';
import 'package:smsseller/seller/banksetting.dart';
import 'package:smsseller/seller/inventoryseller.dart';
import 'package:smsseller/seller/onboarding/welcome_screen1.dart';
import 'package:smsseller/seller/orderdetailsscreen.dart';
import 'package:smsseller/seller/pendingorderdetailsscreen.dart';
import 'package:smsseller/seller/productsdetail_screen.dart';
import 'package:smsseller/seller/selleractiveorderdetails.dart';
import 'package:smsseller/seller/sellerbankaccountsetting.dart';
import 'package:smsseller/seller/sellerchatscreen.dart';
import 'package:smsseller/seller/sellercompletedorderdetails.dart';
import 'package:smsseller/seller/sellercreateshopscreen.dart';
import 'package:smsseller/seller/sellerdashboard.dart';
import 'package:smsseller/seller/sellerorderhistoryscreen.dart';
import 'package:smsseller/seller/sellerprofilescreen.dart';
import 'package:smsseller/seller/sellerrefundorderdetails.dart';
import 'package:smsseller/seller/sellersalesreportscreen.dart';
import 'package:smsseller/seller/sellersettingscreen.dart';
import 'package:smsseller/seller/sellersetuppassword.dart';
import 'package:smsseller/seller/sellersetupshop.dart';
import 'package:smsseller/seller/sellersideshop.dart';
import 'package:smsseller/seller/sellerupdateshopdetail.dart';
import 'package:smsseller/seller/sellerupdateshopscreen.dart';
import 'package:smsseller/seller/sellerwelcomescreen.dart';
import 'package:smsseller/seller/splashscreen.dart';
import 'package:smsseller/seller/steppper.dart';
import 'package:smsseller/seller/updatestepper.dart';

import '../seller/sellerchatlistscreen.dart';

class RouteGenerator {
  static List<GetPage> getPages() {
    return [
      // GetPage(name: RouteConstants.bottomnavbar, page: () => BottomNavBar()),
      GetPage(
        name: RouteConstants.splashscreen,
        page: () => const SplashScreen(),
      ),
      // GetPage(
      //   name: RouteConstants.splashscreen,
      //   page: () => const SplashScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.customershop,
      //   page: () => CustomerSellerShop(),
      // ),
      GetPage(
        name: RouteConstants.sellersideshop,
        page: () => SellerSideShop(),
      ),
      GetPage(
        name: RouteConstants.banksetting,
        page: () => const BankSetting(),
      ),
      GetPage(
        name: RouteConstants.welcome1,
        page: () => WelcomeScreen1(),
      ),
      GetPage(
        name: RouteConstants.selerwelcome,
        page: () => const SellerWelcomeScreen(),
      ),
      GetPage(
        name: RouteConstants.sellercreateshopscreen,
        page: () => const SellerCreateShopScreen(),
      ),
      GetPage(
        name: RouteConstants.sellersetupshop,
        page: () => const SellerSetupShop(),
      ),
      // GetPage(name: RouteConstants.privacypolicy, page: () => PrivacyPolicy()),
      // GetPage(
      //   name: RouteConstants.welcome1,
      //   page: () => WelcomeScreen1(),
      // ),
      // GetPage(
      //   name: RouteConstants.faq,
      //   page: () => Faq(),
      // ),
      GetPage(
        name: RouteConstants.loginscreen,
        page: () => const LoginScreen(),
      ),
      GetPage(
        name: RouteConstants.forgotemailverification,
        page: () => ForgotEmailverification(),
      ),
      // GetPage(name: RouteConstants.feedback, page: () => FeedBack()),
      GetPage(
        name: RouteConstants.emailverificaiton,
        page: () => Emailverification(),
      ),
      GetPage(
        name: RouteConstants.forgot,
        page: () => ForgotPasswordScreens(),
      ),
      GetPage(
        name: RouteConstants.signup,
        page: () => Signup(),
      ),
      // GetPage(
      //   name: RouteConstants.checkout,
      //   page: () => Checkout(),
      // ),
      // GetPage(
      //   name: RouteConstants.userfeedback,
      //   page: () => UserFeedback(),
      // ),
      // GetPage(
      //   name: RouteConstants.addnewcard,
      //   page: () => AddNewCard(),
      // ),
      // GetPage(
      //   name: RouteConstants.addtocart,
      //   page: () => AddToCart(),
      // ),
      GetPage(
        name: RouteConstants.setyourprofile,
        page: () => SetYourProfile(),
      ),
      // GetPage(
      //   name: RouteConstants.reasonreport,
      //   page: () => ReportSeller(),
      // ),
      GetPage(
        name: RouteConstants.changepassword,
        page: () => ChangePassword(),
      ),
      // GetPage(
      //   name: RouteConstants.setyourprofile,
      //   page: () => SetYourProfile(),
      // ),
      // GetPage(
      //   name: RouteConstants.splashscreen,
      //   page: () => const SplashScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.welcome1,
      //   page: () => WelcomeScreen1(),
      // ),
      // GetPage(
      //   name: RouteConstants.splashscreen,
      //   page: () => const SplashScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.welcome1,
      //   page: () => WelcomeScreen1(),
      // ),
      // GetPage(
      //   name: RouteConstants.homeguestscreen,
      //   page: () => const HomeGuestScreen(),
      // ),
      GetPage(
        name: RouteConstants.stepper,
        page: () => MyStepperApp(),
      ),
       GetPage(
        name: RouteConstants.updatestepper,
        page: () => UpdateStepper(),
      ),
      GetPage(
        name: RouteConstants.productpreviewscreen,
        page: () => const ProductPreviewScreen(),
      ),
      // GetPage(
      //   name: RouteConstants.searchscreen,
      //   page: () => const SearchScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.categoriesscreen,
      //   page: () => const CategoriesScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.searchfilterscreen,
      //   page: () => const SearchFilterScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.myprofilescreen,
      //   page: () => const MyProfileScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.profilesettingscreen,
      //   page: () => const ProfileSettingScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.changepasswordscreen,
      //   page: () => const ChangePasswordScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.addressbookscreen,
      //   page: () => const AddressBookScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.addressbookscreen3,
      //   page: () => const AddressBookScreen3(),
      // ),
      // GetPage(
      //   name: RouteConstants.addressbookscreen2viewmap,
      //   page: () => const AddressBookScreen2ViewMap(),
      // ),
      // GetPage(
      //   name: RouteConstants.paymentmethodscreen,
      //   page: () => const PaymentSetting_PaymentMethodsScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.returncancellationscreen,
      //   page: () => const ReturnCancellationScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.wishlistscreen,
      //   page: () => const WishListScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.myprofilecontactus,
      //   page: () => const MyProfileContactus(),
      // ),
      // GetPage(
      //   name: RouteConstants.notificationscreens,
      //   page: () => const NotificationsScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.settingscreen,
      //   page: () => const SettingScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.notificationsetting,
      //   page: () => const NotificationsSettingScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.settingcontactusscreen,
      //   page: () => const SettingContactUsScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.helpsupportscreen,
      //   page: () => const HelpSupportScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.helpsupportscreen2,
      //   page: () => const HelpSupportScreen2(),
      // ),
      // GetPage(
      //   name: RouteConstants.chatslistscreen,
      //   page: () => ChatsListScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.chatscreen,
      //   page: () => const ChatScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.addnewcardpaymentmethod,
      //   page: () => AddNewCardPaymentMethod(),
      // ),
      // GetPage(
      //   name: RouteConstants.homeuserscreen,
      //   page: () => HomeUserScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.almosttherescreen,
      //   page: () => AlmostThereScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.userbottomnavbar,
      //   page: () => UserBottomNavBar(),
      // ),

      // ////////seller
      // GetPage(
      //   name: RouteConstants.sellercreateshopscreen,
      //   page: () => const SellerCreateShopScreen(),
      // ),
      GetPage(
        name: RouteConstants.inventory,
        page: () => const InventorySeller(),
      ),
      // GetPage(
      //   name: RouteConstants.sellercreatebank,
      //   page: () => const SellerSetupBank(),
      // ),
      GetPage(
        name: RouteConstants.sellerdashboard,
        page: () => const SellerDashboardScreen(),
      ),
      GetPage(
        name: RouteConstants.sellerorderhistoryscreen,
        page: () => const SellerOrderHistoryScreen(),
      ),
      GetPage(
        name: RouteConstants.selleractiveorderdetailsscreen,
        page: () => const SellerActiveOrderDetails(),
      ),
      GetPage(
        name: RouteConstants.sellercompletedorderdetailsscreen,
        page: () => const SellerCompletedOrderDetails(),
      ),
      GetPage(
        name: RouteConstants.sellerrefundorderdetailsscreen,
        page: () => const SellerRefundOrderDetails(),
      ),
      GetPage(
        name: RouteConstants.sellerprofilescreen,
        page: () => const SellerProfileScreen(),
      ),
      GetPage(
        name: RouteConstants.sellersettingscreen,
        page: () => const SellerSettingScreen(),
      ),
      GetPage(
        name: RouteConstants.sellersetuppassword,
        page: () => const SellerSetupPassword(),
      ),
      GetPage(
        name: RouteConstants.sellerbankaccountsetting,
        page: () => const SellerBankAccountSetting(),
      ),
      GetPage(
        name: RouteConstants.sellersalesreportscreen,
        page: () => const SellerSalesReportScreen(),
      ),
      // GetPage(
      //   name: RouteConstants.sellersetupshop,
      //   page: () => const SellerSetupShop(),
      // ),
      GetPage(
        name: RouteConstants.sellerchatlistscreen,
        page: () => SellerChatsListScreen(),
      ),
      GetPage(
        name: RouteConstants.sellerchatscreen,
        page: () => SellerChatScreen(),
      ),
      // GetPage(
      //   name: RouteConstants.userdashboardscreen,
      //   page: () => UserDashboardScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.userorderhistory,
      //   page: () => UserOrderHistoryScreen(),
      // ),
      // GetPage(
      //   name: RouteConstants.useractiveorderdetails,
      //   page: () => UserActiveOrderDetails(),
      // ),
      // GetPage(
      //   name: RouteConstants.userrefundorderdetails,
      //   page: () => UserRefundOrderDetails(),
      // ),
      // GetPage(
      //   name: RouteConstants.usercompletedorderdetails,
      //   page: () => UserCompletedOrderDetails(),
      // ),
      GetPage(
        name: RouteConstants.sellerupdateshop,
        page: () => const SellerUpdateShopScreen(),
      ),
       GetPage(
        name: RouteConstants.sellerupdateshopdetails,
        page: () => const SellerUpdateShopDetails(),
      ),
      GetPage(
        name: RouteConstants.sellerpendingdetailsscreen,
        page: () => const SellerPendingOrderDetails(),
      ),
       GetPage(
        name: RouteConstants.sellerorderdetailsscreen,
        page: () => const SellerOrderDetails(),
      ),
    ];
  }
}
