import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smsseller/models/getnotificationscount.dart';
import 'package:smsseller/models/getnotificationsettingmodel.dart';
import 'package:smsseller/models/notifications_model.dart';
import 'package:smsseller/models/sellerchatlistmodel.dart';
import 'package:smsseller/models/sellerchatroomdetails_model.dart';
import 'package:smsseller/repositries/chatrepo.dart';

class ChatController extends GetxController {
  ChatRepo chatRepo;

  ChatController({required this.chatRepo});

//////////////get sellerchat list api 
  final Rx<SellerChatListModel?> getsellerchatlist =
      Rx<SellerChatListModel?>(null);
  final RxBool getsellerchatlistloading = false.obs;

  getsellerChatList() async {
    try {
      getsellerchatlistloading(true);
      await chatRepo.getSellerChatList().then((value) {
        getsellerchatlist.value = value;
        getsellerchatlistloading(false);
      });
    } catch (e) {
      getsellerchatlistloading(false);
    }
  }
//////////////get sellerchat room details  api 
  final Rx<SellerChatRoomDetailsModel?> getsellerchatroomdetails =
      Rx<SellerChatRoomDetailsModel?>(null);
  final RxBool getsellerchatroomdetailsloading = false.obs;
 int? _lastRoomId; 
  getsellerChatRoomDetails(int roomid) async {
    try {
   _lastRoomId == roomid ?   getsellerchatroomdetailsloading(false) :  getsellerchatroomdetailsloading(true);
      await chatRepo.getSellerChatRoomDetails(roomid).then((value) {
        _lastRoomId = roomid;
        getsellerchatroomdetails.value = value;
        getsellerchatroomdetailsloading(false);
      });
    } catch (e) {
      getsellerchatroomdetailsloading(false);
    }
  }

/////////send message api 
RxBool sendmessageloading = false.obs;
final sendmessagecontroller = TextEditingController().obs;
  Future<void> sendMessage({
    required int roomid,
    required String uid,
      required String fromid,
    required String message
  }) async {
    try {
      sendmessageloading.value = true;
      await chatRepo.sendMessage(
        roomid: roomid.toString(), 
        uid: uid.toString(), 
        fromid: fromid.toString(), 
        message: message.toString())
      ;  
      

      sendmessageloading.value = false;
    } finally {
      sendmessageloading.value = false;
    }
  }

 //////////////get notifications api
  final Rx<NotificationsModel?> getnotifications =
      Rx<NotificationsModel?>(null);
  final RxBool getnotificationsloading = false.obs;
  final RxBool getnotificationsreloading = false.obs;
  final RxInt notificationspage = 1.obs;
  Future<void> getNotifications(String status) async {
    if (getnotificationsreloading.value || getnotificationsloading.value)
      return;
    if (notificationspage.value > 1 &&
        notificationspage.value >
            (getnotifications.value?.data?.pagination?.totalPages ?? 0)) {
      return;
    }

    try {
      notificationspage.value > 1
          ? getnotificationsreloading.value = true
          : getnotificationsloading.value = true;
      final value =
          await chatRepo.getNotifications(status, notificationspage.value);
      if (notificationspage.value > 1) {
        getnotifications.value?.data?.notifications
            ?.addAll(value?.data?.notifications ?? []);
      } else {
        getnotifications.value = value;
      }
      notificationspage.value++;
      getnotificationsreloading.value = false;
      getnotificationsloading.value = false;
    } catch (e) {
      getnotificationsreloading.value = false;
      getnotificationsloading.value = false;
    }
  }

//////////////get notifications count api
  final Rx<NotificationsCountModel?> getnotificationscount =
      Rx<NotificationsCountModel?>(null);
  final RxBool getnotificationscountloading = false.obs;
  getNotificationsCount() async {
    try {
     getnotificationscountloading(true);
      await chatRepo.getNotificationsCount().then((value) {
        getnotificationscount.value = value;
        getnotificationscountloading(false);
      });
    } catch (e) {
      getnotificationscountloading(false);
    }
  }


/////////// notificationsetting all  buttons logic
  RxBool notificationsettingswitchall = false.obs;
  void updatenotificationsettingswitchall(bool? newValue) {
    notificationsettingswitchall.value = newValue!;
  }

/////////// notificationsettingswitchAllorders  buttons logic
  RxBool notificationsettingswitchAllorders = false.obs;
  void updatenotificationsettingswitchAllorders(bool? newValue) {
    notificationsettingswitchAllorders.value = newValue!;
  }

 
  /////////// notificationsettingswitchChats  buttons logic
  RxBool notificationsettingswitchChats = false.obs;
  void updatenotificationsettingswitchChats(bool? newValue) {
    notificationsettingswitchChats.value = newValue!;
  }

  /////////////SETTING CONTACT US favourite icon logic
  RxBool settingcontactusfavouriteicon = false.obs;
  void updatesettingcontactusfavouriteicon() {
    settingcontactusfavouriteicon.value = !settingcontactusfavouriteicon.value;
  }
//////////////get notifications setting api
  final Rx<GetNotificationSettingModel?> getnotificationssetting =
      Rx<GetNotificationSettingModel?>(null);
  final RxBool getnotificationssettingloading = false.obs;
  getNotificationsSetting() async {
    try {
     getnotificationssettingloading(true);
      await chatRepo.getNotificationsSetting().then((value) {
        getnotificationssetting.value = value;
        getnotificationssettingloading(false);
      });
    } catch (e) {
      getnotificationscountloading(false);
    }
  }


/////////update notification setting api
// RxBool updatenotificationsettingloading = false.obs;
//   Future<void> updateNotificationSetting({
//     required int type,
//   }) async {
//     try {
//       updatenotificationsettingloading.value = true;
//       await chatRepo.sendMessage(
//         roomid: roomid.toString(), 
//         uid: uid.toString(), 
//         fromid: fromid.toString(), 
//         message: message.toString())
//       ;  
      

//       updatenotificationsettingloading.value = false;
//     } finally {
//       updatenotificationsettingloading.value = false;
//     }
//   }
}
