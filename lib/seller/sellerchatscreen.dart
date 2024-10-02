import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/constants/sockets.dart';
import 'package:smsseller/controller/chatcontroller.dart';
import 'package:smsseller/customcomponents/capitalword.dart';
import 'package:smsseller/customcomponents/errordailog.dart';
import 'package:smsseller/services/local_storage.dart';

class SellerChatScreen extends StatefulWidget {
  const SellerChatScreen({super.key});

  @override
  State<SellerChatScreen> createState() => _SellerChatScreenState();
}

class _SellerChatScreenState extends State<SellerChatScreen> {
  final chatcontroller = Get.put(ChatController(chatRepo: Get.find()));
  final ScrollController _scrollcontroller = ScrollController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final int roomid = Get.arguments as int;
  late WebSocketService _webSocketService;
  String? sellerid;
  @override
  void initState() {
    super.initState();
    chatcontroller.sendmessagecontroller.value.clear();
    final guid = LocalStorage().getString('sellerguid');
    // _scrollcontroller.addListener(_scrollListener);
    sellerid = guid;
    _webSocketService = WebSocketService(AppConstants.socketbaseurl);
    _webSocketService.connect(
      channel: 'chat-channel-$guid',
      onMessage: (message) {
        chatcontroller.chatdetailpage.value = 1;
        chatcontroller.getsellerChatRoomDetails(roomid);
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
    chatcontroller.getsellerChatList();
    chatcontroller.getChatsCount();
  }

  // void _scrollListener() {
  //   if (_scrollcontroller.offset >=
  //           _scrollcontroller.position.maxScrollExtent &&
  //       !_scrollcontroller.position.outOfRange) {
  //     chatcontroller.getsellerChatRoomDetails(roomid);
  //   }
  // }

  @override
  void dispose() {
    _scrollcontroller.dispose();
    _webSocketService.closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => chatcontroller.getsellerchatroomdetailsloading.value
                  ? const SizedBox()
                  : chatcontroller.getsellerchatroomdetails.value == null ||
                          chatcontroller
                              .getsellerchatroomdetails.value!.data!.isEmpty
                      ? const SizedBox()
                      : Text(
                          toCamelCase(chatcontroller.getsellerchatroomdetails
                                  .value?.data?.first?.testuser?.name ??
                              ""),
                          style: TextStyle(
                              color: const Color(0xffFFFFFF),
                              fontWeight: FontWeight.w700,
                              fontSize: 16.sp),
                        ),
            ),
            // Text(
            //   "Last Seen 20 mins ago",
            //   style: TextStyle(
            //       color: const Color(0xffC6C6C6),
            //       fontWeight: FontWeight.w400,
            //       fontSize: 13.sp),
            // ),
          ],
        ),
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_new_outlined,
              color: Color(0xffFFFFFF),
              size: 16.sp,
            )),
        backgroundColor: Color(0xff2E3192),
      ),
      body: Obx(() {
        if (chatcontroller.getsellerchatroomdetailsloading.value) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 35.h),
            child: Center(
              child: customcircularprogress(),
            ),
          );
        } else if (chatcontroller.getsellerchatroomdetails.value == null ||
            chatcontroller.getsellerchatroomdetails.value!.data!.isEmpty) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 35.h),
            child: Center(
              child: nodatatext("No Chats"),
            ),
          );
        } else {
          
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollcontroller.hasClients) {
              _scrollcontroller
                  .jumpTo(_scrollcontroller.position.maxScrollExtent);
            }
          });

          return Form(
            key: formkey,
            child: Column(
              children: [
                chatcontroller.getsellerchatroomdetailsreloading.value
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.h),
                          child: SizedBox(
                            height: 3.h,
                            width: 6.w,
                            child: customcircularprogress(),
                          ),
                        ),
                      )
                    : const SizedBox(),
                Expanded(
                    child: ListView.builder(
                       
                        controller: _scrollcontroller,
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: chatcontroller
                            .getsellerchatroomdetails.value?.data?.length,
                        itemBuilder: (context, index) {
                          final chattroomdata = chatcontroller
                              .getsellerchatroomdetails.value?.data?[index];
                          return ChatBox(
                            sendeImage:
                                chattroomdata?.testuser?.media == null ||
                                        chattroomdata!.testuser!.media!.isEmpty
                                    ? AppConstants.noimage
                                    : chattroomdata.testuser?.media?.first
                                            ?.originalUrl ??
                                        AppConstants.noimage,
                            time: chattroomdata?.time ?? "",
                            text: toCamelCase(chattroomdata?.message ?? ""),
                            isCurrentUser:
                                sellerid == chattroomdata?.uid ? false : true,
                            profileImage: chattroomdata?.seller?.mainImage ==
                                        null ||
                                    chattroomdata!.seller!.mainImage!.isEmpty
                                ? AppConstants.noimage
                                : chattroomdata.seller?.mainImage ??
                                    AppConstants.noimage,
                          );
                        })),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: chatcontroller.sendmessagecontroller.value,
                    style: TextStyle(fontSize: 14.sp),
                    decoration: InputDecoration(
                      suffixIcon: chatcontroller.isSendmessgeButtonEnabled.value
                          ? InkWell(
                              onTap: () {
                                if (formkey.currentState!.validate()) {
                                  chatcontroller
                                      .sendMessage(
                                          roomid: chatcontroller
                                                  .getsellerchatroomdetails
                                                  .value
                                                  ?.data
                                                  ?.first
                                                  ?.roomId ??
                                              0,
                                          uid: chatcontroller
                                                  .getsellerchatroomdetails
                                                  .value
                                                  ?.data
                                                  ?.first
                                                  ?.testuser
                                                  ?.id
                                                  .toString() ??
                                              "",
                                          fromid: sellerid ?? "",
                                          message: chatcontroller
                                              .sendmessagecontroller.value.text
                                              .toString())
                                      .then((value) {
                                        chatcontroller.chatdetailpage.value = 1;
                                    chatcontroller.getsellerChatRoomDetails(
                                        chatcontroller.getsellerchatroomdetails
                                                .value?.data?.first?.roomId ??
                                            0);
                                    chatcontroller.sendmessagecontroller.value
                                        .clear();
                                  });
                                }
                              },
                              child: Image.asset(
                                'assets/images/chatmessagefieldicon.png',
                                scale: 1.6,
                              ),
                            )
                          : null,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff2E3192),
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      contentPadding:
                          EdgeInsets.only(top: 10, right: 12, left: 12),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff2E3192),
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff1375EA),
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff2E3192),
                        ),
                        borderRadius: BorderRadius.circular(13),
                      ),
                      fillColor: Color(0xffF5F5F5),
                      hintText: "Message......",
                      hintStyle:
                          TextStyle(fontSize: 14.sp, color: Color(0xff929292)),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}

