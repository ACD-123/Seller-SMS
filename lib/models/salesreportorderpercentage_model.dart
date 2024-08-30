import 'dart:convert';

SalesReportOrderPercentage? salesReportOrderPercentageFromJson(String str) => SalesReportOrderPercentage.fromJson(json.decode(str));

String salesReportOrderPercentageToJson(SalesReportOrderPercentage? data) => json.encode(data?.toJson());

class SalesReportOrderPercentage {
    bool? status;
    Data? data;
    String? message;

    SalesReportOrderPercentage({
        this.status,
        this.data,
        this.message,
    });

    factory SalesReportOrderPercentage.fromJson(Map<String, dynamic> json) => SalesReportOrderPercentage(
        status: json["status"] as bool?,
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        message: json["message"] as String?,
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
    };
}

class Data {
    dynamic pendingPercentage;
    dynamic acceptedPercentage;
    dynamic rejectedPercentage;
    dynamic completedPercentage;
    dynamic refundedPercentage;
    dynamic totalOrders;

    Data({
        this.pendingPercentage,
        this.acceptedPercentage,
        this.rejectedPercentage,
        this.completedPercentage,
        this.refundedPercentage,
        this.totalOrders,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        pendingPercentage: json["pendingPercentage"] ,
        acceptedPercentage: json["acceptedPercentage"] ,
        rejectedPercentage: json["rejectedPercentage"] ,
        completedPercentage: json["completedPercentage"],
        refundedPercentage: json["refundedPercentage"] ,
        totalOrders: json["totalOrders"],
    );

    Map<String, dynamic> toJson() => {
        "pendingPercentage": pendingPercentage,
        "acceptedPercentage": acceptedPercentage,
        "rejectedPercentage": rejectedPercentage,
        "completedPercentage": completedPercentage,
        "refundedPercentage": refundedPercentage,
        "totalOrders": totalOrders,
    };
}
