// To parse this JSON data, do
//
//     final inActiveProductsModel = inActiveProductsModelFromJson(jsonString);

import 'dart:convert';

DeletedProductsModel? deletedProductsModelFromJson(String str) =>
    str.isEmpty ? null : DeletedProductsModel.fromJson(json.decode(str));
String deletedProductsModelToJson(DeletedProductsModel? data) =>
    data == null ? '' : json.encode(data.toJson());

class DeletedProductsModel {
  bool? status;
  Data? data;
  String? message;

  DeletedProductsModel({
    this.status,
    this.data,
    this.message,
  });

  factory DeletedProductsModel.fromJson(Map<String, dynamic> json) =>
      DeletedProductsModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  List<Product>? products;
  Pagination? pagination;
  Data({
    this.products,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        products: json["products"] == null
            ? null
            : List<Product>.from(
                json["products"].map((x) => Product.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "products": products?.map((x) => x.toJson()).toList(),
        "pagination": pagination?.toJson(),
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

class Product {
  int? id;
  String? title;
  String? price;
  String? guid;
  String? discountPrice;
  String? rating;
  int? ratingCount;
  List<Media>? media;

  Product({
    this.id,
    this.title,
    this.price,
        this.guid,
    this.discountPrice,
    this.rating,
    this.ratingCount,
    this.media,
  });
  double get ratingAsDouble {
    if (rating == null || rating!.isEmpty) {
      return 0.0;
    }
    return double.tryParse(rating!) ?? 0.0;
  }

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        guid: json["guid"],
        discountPrice: json["discount_price"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
        media: json["media"] == null
            ? null
            : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "guid": guid,
        "discount_price": discountPrice,
        "rating": rating,
        "rating_count": ratingCount,
        "media": media?.map((x) => x.toJson()).toList(),
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
