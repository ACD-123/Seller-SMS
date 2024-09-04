import 'dart:convert';

GetCouponModel? getCouponModelFromJson(String str) => GetCouponModel.fromJson(json.decode(str));

String getCouponModelToJson(GetCouponModel? data) => json.encode(data?.toJson());

class GetCouponModel {
  bool? status;
  Data? data;
  String? message;

  GetCouponModel({
    this.status,
    this.data,
    this.message,
  });

  factory GetCouponModel.fromJson(Map<String, dynamic>? json) => GetCouponModel(
        status: json?["status"],
        data: json?["data"] != null ? Data.fromJson(json!["data"]) : null,
        message: json?["message"],
  );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
  };
}

class Data {
  List<ActiveCoupon>? activeCoupons;
  List<ActiveCoupon>? expiredCoupons;
  dynamic activeCount;
  dynamic expiredCount;

  Data({
    this.activeCoupons,
    this.expiredCoupons,
    this.activeCount,
    this.expiredCount,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
        activeCoupons: json?["active_coupons"] != null
            ? List<ActiveCoupon>.from(
                json!["active_coupons"].map((x) => ActiveCoupon.fromJson(x)))
            : null,
        expiredCoupons: json?["expired_coupons"] != null
            ? List<ActiveCoupon>.from(
                json!["expired_coupons"].map((x) => ActiveCoupon.fromJson(x)))
            : null,
        activeCount: json?["active_count"],
        expiredCount: json?["expired_count"],
  );

  Map<String, dynamic> toJson() => {
        "active_coupons": activeCoupons != null
            ? List<dynamic>.from(activeCoupons!.map((x) => x.toJson()))
            : null,
        "expired_coupons": expiredCoupons != null
            ? List<dynamic>.from(expiredCoupons!.map((x) => x.toJson()))
            : null,
        "active_count": activeCount,
        "expired_count": expiredCount,
  };
}

class ActiveCoupon {
  int? id;
  String? title;
  dynamic code;
  String? endDate;
  dynamic discount;

  ActiveCoupon({
    this.id,
    this.title,
    this.code,
    this.endDate,
    this.discount,
  });

  factory ActiveCoupon.fromJson(Map<String, dynamic>? json) => ActiveCoupon(
        id: json?["id"],
        title: json?["title"],
        code: json?["code"],
        endDate: json?["end_date"],
        discount: json?["discount"],
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "code": code,
        "end_date": endDate,
        "discount": discount,
  };
}
