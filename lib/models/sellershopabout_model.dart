import 'dart:convert';

SellerShopAboutModel sellerShopAboutModelFromJson(String str) =>
    SellerShopAboutModel.fromJson(json.decode(str));

String sellerShopAboutModelToJson(SellerShopAboutModel data) =>
    json.encode(data.toJson());

class SellerShopAboutModel {
  bool? status;
  Data? data;
  String? message;

  SellerShopAboutModel({
    this.status,
    this.data,
    this.message,
  });

  factory SellerShopAboutModel.fromJson(Map<String, dynamic> json) =>
      SellerShopAboutModel(
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
  int? id;
  int? userId;
  String? shopName;
  String? country;
  String? guid;
  String? shopDescription;
  String? joined;
  String? coverImage;
  String? mainImage;
  List<String>? banners;
  List<Category>? category;
  String? rating;
  int? ratingCount;
  int? productCount;
  List<Media>? media;

  Data({
    this.id,
    this.userId,
    this.shopName,
    this.country,
    this.guid,
    this.shopDescription,
    this.joined,
    this.coverImage,
    this.mainImage,
    this.banners,
    this.category,
    this.rating,
    this.ratingCount,
    this.productCount,
    this.media,
  });
double  ratingAsDouble() {
    if (rating == null || rating!.isEmpty) {
      return 0.0; 
    }
    return double.tryParse(rating!) ?? 0.0;
  }
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        userId: json["user_id"],
        shopName: json["shop_name"],
        country: json["country"],
        guid: json["guid"],
        shopDescription: json["shop_description"],
        joined: json["joined"],
        coverImage: json["cover_image"],
        mainImage: json["main_image"],
        banners: json["banners"] != null
            ? List<String>.from(json["banners"].map((x) => x as String))
            : null,
        category: json["category"] != null
            ? List<Category>.from(
                json["category"].map((x) => Category.fromJson(x)))
            : null,
        rating: json["rating"],
        ratingCount: json["rating_count"],
        productCount: json["product_count"],
        media: json["media"] != null
            ? List<Media>.from(json["media"].map((x) => Media.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "shop_name": shopName,
        "country": country,
        "guid": guid,
        "shop_description": shopDescription,
        "joined": joined,
        "cover_image": coverImage,
        "main_image": mainImage,
        "banners": banners != null ? List<dynamic>.from(banners!) : null,
        "category": category != null
            ? List<dynamic>.from(category!.map((x) => x.toJson()))
            : null,
        "rating": rating,
        "rating_count": ratingCount,
        "product_count": productCount,
        "media": media != null
            ? List<dynamic>.from(media!.map((x) => x.toJson()))
            : null,
      };
}

class Category {
  int? id;
  String? name;
  List<Media>? media;

  Category({
    this.id,
    this.name,
    this.media,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        media: json["media"] != null
            ? List<Media>.from(json["media"].map((x) => Media.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
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
