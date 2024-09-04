// To parse this JSON data, do
//
//     final getCouponByIdModel = getCouponByIdModelFromJson(jsonString);

import 'dart:convert';

GetCouponByIdModel? getCouponByIdModelFromJson(String str) => 
    str.isNotEmpty ? GetCouponByIdModel.fromJson(json.decode(str)) : null;

String? getCouponByIdModelToJson(GetCouponByIdModel? data) => 
    data != null ? json.encode(data.toJson()) : null;

class GetCouponByIdModel {
    bool? status;
    Data? data;
    String? message;

    GetCouponByIdModel({
        this.status,
        this.data,
        this.message,
    });

    factory GetCouponByIdModel.fromJson(Map<String, dynamic> json) => GetCouponByIdModel(
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
    int? id;
    String? title;
    dynamic code;
    String? startDate;
    String? endDate;
   dynamic minOrder;
    dynamic discount;

    Data({
        this.id,
        this.title,
        this.code,
        this.startDate,
        this.endDate,
        this.minOrder,
        this.discount,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        code: json["code"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        minOrder: json["min_order"],
        discount: json["discount"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "code": code,
        "start_date": startDate,
        "end_date": endDate,
        "min_order": minOrder,
        "discount": discount,
    };
}
