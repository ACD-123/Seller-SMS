import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/chatcontroller.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class NotificationsSettingScreen extends StatefulWidget {
  const NotificationsSettingScreen({super.key});

  @override
State<NotificationsSettingScreen> createState() =>
      _NotificationsSettingScreenState();
}

class _NotificationsSettingScreenState
    extends State<NotificationsSettingScreen> {
  final chatcontroller = Get.put(ChatController(chatRepo: Get.find()));
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final allEnabled = [chatcontroller.getnotificationssetting.value?.data?.importantNotification,
                      chatcontroller.getnotificationssetting.value?.data?.sellingNotification,
                      chatcontroller.getnotificationssetting.value?.data?.chatsNotification]
                      .every((value) => value == 1);

  chatcontroller.notificationsettingswitchall.value = allEnabled;
    chatcontroller.getnotificationssetting.value?.data?.sellingNotification == 0
        ? chatcontroller.notificationsettingswitchAllorders.value = false
        : chatcontroller.notificationsettingswitchAllorders.value = true;
    chatcontroller.getnotificationssetting.value?.data?.chatsNotification == 0
        ? chatcontroller.notificationsettingswitchChats.value = false
        : chatcontroller.notificationsettingswitchChats.value = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Notification Settings"),
      body: Padding(
          padding: const EdgeInsets.all(18),
          child: Obx(
            () => chatcontroller.getnotificationssettingloading.value
                ? Center(
                    child: customcircularprogress(),
                  )
                : chatcontroller.getnotificationssetting.value == null ||
                        chatcontroller.getnotificationssetting.value?.data ==
                            null
                    ? Center(
                        child: nodatatext("No Notification Setting Data"),
                      )
                    : Column(
                        children: [
                          customrowsettingbuttons(
                              title: "All",
                              subtitle:
                                  "It is a long established fact that a reader will be distracted by the \n readable content of a page when looking at its layout",
                              value: chatcontroller
                                  .notificationsettingswitchall.value,
                              onchanged: (value) {
                                chatcontroller.updateNotificationSetting(
                                    important: value == false ? 0 : 1,
                                    chats: value == false ? 0 : 1,
                                    selling: value == false ? 0 : 1);
                                chatcontroller
                                    .updatenotificationsettingswitchall(value);
                              }),
                          const Divider(
                            color: Color(0xffE1E1E1),
                          ),
                          customrowsettingbuttons(
                              title: "Selling",
                              subtitle:
                                  "It is a long established fact that a reader will be distracted by the \n readable content of a page when looking at its layout",
                              value: chatcontroller
                                  .notificationsettingswitchAllorders.value,
                              onchanged: (value) {
                                chatcontroller.updateNotificationSetting(
                                    important: chatcontroller
                                        .getnotificationssetting
                                        .value
                                        ?.data
                                        ?.importantNotification,
                                    chats: chatcontroller
                                        .getnotificationssetting
                                        .value
                                        ?.data
                                        ?.chatsNotification,
                                    selling: value == false ? 0 : 1);
                                chatcontroller
                                    .updatenotificationsettingswitchAllorders(
                                        value);
                              }),
                          const Divider(
                            color: Color(0xffE1E1E1),
                          ),
                          customrowsettingbuttons(
                              title: "Chats",
                              subtitle:
                                  "It is a long established fact that a reader will be distracted by the \n readable content of a page when looking at its layout",
                              value: chatcontroller
                                  .notificationsettingswitchChats.value,
                              onchanged: (value) {
                                chatcontroller.updateNotificationSetting(
                                    important: chatcontroller
                                        .getnotificationssetting
                                        .value
                                        ?.data
                                        ?.importantNotification,
                                    chats: value == false ? 0 : 1,
                                    selling: chatcontroller
                                        .getnotificationssetting
                                        .value
                                        ?.data
                                        ?.sellingNotification);
                                chatcontroller
                                    .updatenotificationsettingswitchChats(
                                        value);
                              }),
                        ],
                      ),
          )),
    );
  }
}

//////////////////////////////////custom notification settings
Padding customrowsettingbuttons(
    {required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onchanged}) {
  return Padding(
    padding: const EdgeInsets.only(top: 6),
    child: SizedBox(
      height: 9.h,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(color: Color(0xff0B0B0B), fontSize: 15.sp)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(subtitle,
                  style: TextStyle(color: Color(0xff757474), fontSize: 12.sp)),
              Transform.scale(
                scale: 3.5.sp,
                child: Switch(
                  value: value,
                  onChanged: onchanged,
                  inactiveThumbColor: Color(0xffFFFFFF),
                  inactiveTrackColor: Color(0xff86868D),
                  activeTrackColor: Color(0xff2E3192),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}
