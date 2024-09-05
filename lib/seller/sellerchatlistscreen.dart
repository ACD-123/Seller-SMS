import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/constants/sockets.dart';
import 'package:smsseller/controller/chatcontroller.dart';
import 'package:smsseller/controller/storecontroller.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/services/local_storage.dart';

class SellerChatsListScreen extends StatefulWidget {
  @override
  _SellerChatsListScreenState createState() => _SellerChatsListScreenState();
}

class _SellerChatsListScreenState extends State<SellerChatsListScreen> {
  final storecontroller = Get.put(StoreController(storeRepo: Get.find()));
  final chatcontroller = Get.put(ChatController(chatRepo: Get.find()));
  late WebSocketService _webSocketService;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatcontroller.searchchatlistcontroller.value.clear();
    chatcontroller.searchsellerchatlist.value = null;
    chatcontroller.getsellerChatList();
    chatcontroller.searchchatlistcontroller.value.addListener(() {
      chatcontroller.getSearchsellerChatList(
          chatcontroller.searchchatlistcontroller.value.text.toString());
    });
    final sellerguid = LocalStorage().getString("sellerguid");
    ////////////sockets
    _webSocketService = WebSocketService(AppConstants.socketbaseurl);
    _webSocketService.connect(
      channel: 'chat-channel-$sellerguid',
      onMessage: (message) {
        chatcontroller.getsellerChatList();
        print('New message: $message');
      },
      onError: (error) {
        print('WebSocket Error: $error');
      },
      onDone: () {
        print('WebSocket connection closed');
      },
    );
    chatcontroller.sendmessagecontroller.value.addListener(() {
      if (chatcontroller.sendmessagecontroller.value.text.isNotEmpty) {
        chatcontroller.isSendmessgeButtonEnabled.value = true;
      } else {
        chatcontroller.isSendmessgeButtonEnabled.value = false;
      }
    });
  }

  @override
  void dispose() {
    _webSocketService.closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Chats"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(18),
                child: SizedBox(
                  height: 4.h,
                  child: TextFormField(
                    controller: chatcontroller.searchchatlistcontroller.value,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      prefixIcon: Image.asset(
                        'assets/images/homesearchicon.png',
                        color: Colors.black,
                        scale: 1.4,
                      ),
                      contentPadding: EdgeInsets.only(top: 10, right: 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1375EA),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1375EA),
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      fillColor: Color(0xffF5F5F5),
                      hintText: "Search",
                      hintStyle: TextStyle(
                          fontSize: 14.sp,
                          color: Color(0xff000000).withOpacity(0.6)),
                    ),
                    onSaved: (value) {},
                  ),
                )),
            Obx(() {
              if (chatcontroller.searchsellerchatlisttloading.value) {
                return const Center(
                  child: SizedBox(),
                );
              } else if (chatcontroller.searchsellerchatlist.value == null ||
                  chatcontroller.searchsellerchatlist.value?.data == null) {
                return const Center(
                  child: SizedBox(),
                );
              } else {
                return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        chatcontroller.searchsellerchatlist.value?.data?.length,
                    itemBuilder: (context, index) {
                      final searhdata = chatcontroller
                          .searchsellerchatlist.value?.data?[index];
                      return GestureDetector(
                        onTap: () {
                          chatcontroller
                              .getsellerChatRoomDetails(searhdata?.id ?? 0);
                          Get.toNamed(RouteConstants.sellerchatscreen,
                              arguments: searhdata?.id ?? 0);
                          chatcontroller.searchsellerchatlist.value = null;
                        },
                        child: Card(
                          child: ListTile(
                            subtitle: Text(
                              searhdata?.message ?? "",
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  color: const Color(0xff757474),
                                  overflow: TextOverflow.ellipsis),
                              maxLines: 2,
                            ),
                            leading: CircleAvatar(
                              child: Image.network(
                                  searhdata?.senderProfileImage == null
                                      ? AppConstants.noimage
                                      : searhdata?.senderProfileImage ??
                                          AppConstants.noimage),
                            ),
                            title: Text(
                              searhdata?.senderName.toString() ?? "",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xff1B1B1B),
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      );
                    });
              }
            }),
            const Divider(
              thickness: 1,
            ),
            Obx(() => chatcontroller.getsellerchatlistloading.value
                ? Padding(
                    padding: EdgeInsets.symmetric(vertical: 35.h),
                    child: Center(
                      child: customcircularprogress(),
                    ),
                  )
                : chatcontroller.getsellerchatlist.value == null ||
                        chatcontroller.getsellerchatlist.value!.data!.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 35.h),
                        child: Center(
                          child: nodatatext("No Chats"),
                        ),
                      )
                    : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: chatcontroller
                            .getsellerchatlist.value?.data?.length,
                        itemBuilder: (context, index) {
                          final chatslistdata = chatcontroller
                              .getsellerchatlist.value?.data?[index];
                          String readcounts = chatslistdata?.readCount != null
                              ? (chatslistdata!.readCount > 99
                                  ? '99+'
                                  : chatslistdata.readCount.toString())
                              : "";
                          return Dismissible(
                            key: UniqueKey(),
                            background: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xff2E3192),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 20),
                                  child: Icon(
                                    Icons.delete_outline_rounded,
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                              ),
                            ),
                            onDismissed: (direction) {
                              storecontroller.sellerchatslistremove(index);
                            },
                            confirmDismiss: (direction) async {
                              return true;
                            },
                            child: GestureDetector(
                              onTap: () {
                                chatcontroller.getsellerChatRoomDetails(
                                    chatslistdata?.id ?? 0);
                                Get.toNamed(RouteConstants.sellerchatscreen,
                                    arguments: chatslistdata?.id ?? 0);
                              },
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 1),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: CircleAvatar(
                                            radius: 20.sp,
                                            backgroundColor: Colors.greenAccent,
                                            backgroundImage: NetworkImage(
                                                chatslistdata
                                                            ?.senderProfileImage ==
                                                        null
                                                    ? AppConstants.noimage
                                                    : chatslistdata
                                                            ?.senderProfileImage ??
                                                        AppConstants.noimage),
                                          ),
                                          title: Text(
                                            chatslistdata?.senderName ?? "",
                                            style: TextStyle(
                                                fontSize: 14.sp,
                                                color: Color(0xff1B1B1B),
                                                fontWeight: FontWeight.w600),
                                          ),
                                          subtitle: Text(
                                            chatslistdata?.message ?? "",
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Color(0xff757474),
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            maxLines: 2,
                                          ),
                                          trailing: Column(
                                            children: [
                                              Text(
                                                chatslistdata?.date ?? "",
                                                style: TextStyle(
                                                    fontSize: 10,
                                                    color: Color(0xffC8BCBC)),
                                              ),
                                              readcounts == '0' ||
                                                      readcounts.isEmpty
                                                  ? const SizedBox()
                                                  : CircleAvatar(
                                                      radius: 14.sp,
                                                      backgroundColor:
                                                          Color(0xFF2E3192),
                                                      child: Text(
                                                        readcounts,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 14.sp,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          color: Color(0xffD9D9D9),
                                          thickness: 2,
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ))
          ],
        ),
      ),
    );
  }
}

class ChatsList {
  final String userName;
  final String userDescription;
  final String time;
  final String imageUrl;

  ChatsList({
    required this.userName,
    required this.userDescription,
    required this.time,
    required this.imageUrl,
  });
}
