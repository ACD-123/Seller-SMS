import 'dart:convert';

OrderDetailsModel? orderDetailsModelFromJson(String str) =>
    OrderDetailsModel.fromJson(json.decode(str));

String orderDetailsModelToJson(OrderDetailsModel? data) =>
    json.encode(data?.toJson());

class OrderDetailsModel {
  bool? status;
  Data? data;
  String? message;

  OrderDetailsModel({
    this.status,
    this.data,
    this.message,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      OrderDetailsModel(
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
  dynamic tax;
  dynamic shippingCost;
  String? note;
  String? orderid;
  
  List<OrderProductId>? orderProductIds;
  User? user;

  Data({
    this.id,
    this.totalPrice,
    this.subtotalPrice,
    this.discount,
    this.tax,
    this.shippingCost,
    this.note,
    this.orderid,
    this.orderProductIds,
  
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        totalPrice: json["total_price"],
        subtotalPrice: json["subtotal_price"],
        discount: json["discount"],
        tax: json["tax"],
        shippingCost: json["shipping_cost"],
        note: json["note"],
        orderid: json["orderid"],
        orderProductIds: json["order_product_ids"] != null
            ? List<OrderProductId>.from(json["order_product_ids"]
                .map((x) => OrderProductId.fromJson(x)))
            : null,
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
         
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "total_price": totalPrice,
        "subtotal_price": subtotalPrice,
        "discount": discount,
        "tax": tax,
        "shipping_cost": shippingCost,
        "note": note,
        "orderid": orderid,
        "order_product_ids":
            orderProductIds != null ? orderProductIds!.map((x) => x.toJson()).toList() : null,
        "user": user?.toJson(),
        
      };
}
class OrderProductId {
  int? id;
  int? orderId;
  int? productId;
  dynamic quantity;
  String? status;
  int? sellerId;
  Product? product;
  List<OrderAttribute>? orderAttribute;

  OrderProductId({
    this.id,
    this.orderId,
    this.productId,
    this.quantity,
    this.status,
    this.sellerId,
    this.product,
    this.orderAttribute,
  });

  factory OrderProductId.fromJson(Map<String, dynamic> json) => OrderProductId(
        id: json["id"],
        orderId: json["order_id"],
        productId: json["product_id"],
        quantity: json["quantity"],
        status: json["status"],
        sellerId: json["seller_id"],
        product: json["product"] != null ? Product.fromJson(json["product"]) : null,
        orderAttribute: json["order_attribute"] != null
            ? List<OrderAttribute>.from(json["order_attribute"]
                .map((x) => OrderAttribute.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_id": orderId,
        "product_id": productId,
        "quantity": quantity,
        "status": status,
        "seller_id": sellerId,
        "product": product?.toJson(),
        "order_attribute":
            orderAttribute != null ? orderAttribute!.map((x) => x.toJson()).toList() : null,
      };
}

class OrderAttribute {
  int? id;
  int? orderAttributeId;
  int? attributeId;
  Attribute? attribute;

  OrderAttribute({
    this.id,
    this.orderAttributeId,
    this.attributeId,
    this.attribute,
  });

  factory OrderAttribute.fromJson(Map<String, dynamic> json) => OrderAttribute(
        id: json["id"],
        orderAttributeId: json["order_attribute_id"],
        attributeId: json["attribute_id"],
        attribute: json["attribute"] != null ? Attribute.fromJson(json["attribute"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "order_attribute_id": orderAttributeId,
        "attribute_id": attributeId,
        "attribute": attribute?.toJson(),
      };
}

class Attribute {
  int? id;
  int? productId;
  String? name;

  Attribute({
    this.id,
    this.productId,
    this.name,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        productId: json["product_id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "name": name,
      };
}

class Product {
  int? id;
  String? title;
  dynamic price;
  dynamic discountPrice;
  dynamic disPercentage;
  List<Media>? media;

  Product({
    this.id,
    this.title,
    this.price,
    this.discountPrice,
    this.disPercentage,
    this.media,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        discountPrice: json["discount_price"],
        disPercentage: json["dis_percentage"],
        media: json["media"] == null || json["media"].isEmpty ? null : 
             List<Media>.from(json["media"]
                .map((x) => Media.fromJson(x)))
        
    ,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "discount_price": discountPrice,
        "dis_percentage": disPercentage,
        "media":   media == null || media!.isEmpty
      ? [] : 
        
       media?.map((x) => x.toJson()).toList() ,
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

class Media {
  int? id;
  String? originalUrl;

  Media({
    this.id,
    this.originalUrl,
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
