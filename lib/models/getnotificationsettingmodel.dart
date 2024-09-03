import 'dart:convert';

GetNotificationSettingModel? getNotificationSettingModelFromJson(String str) =>
    str.isNotEmpty ? GetNotificationSettingModel.fromJson(json.decode(str)) : null;

String? getNotificationSettingModelToJson(GetNotificationSettingModel? data) =>
    data != null ? json.encode(data.toJson()) : null;

class GetNotificationSettingModel {
    bool? status;
    Data? data;
    String? message;

    GetNotificationSettingModel({
        this.status,
        this.data,
        this.message,
    });

    factory GetNotificationSettingModel.fromJson(Map<String, dynamic> json) => GetNotificationSettingModel(
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
    dynamic importantNotification;
    dynamic chatsNotification;
    dynamic buyingNotification;
    dynamic sellingNotification;

    Data({
        this.importantNotification,
        this.chatsNotification,
        this.buyingNotification,
        this.sellingNotification,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        importantNotification: json["important_notification"],
        chatsNotification: json["chats_notification"],
        buyingNotification: json["buying_notification"],
        sellingNotification: json["selling_notification"],
    );

    Map<String, dynamic> toJson() => {
        "important_notification": importantNotification,
        "chats_notification": chatsNotification,
        "buying_notification": buyingNotification,
        "selling_notification": sellingNotification,
    };
}
