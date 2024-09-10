import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:smsseller/constants/route_constants.dart';
import 'package:smsseller/services/local_storage.dart';

Future<void> showNotificationFromData(
    String? title, String? body, String? imageUrl, String payload) async {
  final userid = LocalStorage().getString('user_id');
  final sellerguid = LocalStorage().getString('sellerguid');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'notification-channel-$userid',
    'chat-channel-$sellerguid',
    importance: Importance.high,
    priority: Priority.high,
    icon: 'launcher_icon',
  );

  // Combine Android-specific and iOS-specific notification details
  NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );

  await flutterLocalNotificationsPlugin
      .show(0, title, body, platformChannelSpecifics, payload: payload);
}

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  if (message.notification != null) {
    debugPrint(
        "onBackground: ${message.notification?.title}/${message.notification?.body}");
  } else if (message.data.isNotEmpty) {
    // Handle data-only message
    debugPrint("Received data-only message: ${message.data}");

    // Extract data from the message
    String? title = message.data['title'];
    String? body = message.data['body'];
    String? imageUrl = message.data['image'];
    String? type = message.data['type'];
    String payload = type == 'chats' ? 'chat' : 'selling';
    print("Push TYPE:$payload");
    showNotificationFromData(title, body, imageUrl, payload);
  } else {
    debugPrint("No notification or data in the message.");
  }
}

final localnotification = FlutterLocalNotificationsPlugin();
Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('launcher_icon');

  var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {});

  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await localnotification.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (NotificationResponse response) async {
    final String? payload =  response.payload;
    if (payload != null) {
      if (payload == 'chat') {
        Get.toNamed(RouteConstants.sellerchatlistscreen);
      } else if (payload == 'selling') {
        Get.toNamed(RouteConstants.sellerorderhistoryscreen);
      } else {
        Get.toNamed(RouteConstants.notificationscreens);
      }
    } else {
      Get.toNamed(RouteConstants.notificationscreens);
    }
  },
  );
}
