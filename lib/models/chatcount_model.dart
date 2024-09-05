import 'dart:convert';

GetChatCountModel? getChatCountModelFromJson(String str) => GetChatCountModel.fromJson(json.decode(str));

String getChatCountModelToJson(GetChatCountModel? data) => json.encode(data?.toJson());

class GetChatCountModel {
    bool? status;
    Data? data;
    String? message;

    GetChatCountModel({
        this.status,
        this.data,
        this.message,
    });

    factory GetChatCountModel.fromJson(Map<String, dynamic> json) => GetChatCountModel(
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
    dynamic count;

    Data({
        this.count,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
    };
}
