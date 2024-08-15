import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SellerChatScreen extends StatelessWidget {
  const SellerChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mathew",
              style: TextStyle(
                  color: Color(0xffFFFFFF),
                  fontWeight: FontWeight.w700,
                  fontSize: 16.sp),
            ),
            Text(
              "Last Seen 20 mins ago",
              style: TextStyle(
                  color: Color(0xffC6C6C6),
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp),
            ),
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
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ChatBox(
                  time: '9:38 am',
                  text:
                      'Buyers are more likely to purchase more of the same item if you add a Volume Pricing discount.',
                  isCurrentUser: false,
                  profileImage: 'assets/images/chatslistprofilepic4.png',
                ),
                ChatBox(
                  time: '9:38 am',
                  text:
                      'Buyers are more likely to purchase more of the same item if you add a Volume Pricing discount.',
                  isCurrentUser: true,
                  profileImage: 'assets/images/chatslistprofilepic2.png',
                ),
                ChatBox(
                  time: '9:38 am',
                  text:
                      'Buyers are more likely to purchase more of the same item if you add a Volume Pricing discount.',
                  isCurrentUser: false,
                  profileImage: 'assets/images/chatslistprofilepic4.png',
                ),
                ChatBox(
                  time: '9:38 am',
                  text:
                      'Buyers are more likely to purchase more of the same item if you add a Volume Pricing discount.',
                  isCurrentUser: true,
                  profileImage: 'assets/images/chatslistprofilepic2.png',
                ),
                ChatBox(
                  time: '9:38 am',
                  text: 'Thankyou So Much...',
                  isCurrentUser: false,
                  profileImage: 'assets/images/chatslistprofilepic4.png',
                ),
                ChatBox(
                  time: '9:38 am',
                  text:
                      'Buyers are more likely to purchase more of the same item if you add a Volume Pricing discount.',
                  isCurrentUser: true,
                  profileImage: 'assets/images/chatslistprofilepic2.png',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 5.h,
              child: TextFormField(
                style: TextStyle(fontSize: 14.sp),
                decoration: InputDecoration(
                  suffixIcon: Image.asset(
                    'assets/images/chatmessagefieldicon.png',
                    scale: 1.6,
                  ),
                  contentPadding: EdgeInsets.only(top: 10, right: 12, left: 12),
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
                  fillColor: Color(0xffF5F5F5),
                  hintText: "Message......",
                  hintStyle:
                      TextStyle(fontSize: 14.sp, color: Color(0xff929292)),
                ),
                onSaved: (value) {},
              ),
            ),
          ),
        ],
      ),
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
  }) : super(key: key);
  final String text;
  final String time;
  final bool isCurrentUser;
  final String profileImage;

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
                    backgroundImage: AssetImage(profileImage),
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
                    backgroundImage: AssetImage(profileImage),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
