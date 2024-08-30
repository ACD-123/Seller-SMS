import 'dart:convert';

OrderHistoryCountsModel? orderHistoryCountsFromJson(String str) => str.isNotEmpty
    ? OrderHistoryCountsModel.fromJson(json.decode(str))
    : null;

String? orderHistoryCountsToJson(OrderHistoryCountsModel? data) => data != null
    ? json.encode(data.toJson())
    : null;

class OrderHistoryCountsModel {
  bool? status;
  Data? data;
  String? message;

  OrderHistoryCountsModel({
    this.status,
    this.data,
    this.message,
  });

  factory OrderHistoryCountsModel.fromJson(Map<String, dynamic> json) =>
      OrderHistoryCountsModel(
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
  dynamic completed;
  dynamic pending;
  dynamic active;
  dynamic rejected;
  dynamic refunded;
  dynamic total;

  Data({
    this.completed,
    this.pending,
    this.active,
    this.rejected,
    this.refunded,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        completed: json["completed"],
        pending: json["pending"],
        active: json["active"],
        rejected: json["rejected"],
        refunded: json["refunded"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "completed": completed,
        "pending": pending,
        "active": active,
        "rejected": rejected,
        "refunded": refunded,
        "total": total,
      };
}
