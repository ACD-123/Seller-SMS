import 'dart:convert';

SalesReportEarningRefundModel? salesReportEarningRefundFromJson(String str) => SalesReportEarningRefundModel.fromJson(json.decode(str));

String salesReportEarningRefundToJson(SalesReportEarningRefundModel? data) => json.encode(data?.toJson());

class SalesReportEarningRefundModel {
    bool? status;
    Data? data;
    String? message;

    SalesReportEarningRefundModel({
        this.status,
        this.data,
        this.message,
    });

    factory SalesReportEarningRefundModel.fromJson(Map<String, dynamic> json) => SalesReportEarningRefundModel(
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
    dynamic totalEarnings;
    dynamic completedEarnings;
    dynamic refundedEarnings;
    dynamic refundPercentage;
    dynamic earningPercentage;

    Data({
        this.totalEarnings,
        this.completedEarnings,
        this.refundedEarnings,
        this.refundPercentage,
        this.earningPercentage,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalEarnings: json["totalEarnings"] ,
        completedEarnings: json["completedEarnings"],
        refundedEarnings: json["refundedEarnings"],
        refundPercentage: json["refundPercentage"],
        earningPercentage: json["earningPercentage"],
    );

    Map<String, dynamic> toJson() => {
        "totalEarnings": totalEarnings,
        "completedEarnings": completedEarnings,
        "refundedEarnings": refundedEarnings,
        "refundPercentage": refundPercentage,
        "earningPercentage": earningPercentage,
    };
}
