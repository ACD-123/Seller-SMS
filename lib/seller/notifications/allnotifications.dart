import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/constants/appconstants.dart';
import 'package:smsseller/controller/chatcontroller.dart';
import 'package:smsseller/customcomponents/errordailog.dart';

class AllNotifications extends StatefulWidget {
  const AllNotifications({super.key});

  @override
  State<AllNotifications> createState() => _AllNotificationsState();
}

class _AllNotificationsState extends State<AllNotifications> {
  final chatcontroller = Get.put(ChatController(chatRepo: Get.find()));
  ScrollController scrollcontroller = ScrollController();
  @override
  void initState() {
    super.initState();
    chatcontroller.notificationspage.value = 1;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatcontroller.getNotifications("all");
    });
    scrollcontroller.addListener(_scrollListener);
  }

  @override
  void dispose() {
    scrollcontroller.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (scrollcontroller.offset >= scrollcontroller.position.maxScrollExtent &&
        !scrollcontroller.position.outOfRange) {
      chatcontroller.getNotifications("all");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 18),
        child: SingleChildScrollView(
            controller: scrollcontroller,
            child: Obx(
              () => chatcontroller.getnotificationsloading.value
                  ? Padding(
                      padding: EdgeInsets.symmetric(vertical: 30.h),
                      child: Center(
                        child: customcircularprogress(),
                      ),
                    )
                  : chatcontroller.getnotifications.value == null ||
                          chatcontroller.getnotifications.value!.data!
                              .notifications!.isEmpty
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 30.h),
                          child: Center(
                            child: nodatatext("No All Notifications"),
                          ),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: chatcontroller.getnotifications.value
                                    ?.data?.notifications?.length,
                                itemBuilder: (context, index) {
                                  final chatssnotificationsdata = chatcontroller
                                      .getnotifications
                                      .value
                                      ?.data
                                      ?.notifications?[index];
                                  return Column(
                                    children: [
                                      ListTile(
                                          leading: CircleAvatar(
                                              radius: 19.sp,
                                              backgroundImage: NetworkImage(
                                                  chatssnotificationsdata
                                                                  ?.sender
                                                                  ?.media ==
                                                              null ||
                                                          chatssnotificationsdata!
                                                              .sender!
                                                              .media!
                                                              .isEmpty
                                                      ? AppConstants.noimage
                                                      : chatssnotificationsdata
                                                              .sender
                                                              ?.media
                                                              ?.first
                                                              .originalUrl ??
                                                          AppConstants
                                                              .noimage)),
                                          title: Text(
                                            chatssnotificationsdata?.title
                                                    .toString() ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Color(0xff777777)),
                                          ),
                                          subtitle: Text(
                                           chatssnotificationsdata?.message
                                                    .toString() ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                color: Color(0xff777777),
                                                
                                                ),
                                          ),
                                          trailing: Text(
                                            chatssnotificationsdata?.date
                                                    .toString() ??
                                                "",
                                            style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Color(0xff000000)
                                                    .withOpacity(0.3)),
                                          )),
                                      const Divider()
                                    ],
                                  );
                                }),
                            chatcontroller.getnotificationsreloading.value
                                ? Center(
                                    child: customcircularprogress(),
                                  )
                                : const SizedBox()
                          ],
                        ),
            )),
      ),
    );
  }
}