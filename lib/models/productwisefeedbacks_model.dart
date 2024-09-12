import 'dart:convert';

ProductWiseFeedbackModel? productWiseFeedbackModelFromJson(String str) => ProductWiseFeedbackModel.fromJson(json.decode(str));

String productWiseFeedbackModelToJson(ProductWiseFeedbackModel? data) => json.encode(data?.toJson());

class ProductWiseFeedbackModel {
  bool? status;
  Data? data;
  String? message;

  ProductWiseFeedbackModel({
    this.status,
    this.data,
    this.message,
  });

  factory ProductWiseFeedbackModel.fromJson(Map<String, dynamic>? json) => ProductWiseFeedbackModel(
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

  Data({
    this.feedback,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic>? json) => Data(
        feedback: json?["feedback"] != null
            ? List<Feedback>.from(json!["feedback"].map((x) => Feedback.fromJson(x)))
            : null,
        pagination: json?["pagination"] != null ? Pagination.fromJson(json!["pagination"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "feedback": feedback != null ? List<dynamic>.from(feedback!.map((x) => x.toJson())) : null,
        "pagination": pagination?.toJson(),
      };
}

class Feedback {
  int? id;
  int? productId;
  int? userId;
  String? comment;
  String? sellerComment;
  String? ratings;
  String? date;
  User? user;

  Feedback({
    this.id,
    this.productId,
    this.userId,
    this.comment,
    this.sellerComment,
    this.ratings,
    this.date,
    this.user,
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
        ratings: json?["ratings"],
        date: json?["date"],
        user: json?["user"] != null ? User.fromJson(json!["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "user_id": userId,
        "comment": comment,
        "seller_comment": sellerComment,
        "ratings": ratings,
        "date": date,
        "user": user?.toJson(),
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
        media: json?["media"] != null ? List<Media>.from(json!["media"].map((x) => Media.fromJson(x))) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "media": media != null ? List<dynamic>.from(media!.map((x) => x.toJson())) : null,
      };
}

class Pagination {
  dynamic page;
  dynamic totalPages;

  Pagination({
    this.page,
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic>? json) => Pagination(
        page: json?["page"],
        totalPages: json?["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "total_pages": totalPages,
      };
}
