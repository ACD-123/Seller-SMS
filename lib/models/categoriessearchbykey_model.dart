// To parse this JSON data, do
//
//     final categoriesSearchByKeyModel = categoriesSearchByKeyModelFromJson(jsonString);

import 'dart:convert';

CategoriesSearchByKeyModel categoriesSearchByKeyModelFromJson(String str) =>
    CategoriesSearchByKeyModel.fromJson(json.decode(str));

String categoriesSearchByKeyModelToJson(CategoriesSearchByKeyModel data) =>
    json.encode(data.toJson());

class CategoriesSearchByKeyModel {
  bool? status;
  Data? data;
  String? message;

  CategoriesSearchByKeyModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory CategoriesSearchByKeyModel.fromJson(Map<String, dynamic> json) =>
      CategoriesSearchByKeyModel(
        status: json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? null : data!.toJson(),
        "message": message,
      };
}

class Data {
  List<Category>? categories;
  Pagination? pagination;

  Data({
    required this.categories,
    required this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        categories: json["categories"] == null
            ? null
            : List<Category>.from(
                json["categories"].map((x) => Category.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
        "pagination": pagination == null ? null : pagination!.toJson(),
      };
}

class Category {
  int? id;
  String? name;
  String? description;
  int? active;
  String? guid;
  dynamic parentId;

  List<Media>? media;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.active,
    required this.guid,
    required this.parentId,
    required this.media,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        active: json["active"],
        guid: json["guid"],
        parentId: json["parent_id"],
        media: json["media"] == null
            ? null
            : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "active": active,
        "guid": guid,
        "parent_id": parentId,
        "media": media == null
            ? null
            : List<dynamic>.from(media!.map((x) => x.toJson())),
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

class Pagination {
  int? total;
  int? page;
  String? pageSize;
  int? totalPages;
  int? remaining;
  int? nextPage;
  int? prevPage;

  Pagination({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.remaining,
    required this.nextPage,
    required this.prevPage,
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
