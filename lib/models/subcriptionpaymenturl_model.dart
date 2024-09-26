import 'dart:convert';

GetSubscriptionPaymentUrlModel? getSubscriptionPaymentUrlModelFromJson(
    String? str) {
  if (str == null) return null;
  return GetSubscriptionPaymentUrlModel.fromJson(json.decode(str));
}

String? getSubscriptionPaymentUrlModelToJson(
    GetSubscriptionPaymentUrlModel? data) {
  if (data == null) return null;
  return json.encode(data.toJson());
}

class GetSubscriptionPaymentUrlModel {
  bool? status;
  Data? data;
  String? message;

  GetSubscriptionPaymentUrlModel({
    this.status,
    this.data,
    this.message,
  });

  factory GetSubscriptionPaymentUrlModel.fromJson(Map<String, dynamic> json) =>
      GetSubscriptionPaymentUrlModel(
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
  int? status;
  String? paymentUrl;

  Data({
    this.status,
    this.paymentUrl,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        status: json["status"],
        paymentUrl: json["payment_url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "payment_url": paymentUrl,
      };
}
