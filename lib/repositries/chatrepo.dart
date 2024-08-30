
import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
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
  Future<SellerChatRoomDetailsModel?> getSellerChatRoomDetails(int roomid) async {
    try {
      final String sellerguid = LocalStorage().getString("sellerguid"); 
      final res = await apiClient.getFromServer(
        endPoint: "${AppConstants.getsellerchatroomdetails}$roomid&id=$sellerguid",
      );
      if (res.statusCode == 200) {
        final listofsellerchatroomdetails = sellerChatRoomDetailsModelFromJson(res.body);
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
        final message = jsonDecode(res.body)['message'];
        showSuccessSnackbar(message: message);
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
}
