import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/controller/chatcontroller.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/seller/notifications/allnotifications.dart';
import 'package:smsseller/seller/notifications/chatsnotifications.dart';
import 'package:smsseller/seller/notifications/ordersnotifications.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen>
    with SingleTickerProviderStateMixin {
  final chatcontroller = Get.put(ChatController(chatRepo: Get.find()));
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        switch (_tabController.index) {
          case 0:
            chatcontroller.getNotifications("all");
            break;
          case 1:
            chatcontroller.getNotifications("selling");
            break;
          // case 2:
          //   chatcontroller.getNotifications("chats");
          //   break;
        }
      }
    });
    chatcontroller.getNotificationsCount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customappbar(title: "Notifications"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Orders"),
                // Tab(text: "Chats"),
              ],
            ),
            SizedBox(
              height: 80.h,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  AllNotifications(),
                  OrdersNotifications(),
                  // ChatsNotifications()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
