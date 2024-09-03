import 'dart:convert';

NotificationsModel? notificationsModelFromJson(String str) => NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel? data) => json.encode(data?.toJson());

class NotificationsModel {
  bool? status;
  Data? data;
  String? message;

  NotificationsModel({
    this.status,
    this.data,
    this.message,
  });

  factory NotificationsModel.fromJson(Map<String, dynamic> json) => NotificationsModel(
    status: json["status"],
    data: json["data"] != null ? Data.fromJson(json["data"]) : null,
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
    "message": message,
  };
}

class Data {
  List<Notification>? notifications;
  int? count;
  Pagination? pagination;

  Data({
    this.notifications,
    this.count,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    notifications: json["notifications"] != null ? List<Notification>.from(json["notifications"].map((x) => Notification.fromJson(x))) : null,
    count: json["count"],
    pagination: json["pagination"] != null ? Pagination.fromJson(json["pagination"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "notifications": notifications != null ? List<dynamic>.from(notifications!.map((x) => x.toJson())) : null,
    "count": count,
    "pagination": pagination?.toJson(),
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
    this.type,
    this.isRead,
    this.isSeen,
    this.sender,
     this.date,
  });

  factory Notification.fromJson(Map<String, dynamic> json) => Notification(
    id: json["id"],
    userId: json["user_id"],
    senderId: json["sender_id"],
    title: json["title"],
    message: json["message"],
    type: json["type"],
    isRead: json["is_read"],
    isSeen: json["is_seen"],
    date: json["date"],
    sender: json["sender"] != null ? Sender.fromJson(json["sender"]) : null,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "sender_id": senderId,
    "title": title,
    "message": message,
    "type": type,
    "is_read": isRead,
    "is_seen": isSeen,
    "date": date,
    "sender": sender?.toJson(),
  };
}
class Media {
  int? id;
  String? originalUrl;

  Media({
    this.id,
    this.originalUrl,
  });

  factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        originalUrl: json["original_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_url": originalUrl,
      };
}
class Sender {
  int? id;
  String? name;
  String? email;
   List<Media>? media;

  Sender({
    this.id,
    this.name,
    this.email,
    this.media
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    media:   json["media"] == null || json["media"].isEmpty ? null : 
             List<Media>.from(json["media"]
                .map((x) => Media.fromJson(x)))
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "media": media?.map((x) => x.toJson()).toList() ,
  };
}

class Pagination {
  dynamic total;
  dynamic page;
  dynamic pageSize;
  dynamic totalPages;
  dynamic remaining;
  dynamic nextPage;
  dynamic prevPage;

  Pagination({
    this.total,
    this.page,
    this.pageSize,
    this.totalPages,
    this.remaining,
    this.nextPage,
    this.prevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
    total: json["total"],
    page: json["page"],
    pageSize: json["page_size"],
    totalPages: json["total_pages"],
    remaining: json["remaining"],
    nextPage: json["next_page"],
    prevPage: json["prev_page"],
  );

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "page_size": pageSize,
    "total_pages": totalPages,
    "remaining": remaining,
    "next_page": nextPage,
    "prev_page": prevPage,
  };
}