class ChatBox extends StatelessWidget {
  ChatBox({
    Key? key,
    required this.text,
    required this.time,
    required this.isCurrentUser,
    required this.profileImage,
    required this.sendeImage,
  }) : super(key: key);
  final String text;
  final String time;
  final bool isCurrentUser;
  final String profileImage;
  final String sendeImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            isCurrentUser ? 120.0 : 16.0,
            11,
            isCurrentUser ? 17.0 : 120.0,
            11,
          ),
          child: Row(
            mainAxisAlignment:
                isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isCurrentUser)
                Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: CircleAvatar(
                    radius: 20.sp,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(sendeImage),
                  ),
                ),
              Expanded(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color:
                          isCurrentUser ? Color(0xffF5F5F5) : Color(0xff2E3192),
                      border: Border.all(color: Color(0xff2E3192)),
                      borderRadius: isCurrentUser
                          ? BorderRadius.only(
                              topLeft: Radius.circular(21),
                              bottomLeft: Radius.circular(23),
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(5))
                          : BorderRadius.only(
                              topLeft: Radius.circular(5),
                              bottomLeft: Radius.circular(21),
                              bottomRight: Radius.circular(20),
                              topRight: Radius.circular(23))),
                  child: Padding(
                    padding:
                        EdgeInsets.only(right: 15, left: 12, top: 6, bottom: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(text,
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: isCurrentUser
                                    ? Color(0xff818181)
                                    : Color(0xffFFFFFF))),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Text(time,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: isCurrentUser
                                      ? Color(0xff282828)
                                      : Color(0xffFFFFFF))),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if (isCurrentUser)
                Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: CircleAvatar(
                    radius: 18.sp,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(profileImage),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
