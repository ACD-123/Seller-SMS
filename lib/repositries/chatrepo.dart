import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/models/chatcount_model.dart';
import 'package:smsseller/models/getnotificationscount.dart';
import 'package:smsseller/models/getnotificationsettingmodel.dart';
import 'package:smsseller/models/notifications_model.dart';
import 'package:smsseller/models/searchchatlist_model.dart';
import 'package:smsseller/models/sellerchatlistmodel.dart';
import 'package:smsseller/models/sellerchatroomdetails_model.dart';
import 'package:smsseller/services/apiservices.dart';
import 'package:smsseller/services/local_storage.dart';

class ChatRepo extends GetxService {
  HttpApiClient apiClient;
  ChatRepo({required this.apiClient});

////////get seller chat list api
  Future<SellerChatListModel?> getSellerChatList() async {
    try {
      final String sellerguid = LocalStorage().getString("sellerguid");
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getsellerchatlist}$sellerguid&status=0",
      );
      if (res.statusCode == 200) {
        final listofsellerchatlist = sellerChatListModelFromJson(res.body);
        return listofsellerchatlist;
      } else {
        throw Exception("No data field found in the GetSellerChatList");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

////////get seller chat room details api
  Future<SellerChatRoomDetailsModel?> getSellerChatRoomDetails(
      int roomid) async {
    try {
      final String sellerguid = LocalStorage().getString("sellerguid");
      final res = await apiClient.getFromServer(
        endPoint:
            "${AppConstants.getsellerchatroomdetails}$roomid&id=$sellerguid",
      );
      if (res.statusCode == 200) {
        final listofsellerchatroomdetails =
            sellerChatRoomDetailsModelFromJson(res.body);
        return listofsellerchatroomdetails;
      } else {
        throw Exception("No data field found in the GetSellerChatRoomDetails");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

///////send message api
  Future sendMessage({
    required String roomid,
    required String uid,
    required String fromid,
    required String message,
  }) async {
    final mapData = {
      "room_id": roomid,
      "uid": uid,
      "from_id": fromid,
      "message_type": "0",
      "message": message,
      "status": "1"
    };
    print(mapData);
    try {
      final res = await apiClient.postToServer(
          endPoint: AppConstants.sendmessage, data: mapData);
      if (res.statusCode == 200) {
        // final message = jsonDecode(res.body)['message'];
        // showSuccessSnackbar(message: message);
      } else {
        final message = jsonDecode(res.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } on SocketException {
      return showErrrorSnackbar(message: 'No Internet Connection');
    } catch (e) {
      showErrrorSnackbar(message: e.toString());
    }
  }

  ///////get notifications api
  Future<NotificationsModel?> getNotifications(String type, int page) async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getnotifications}$type&page=$page",
      );
      if (res.statusCode == 200) {
        final listofnotifications = notificationsModelFromJson(res.body);
        return listofnotifications;
      } else {
        throw Exception("No data field found in the GetNotifications");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ///////get notifications count api
  Future<NotificationsCountModel?> getNotificationsCount() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getnotificationscount,
      );
      if (res.statusCode == 200) {
        final listofnotifications = notificationsCountModelFromJson(res.body);
        return listofnotifications;
      } else {
        throw Exception("No data field found in the GetNotificationsCount");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  ///////get notifications setting api
  Future<GetNotificationSettingModel?> getNotificationsSetting() async {
    try {
      final res = await apiClient.getFromServer(
        endPoint: AppConstants.getnotificationssetting,
      );
      if (res.statusCode == 200) {
        final listofnotificationsetting =
            getNotificationSettingModelFromJson(res.body);
        return listofnotificationsetting;
      } else {
        throw Exception("No data field found in the GetNotificationsSetting");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

///////update notification setting api
  Future<void> updateNotificationSetting({
    required int important,
    required int chats,
    required int selling,
  }) async {
    final userData = {
      "important_notification": important.toString(),
      "chats_notification": chats.toString(),
      "selling_notification": selling.toString(),
      "buying_notification": "0",
    };
    try {
      final response = await apiClient.postToServer(
        endPoint: AppConstants.updatenotificationssetting,
        data: userData,
      );

      if (response.statusCode == 200) {
        Get.back();
      } else if (response.statusCode == 422) {
        final message = jsonDecode(response.body)['message'];
        showErrrorSnackbar(message: message);
      } else {
        final message = jsonDecode(response.body)['message'];
        showErrrorSnackbar(message: message);
      }
    } catch (e) {
      showErrrorSnackbar(
        message: 'An unexpected error occurred. Please try again later.',
      );
    }
  }

////////get seller search chat list api
  Future<SellerSearchChatListModel?> getSellerSearchChatList(String key) async {
    try {
      final String sellerguid = LocalStorage().getString("sellerguid");
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getsellersearchchatlist}$sellerguid&status=0&search_key=$key",
      );
      if (res.statusCode == 200) {
        final listofsellersearchchatlist = sellersearchChatListModelFromJson(res.body);
        return listofsellersearchchatlist;
      } else {
        throw Exception("No data field found in the GetSellerSearchChatList");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

///////get chats count api
  Future<GetChatCountModel?> getChatsCount() async {
    try {
       final String sellerguid = LocalStorage().getString("sellerguid");
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getchatscount}$sellerguid",
      );
      if (res.statusCode == 200) {
        final listofchatscount = getChatCountModelFromJson(res.body);
        return listofchatscount;
      } else {
        throw Exception("No data field found in the GetChatsCount");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
