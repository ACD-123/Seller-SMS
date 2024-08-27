import 'dart:convert';

SellerShopFeedbackModel? sellerShopFeedbackModelFromJson(String str) =>
    SellerShopFeedbackModel.fromJson(json.decode(str));

String sellerShopFeedbackModelToJson(SellerShopFeedbackModel? data) =>
    json.encode(data?.toJson());

class SellerShopFeedbackModel {
  bool? status;
  Data? data;
  String? message;

  SellerShopFeedbackModel({
    this.status,
    this.data,
    this.message,
  });

  factory SellerShopFeedbackModel.fromJson(Map<String, dynamic>? json) =>
      SellerShopFeedbackModel(
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
  List<Feedback>? feedback;
  Pagination? pagination;
  SellerData? sellerdata;

  Data({
    this.feedback,
    this.pagination,
    this.sellerdata,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
        feedback: json?["feedback"] != null
            ? List<Feedback>.from(
                json!["feedback"].map((x) => Feedback.fromJson(x)))
            : null,
        pagination: json?["pagination"] != null
            ? Pagination.fromJson(json!["pagination"])
            : null,
         sellerdata: json?["seller"] != null
            ? SellerData.fromJson(json!["seller"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "feedback": feedback != null
            ? List<dynamic>.from(feedback!.map((x) => x.toJson()))
            : null,
        "pagination": pagination?.toJson(),
         "seller": sellerdata?.toJson(),
      };
}

class Feedback {
  int? id;
  int? productId;
  int? userId;
  String? comment;
  dynamic sellerComment;
  dynamic adminComment;
  String? ratings;
  String? date;
  User? user;
   Product? product;

  Feedback({
    this.id,
    this.productId,
    this.userId,
    this.comment,
    this.sellerComment,
    this.adminComment,
    this.ratings,
    this.date,
    this.user,
    this.product,
  });
double get ratingAsDouble {
    if (ratings == null || ratings!.isEmpty) {
      return 0.0; 
    }
    return double.tryParse(ratings!) ?? 0.0;
  }
  factory Feedback.fromJson(Map<String, dynamic>? json) => Feedback(
        id: json?["id"],
        productId: json?["product_id"],
        userId: json?["user_id"],
        comment: json?["comment"],
        sellerComment: json?["seller_comment"],
        adminComment: json?["admin_comment"],
        ratings: json?["ratings"],
        date: json?["date"],
        user: json?["user"] != null ? User.fromJson(json!["user"]) : null,
        product: json?["product"] != null ? Product.fromJson(json!["product"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "comment": comment,
        "seller_comment": sellerComment,
        "admin_comment": adminComment,
        "ratings": ratings,
        "date": date,
        "user": user?.toJson(),
        "product": product?.toJson(),
      };
}

class Product {
  int? id;
  String? name;

  Product({
    this.id,
    this.name,
  });

  factory Product.fromJson(Map<String, dynamic>? json) => Product(
        id: json?["id"],
        name: json?["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": name,
      };
}
class User {
  int? id;
  String? name;
  List<Media>? media;

  User({
    this.id,
    this.name,
    this.media,
  });

  factory User.fromJson(Map<String, dynamic>? json) => User(
        id: json?["id"],
        name: json?["name"],
        media: json?["media"] != null
            ? List<Media>.from(
                json!["media"].map((x) => Media.fromJson(x)))
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

  factory Media.fromJson(Map<String, dynamic>? json) => Media(
        id: json?["id"],
        originalUrl: json?["original_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "original_url": originalUrl,
      };
}

class SellerData {
  dynamic fivestar;
  dynamic fourstar;
  dynamic threestar;
  dynamic twostar;
  dynamic onestar;

  SellerData({
    this.fivestar,
    this.fourstar,
    this.threestar,
    this.twostar,
    this.onestar
  });

  factory SellerData.fromJson(Map<String, dynamic>? json) => SellerData(
        fivestar: json?["five_star"],
        fourstar: json?["four_star"],
       threestar: json?["three_star"],
       twostar: json?["two_star"],
       onestar: json?["one_star"],
      );

  Map<String, dynamic> toJson() => {
        "fivestar": fivestar,
        "fourstar": fourstar,
        "threestar": threestar,
        "twostar": twostar,
        "onestar": onestar,
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

  factory Pagination.fromJson(Map<String, dynamic>? json) => Pagination(
        total: json?["total"],
        page: json?["page"],
        pageSize: json?["page_size"],
        totalPages: json?["total_pages"],
        remaining: json?["remaining"],
        nextPage: json?["next_page"],
        prevPage: json?["prev_page"],
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
