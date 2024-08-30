import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
}
