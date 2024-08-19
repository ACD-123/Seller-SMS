import 'dart:convert';

// To parse this JSON data, do
//
//     final sellerTotalSalesStatsModel = sellerTotalSalesStatsModelFromJson(jsonString);

SellerTotalSalesStatsModel sellerTotalSalesStatsModelFromJson(String str) =>
    SellerTotalSalesStatsModel.fromJson(json.decode(str));

String sellerTotalSalesStatsModelToJson(SellerTotalSalesStatsModel data) =>
    json.encode(data.toJson());

class SellerTotalSalesStatsModel {
  bool? status;
  Data? data;
  String? message;

  SellerTotalSalesStatsModel({
    this.status,
    this.data,
    this.message,
  });

  factory SellerTotalSalesStatsModel.fromJson(Map<String, dynamic> json) =>
      SellerTotalSalesStatsModel(
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
  dynamic currentMonthEarning;
  dynamic percentageGrowth;
  String? selectedMonth;

  Data({
    this.currentMonthEarning,
    this.percentageGrowth,
    this.selectedMonth,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        currentMonthEarning: json["currentMonthEarning"],
        percentageGrowth: json["percentageGrowth"],
        selectedMonth: json["selectedMonth"],
      );

  Map<String, dynamic> toJson() => {
        "currentMonthEarning": currentMonthEarning,
        "percentageGrowth": percentageGrowth,
        "selectedMonth": selectedMonth,
      };
}
