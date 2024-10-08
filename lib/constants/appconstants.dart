class AppConstants {
  static const noimage =
      "https://static.vecteezy.com/system/resources/thumbnails/022/014/063/small_2x/missing-picture-page-for-website-design-or-mobile-app-design-no-image-available-icon-vector.jpg";
  static const baseApiURL = 'https://smsbackendv1.testingwebsitelink.com/api/';
  static const placesbaseapiurl = 'AIzaSyDg6Ci3L6yS5YvtKAkWQjnodGUtlNYHw9Y';
  static const socketbaseurl =
      "wss://smsbackendv1.testingwebsitelink.com:6001/app/cdbc9f9c829f8381a3f5";
  static const signup = "auth/register";
  static const login = "auth/login";
  static const changepassword = "auth/reset-password";
  static const verifyotp = "auth/verify-otp";
  static const resendotp = "auth/send-otp";
  static const getcategoriessearchbykey = "categories/search";
  static const createsellershop = "seller/store-or-update-seller-data";
  static const getsellershopprofiledata = "seller/get-seller-data";
  static const getsellerprofiledata = "user/profile";
  static const updatesellerprofiledata = "user/update-profile";
  static const getsellertotalsalestats = "order/seller-stats?month=";
  static const getselleritemssoldstats = "order/seller-product-stats?month=";
  static const getsellercategorieslist = "seller/get-seller-category";
  static const getsellersubcategorieslist = "categories/sub-category/";
  static const getbrandslist = "brands?page_size=9999999999";
  static const getcategorywiseattributes = "categories/attributes/";
  static const createproduct = "products/store";
  static const updateproduct = "products/update";
  static const getactiveproducts = "seller/active-product";
  static const getinactiveproducts = "seller/in-active-product";
  static const getproductpreviewbyid = "products/getProductById/";
  static const getsellershopproducts = "user-seller/products/";
  static const getsellershopabout = "user-seller/about/";
  static const getsellershopfeedback = "user-seller/feedback/";
  static const replysellerfeedback = "feedback/update";
  static const getsalesreportgraph = "order/seller-order-dashboard";
  static const getdeletedproducts = "seller/deleted-product";
  static const deleteproduct = "products/update-status";
  static const getsalesreportorderpercentage = "order/seller-order-percentage";
  static const getsalesreportearningrefund = "order/seller-earing-refund";
  static const getsalesreportrecentorders = "seller/orders";
  static const getorderdetailsbyid = "order/getById/";
  static const getorderhistorycount = "seller/order-count";
  static const updateorderstatus = "seller/order/update-status/";
  static const getpendingorders = "order/pending-seller";
  static const getactiveorders = "order/accepted-seller";
  static const getcompletedorders = "order/completed-seller";
  static const getrefundedorders = "order/refunded-seller";
  static const getrejectedorders = "order/rejected-seller";
  static const getsubscriptionpaymenturl = "seller/subscription";
  static const getsellerchatlist = "chat/getChatListBUid?id=";
  static const getsellerchatroomdetails = "chat/getById?room_id=";
  static const sendmessage = "chat/sendMessage";
  static const inappchangepassword = "user/update-password";
  static const getrefundorderdetailsbyid = "order/getById/";
  static const getnotifications = "notification?type=";
  static const getnotificationscount = "notification/count";
  static const getnotificationssetting = "user/getNotificationSetting";
  static const getfaq = "faqs/";
  static const getprivacypolicy = "privacy_policy/";
  static const updatenotificationssetting = "user/updateNotificationSetting";
  static const createcoupon = "coupon/store";
  static const getcoupon = "coupon?user_date=";
  static const getcouponbyid = "coupon/getById/";
  static const updatecoupon = "coupon/update/";
  static const deletecoupon = "coupon/deleteCoupon/";
  static const getsellersearchchatlist = "chat/getChatListBUidSearch?id=";
  static const getchatscount = "chat/seller-count/";
  static const updaterefundorderstatus = "order/refund-status";
  static const getwallettransection = "user-seller/transaction/";
  static const sociallogin = "auth/social-login";
  static const updatefcm = "user/update-fcm";
  static const getproductwisefeedback = "feedback/product/";
  static const googlelogindetails = "auth/check";
  static const withdrawamount = "seller/witdraw/";
  static const logout = "user/logout-fcm";
}
