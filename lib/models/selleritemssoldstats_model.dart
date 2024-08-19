import 'dart:convert';

SellerItemsSoldStatsModel sellerItemsSoldStatsModelFromJson(String str) =>
    SellerItemsSoldStatsModel.fromJson(json.decode(str));

String sellerItemsSoldStatsModelToJson(SellerItemsSoldStatsModel data) =>
    json.encode(data.toJson());

class SellerItemsSoldStatsModel {
  bool? status;
  Data? data;
  String? message;

  SellerItemsSoldStatsModel({
    this.status,
    this.data,
    this.message,
  });

  factory SellerItemsSoldStatsModel.fromJson(Map<String, dynamic> json) =>
      SellerItemsSoldStatsModel(
        status: json["status"] as bool?,
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  int? totalProductsSoldCurrentMonth;
  dynamic percentageGrowth;
  String? selectedMonth;

  Data({
    this.totalProductsSoldCurrentMonth,
    this.percentageGrowth,
    this.selectedMonth,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
      totalProductsSoldCurrentMonth: json["totalProductsSoldCurrentMonth"],
      percentageGrowth: json["percentageGrowth"],
      selectedMonth: json["selectedMonth"]);

  Map<String, dynamic> toJson() => {
        "totalProductsSoldCurrentMonth": totalProductsSoldCurrentMonth,
        "percentageGrowth": percentageGrowth,
        "selectedMonth": selectedMonth,
      };
}
