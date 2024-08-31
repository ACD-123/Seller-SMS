import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:smsseller/customcomponents/customappbar.dart';
import 'package:smsseller/seller/notifications/allnotifications.dart';
import 'package:smsseller/seller/notifications/ordersnotifications.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> with SingleTickerProviderStateMixin{
    late TabController _tabController;
   @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: customappbar(title: "Notifications"),
      body:SingleChildScrollView(
        child: Column(
          children: [
            TabBar(
              controller: _tabController,
              tabs: const [
                Tab(text: "All"),
                Tab(text: "Orders"),
              ],
            ),
            SizedBox(
              height: 60.h,
              child: TabBarView(
                controller: _tabController,
                children: const [
                  AllNotifications(),
                          OrdersNotifications(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}