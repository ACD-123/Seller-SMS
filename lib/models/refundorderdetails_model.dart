import 'dart:convert';

RefundOrderDetailsModel refundOrderDetailsFromJson(String str) => RefundOrderDetailsModel.fromJson(json.decode(str));

String refundOrderDetailsToJson(RefundOrderDetailsModel data) => json.encode(data.toJson());

class RefundOrderDetailsModel {
    bool? status;
    Data? data;
    String? message;

    RefundOrderDetailsModel({
        required this.status,
        required this.data,
        required this.message,
    });

    factory RefundOrderDetailsModel.fromJson(Map<String, dynamic> json) => RefundOrderDetailsModel(
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
  
   dynamic totalPrice;
   dynamic subtotalPrice;
   dynamic discount;
   dynamic orderid;
   
    dynamic shippingCost;

    String? note;
 String? address;
 String? phonenumber;
    dynamic couponDiscount;
    String? date;
      User? user;
    List<OrderProductId>? orderProductIds;

    Data({
        required this.id,
        required this.orderid,
        required this.totalPrice,
        required this.subtotalPrice,
        required this.discount,
        required this.shippingCost,
        required this.note,
        required this.couponDiscount,
        required this.date,
        required this.orderProductIds,
        required this.user,
         required this.address,
        required this.phonenumber,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        totalPrice: json["total_price"],
        subtotalPrice: json["subtotal_price"],
        orderid: json["orderid"],
        discount: json["discount"],
        shippingCost: json["shipping_cost"],
        note: json["note"],
        couponDiscount: json["coupon_discount"],
        address: json["address"],
        phonenumber: json["phone"],
        date: json["date"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        orderProductIds: json["order_product_ids"] != null ? List<OrderProductId>.from(json["order_product_ids"].map((x) => OrderProductId.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "total_price": totalPrice,
        "subtotal_price": subtotalPrice,
        "discount": discount,
        "shipping_cost": shippingCost,
        "note": note,
        "coupon_discount": couponDiscount,
        "date": date,
        "orderid": orderid,
        "address": address,
        "phonenumber": phonenumber,
         "user": user?.toJson(),
        "order_product_ids": orderProductIds != null ? List<dynamic>.from(orderProductIds!.map((x) => x.toJson())) : null,
    };
}

class OrderProductId {
    int? id;
    int? orderId;
    int? productId;
    dynamic quantity;
    dynamic status;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic sellerId;
    Refund? refund;
    Product? product;
    List<OrderAttribute>? orderAttribute;

    OrderProductId({
        required this.id,
        required this.orderId,
        required this.productId,
        required this.quantity,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.sellerId,
        required this.refund,
        required this.product,
        required this.orderAttribute,
    });

    factory OrderProductId.fromJson(Map<String, dynamic> json) => OrderProductId(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        status: json["status"],
        createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
        updatedAt: json["updated_at"] != null ? DateTime.parse(json["updated_at"]) : null,
        sellerId: json["seller_id"],
        refund: json["refund"] != null ? Refund.fromJson(json["refund"]) : null,
        product: json["product"] != null ? Product.fromJson(json["product"]) : null,
        orderAttribute: json["order_attribute"] != null ? List<OrderAttribute>.from(json["order_attribute"].map((x) => OrderAttribute.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "seller_id": sellerId,
        "refund": refund?.toJson(),
        "product": product?.toJson(),
        "order_attribute": orderAttribute != null ? List<dynamic>.from(orderAttribute!.map((x) => x.toJson())) : null,
    };
}

class OrderAttribute {
    int? id;
    Attribute? attribute;

    OrderAttribute({
        required this.id,
        required this.attribute,
    });

    factory OrderAttribute.fromJson(Map<String, dynamic> json) => OrderAttribute(
        id: json["id"],
        attribute: json["attribute"] != null ? Attribute.fromJson(json["attribute"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attribute": attribute?.toJson(),
    };
}

class Attribute {
    int? id;
    String? name;

    Attribute({
        required this.id,
        required this.name,
    });

    factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}

class Product {
    dynamic id;
    String? title;
    String? price;
    dynamic discountPrice;
    dynamic status;
    dynamic sellerGuid;
    dynamic disPercentage;
    List<Media>? media;

    Product({
        required this.id,
        required this.title,
        required this.price,
        required this.discountPrice,
        required this.status,
        required this.sellerGuid,
        required this.disPercentage,
        required this.media,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        discountPrice: json["discount_price"],
        status: json["status"],
        sellerGuid: json["seller_guid"],
        disPercentage: json["dis_percentage"],
        media: 
        
        
       json["media"] == null || json["media"].isEmpty ? null : 
        
        List<Media>.from(json["media"].map((x) => Media.fromJson(x))) ,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "discount_price": discountPrice,
        "status": status,
        "seller_guid": sellerGuid,
        "dis_percentage": disPercentage,
        "media":  media == null || media!.isEmpty
      ? [] : 
        List<dynamic>.from(media!.map((x) => x.toJson())),
    };
}

class Media {
    int? id;
    String? originalUrl;

    Media({
        required this.id,
        required this.originalUrl,
    });

    factory Media.fromJson(Map<String, dynamic> json) => Media(
        id: json["id"],
        originalUrl: json["original_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "original_url": originalUrl,
    };
}

class User {
  int? id;
  String? name;
  String? phoneCode;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? provider;

  User({
    this.id,
    this.name,
    this.phoneCode,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.provider,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zip_code"],
        provider: json["provider"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "zip_code": zipCode,
        "provider": provider,
      };
}

class Refund {
    int? id;
    String? reason;
    String? status;
    List<Media>? media;

    Refund({
        required this.id,
        required this.reason,
        required this.status,
        required this.media,
    });

    factory Refund.fromJson(Map<String, dynamic> json) => Refund(
        id: json["id"],
        reason: json["reason"],
        status: json["status"],
        media: json["media"] != null ? List<Media>.from(json["media"].map((x) => Media.fromJson(x))) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "reason": reason,
        "status": status,
        "media": media != null ? List<dynamic>.from(media!.map((x) => x.toJson())) : null,
    };
}
