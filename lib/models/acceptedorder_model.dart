

import 'dart:convert';

ActiveOrdersModel? activeOrdersModelFromJson(String str) => str.isNotEmpty ? ActiveOrdersModel.fromJson(json.decode(str)) : null;

String? activeOrdersModelToJson(ActiveOrdersModel? data) => data != null ? json.encode(data.toJson()) : null;

class ActiveOrdersModel {
    bool? status;
    Data? data;
    String? message;

    ActiveOrdersModel({
        this.status,
        this.data,
        this.message,
    });

    factory ActiveOrdersModel.fromJson(Map<String, dynamic> json) => ActiveOrdersModel(
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
    List<Order>? orders;
    Pagination? pagination;

    Data({
        this.orders,
        this.pagination,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        orders: json["orders"] != null ? List<Order>.from(json["orders"].map((x) => Order.fromJson(x))) : null,
        pagination: json["pagination"] != null ? Pagination.fromJson(json["pagination"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "orders": orders != null ? List<dynamic>.from(orders!.map((x) => x.toJson())) : null,
        "pagination": pagination?.toJson(),
    };
}

class Order {
    int? id;
    String? note;
    String? orderid;
    User? user;

    Order({
        this.id,
        this.note,
        this.orderid,
        this.user,
    });

    factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        note: json["note"],
        orderid: json["orderid"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "note": note,
        "orderid": orderid,
        "user": user?.toJson(),
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
