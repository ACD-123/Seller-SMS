import 'dart:convert';

NotificationsCountModel? notificationsCountModelFromJson(String str) => 
    str.isNotEmpty ? NotificationsCountModel.fromJson(json.decode(str)) : null;

String? notificationsCountModelToJson(NotificationsCountModel? data) => 
    data != null ? json.encode(data.toJson()) : null;

class NotificationsCountModel {
    bool? status;
    Data? data;
    String? message;

    NotificationsCountModel({
        this.status,
        this.data,
        this.message,
    });

    factory NotificationsCountModel.fromJson(Map<String, dynamic> json) => NotificationsCountModel(
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
    dynamic total;

    Data({
        this.total,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
    };
}
