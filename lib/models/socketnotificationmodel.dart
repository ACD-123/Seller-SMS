import 'dart:convert';

SocketNotificationModel? socketNotificationModelFromJson(String str) =>
    SocketNotificationModel.fromJson(json.decode(str));
String socketNotificationModelToJson(SocketNotificationModel? data) =>
    json.encode(data?.toJson());
class SocketNotificationModel {
  Notification? notification;

  SocketNotificationModel({this.notification});

  factory SocketNotificationModel.fromJson(Map<String, dynamic> json) =>
      SocketNotificationModel(
        notification: json["notification"] != null
            ? Notification.fromJson(json["notification"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "notification": notification?.toJson(),
      };
}
class Notification {
  int? id;
  int? userId;
  int? senderId;
  String? title;
  String? message;
  String? date;
  String? type;
  dynamic isRead;
  dynamic isSeen;
  Sender? sender;

  Notification({
    this.id,
    this.userId,
    this.senderId,
    this.title,
    this.message,
    this.date,
    this.type,
    this.isRead,
    this.isSeen,
    this.sender,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
        id: json["id"],
        userId: json["user_id"],
        senderId: json["sender_id"],
        title: json["title"],
        message: json["message"],
        date: json["date"],
        type: json["type"],
        isRead: json["is_read"],
        isSeen: json["is_seen"],
        sender: json["sender"] != null
            ? Sender.fromJson(json["sender"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "sender_id": senderId,
        "title": title,
        "message": message,
        "date": date,
        "type": type,
        "is_read": isRead,
        "is_seen": isSeen,
        "sender": sender?.toJson(),
      };
}

// Sender class
class Sender {
  int? id;
  String? name;
  String? email;
  List<Media>? media;

  Sender({this.id, this.name, this.email, this.media});

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        media: json["media"] != null
            ? List<Media>.from(json["media"].map((x) => Media.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "media": media?.map((x) => x.toJson()).toList(),
      };
}

class Media {
  int? id;
  String? originalUrl;

  Media({this.id, this.originalUrl});

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        originalUrl: json["original_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_url": originalUrl,
      };
}

