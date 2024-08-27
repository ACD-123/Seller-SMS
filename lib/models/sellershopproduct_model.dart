import 'dart:convert';

SellerShopProductsModel? sellerShopProductsModelFromJson(String str) =>
    str.isNotEmpty ? SellerShopProductsModel.fromJson(json.decode(str)) : null;

String? sellerShopProductsModelToJson(SellerShopProductsModel? data) =>
    data != null ? json.encode(data.toJson()) : null;

class SellerShopProductsModel {
  bool? status;
  Data? data;
  String? message;

  SellerShopProductsModel({
    this.status,
    this.data,
    this.message,
  });

  factory SellerShopProductsModel.fromJson(Map<String, dynamic> json) =>
      SellerShopProductsModel(
        status: json["status"] ,
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        message: json["message"] ,
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
        products: json["products"] != null
            ? List<Product>.from(
                json["products"].map((x) => Product.fromJson(x)))
            : null,
        pagination: json["pagination"] != null
            ? Pagination.fromJson(json["pagination"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "products": products != null
            ? List<dynamic>.from(products!.map((x) => x.toJson()))
            : null,
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
        total: json["total"] ,
        page: json["page"] ,
        pageSize: json["page_size"] ,
        totalPages: json["total_pages"] ,
        remaining: json["remaining"],
        nextPage: json["next_page"] ,
        prevPage: json["prev_page"] ,
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
  String? discountPrice;
  String? discountPercentage;
  String? guid;
  String? rating;
  int? ratingCount;
  List<Media>? media;

  Product({
    this.id,
    this.title,
    this.price,
    this.discountPrice,
    this.discountPercentage,
    this.guid,
    this.rating,
    this.ratingCount,
    this.media,
  });
double ratingasdouble(){
  if(rating!.isEmpty || rating == null){
    return 0.0;
  }
  return double.tryParse(rating!) ?? 0.0;

}
  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        title: json["title"] ,
        price: json["price"],
        discountPrice: json["discount_price"] ,
         discountPercentage: json["dis_percentage"],
        guid: json["guid"],
        rating: json["rating"] ,
        ratingCount: json["rating_count"],
        media: json["media"] != null
            ? List<Media>.from(json["media"].map((x) => Media.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "discount_price": discountPrice,
         "discountPercentage": discountPercentage,
        "guid": guid,
        "rating": rating,
        "rating_count": ratingCount,
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
        id: json["id"] ,
        originalUrl: json["original_url"] ,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_url": originalUrl,
      };
}
