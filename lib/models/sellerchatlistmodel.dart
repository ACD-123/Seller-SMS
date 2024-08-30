import 'dart:convert';

// To parse this JSON data, do:
// final sellerChatListModel = sellerChatListModelFromJson(jsonString);

SellerChatListModel sellerChatListModelFromJson(String str) =>
    SellerChatListModel.fromJson(json.decode(str));

String sellerChatListModelToJson(SellerChatListModel data) =>
    json.encode(data.toJson());

class SellerChatListModel {
  List<Datum>? data;
  bool? status;
  String? message;

  SellerChatListModel({
    required this.data,
    required this.status,
    required this.message,
  });

  factory SellerChatListModel.fromJson(Map<String, dynamic> json) =>
      SellerChatListModel(
        data: json["data"] != null
            ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x)))
            : null,
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": data != null
            ? List<dynamic>.from(data!.map((x) => x.toJson()))
            : null,
        "status": status,
        "message": message,
      };
}

class Datum {
  String? uid;
  String? participants;
  String? senderName;
  String? senderLastName;
  String? receiverName;
  String? receiverLastName;
  String? senderProfileImage;
  String? receiverProfileImage;
  int? id;
  String? date;
  DateTime? dateNew;
  String? message;
  int? readCount;
  int? seenCount;

  Datum({
    required this.uid,
    required this.participants,
    required this.senderName,
    required this.senderLastName,
    required this.receiverName,
    required this.receiverLastName,
    required this.senderProfileImage,
    required this.receiverProfileImage,
    required this.id,
    required this.date,
    required this.dateNew,
    required this.message,
    required this.readCount,
    required this.seenCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        uid: json["uid"],
        participants: json["participants"],
        senderName: json["sender_name"],
        senderLastName: json["sender_last_name"],
        receiverName: json["receiver_name"],
        receiverLastName: json["receiver_last_name"],
        senderProfileImage: json["sender_profile_image"],
        receiverProfileImage: json["receiver_profile_image"],
        id: json["id"],
        date: json["date"],
        dateNew: json["date_new"] != null
            ? DateTime.parse(json["date_new"])
            : null,
        message: json["message"],
        readCount: json["read_count"],
        seenCount: json["seen_count"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "participants": participants,
        "sender_name": senderName,
        "sender_last_name": senderLastName,
        "receiver_name": receiverName,
        "receiver_last_name": receiverLastName,
        "sender_profile_image": senderProfileImage,
        "receiver_profile_image": receiverProfileImage,
        "id": id,
        "date": date,
        "date_new": dateNew?.toIso8601String(),
        "message": message,
        "read_count": readCount,
        "seen_count": seenCount,
      };
}
