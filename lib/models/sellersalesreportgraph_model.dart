import 'dart:convert';

SellerSalesReportGraphModel sellerOrderGraphModelFromJson(String str) =>
    SellerSalesReportGraphModel.fromJson(json.decode(str));

String sellerOrderGraphModelToJson(SellerSalesReportGraphModel data) =>
    json.encode(data.toJson());

class SellerSalesReportGraphModel {
  bool? status;
  Data? data;
  String? message;

  SellerSalesReportGraphModel({
    this.status,
    this.data,
    this.message,
  });

  factory SellerSalesReportGraphModel.fromJson(Map<String, dynamic> json) =>
      SellerSalesReportGraphModel(
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
  int? totalOrders;
  List<int>? ordersByMonthMobile;

  Data({
    this.totalOrders,
    this.ordersByMonthMobile,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalOrders: json["totalOrders"] as int?,
        ordersByMonthMobile: json["ordersByMonthMobile"] != null
            ? List<int>.from(json["ordersByMonthMobile"].map((x) => x as int))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "totalOrders": totalOrders,
        "ordersByMonthMobile": ordersByMonthMobile != null
            ? List<dynamic>.from(ordersByMonthMobile!.map((x) => x))
            : null,
      };
}
