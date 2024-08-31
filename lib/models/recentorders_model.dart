import 'dart:convert';

RecentOrdersModel? recentOrdersModelFromJson(String str) =>
    RecentOrdersModel.fromJson(json.decode(str));

String recentOrdersModelToJson(RecentOrdersModel? data) =>
    json.encode(data?.toJson());

class RecentOrdersModel {
  bool? status;
  Data? data;
  String? message;

  RecentOrdersModel({
    this.status,
    this.data,
    this.message,
  });

  factory RecentOrdersModel.fromJson(Map<String, dynamic> json) =>
      RecentOrdersModel(
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
  List<Order>? orders;
  Pagination? pagination;

  Data({
    this.orders,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: json["orders"] != null
            ? List<Order>.from(json["orders"].map((x) => Order.fromJson(x)))
            : null,
        pagination: json["pagination"] != null
            ? Pagination.fromJson(json["pagination"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "orders": orders != null
            ? List<dynamic>.from(orders!.map((x) => x.toJson()))
            : null,
        "pagination": pagination?.toJson(),
      };
}

class Order {
  int? id;
  String? orderid;
  String? orderStatus;
   String? note;
   User? user;
  List<OrderProductId>? orderProductIds;

  Order({
    this.id,
    this.orderid,
    this.orderStatus,
    this.note,
    this.user,
    this.orderProductIds,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"] ,
        orderid: json["orderid"] ,
        orderStatus: json["order_status"] ,
        note: json["note"] ,
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        orderProductIds: json["order_product_ids"] != null
            ? List<OrderProductId>.from(
                json["order_product_ids"].map((x) => OrderProductId.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "orderid": orderid,
        "order_status": orderStatus,
        "note": note,
        "user": user?.toJson(),
        "order_product_ids": orderProductIds != null
            ? List<dynamic>.from(orderProductIds!.map((x) => x.toJson()))
            : null,
      };
}

class OrderProductId {
  int? id;
  Product? product;

  OrderProductId({
    this.id,
    this.product,
  });

  factory OrderProductId.fromJson(Map<String, dynamic> json) => OrderProductId(
        id: json["id"] ,
        product: json["product"] != null ? Product.fromJson(json["product"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product": product?.toJson(),
      };
}

class Product {
  int? id;
  List<Media>? media;

  Product({
    this.id,
    this.media,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] ,
        media: json["media"] != null
            ? List<Media>.from(json["media"].map((x) => Media.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "media": media != null
            ? List<dynamic>.from(media!.map((x) => x.toJson()))
            : null,
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
class User {
    int? id;
    List<Media>? media;

    User({
        this.id,
        this.media,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        media: json["media"] == null || json["media"].isEmpty ? null : 
        
        
        
        List<Media>.from(json["media"].map((x) => Media.fromJson(x))) ,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "media": media == null || media!.isEmpty
      ? [] : 
        
        List<dynamic>.from(media!.map((x) => x.toJson())) ,
    };
}

class Pagination {
  dynamic total;
  dynamic page;
  dynamic pageSize;
  dynamic totalPages;
  dynamic remaining;
  dynamic nextPage;
  dynamic prevPage;

  Pagination({
    this.total,
    this.page,
    this.pageSize,
    this.totalPages,
    this.remaining,
    this.nextPage,
    this.prevPage,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        page: json["page"],
        pageSize: json["page_size"],
        totalPages: json["total_pages"],
        remaining: json["remaining"],
        nextPage: json["next_page"],
        prevPage: json["prev_page"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "page_size": pageSize,
        "total_pages": totalPages,
        "remaining": remaining,
        "next_page": nextPage,
        "prev_page": prevPage,
      };
}
