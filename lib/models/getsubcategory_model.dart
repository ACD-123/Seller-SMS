// To parse this JSON data, do
//
//     final getSubCategoryModel = getSubCategoryModelFromJson(jsonString);

import 'dart:convert';

GetSubCategoryModel? getSubCategoryModelFromJson(String str) =>
    GetSubCategoryModel.fromJson(json.decode(str));

String getSubCategoryModelToJson(GetSubCategoryModel? data) =>
    json.encode(data?.toJson());

class GetSubCategoryModel {
  bool? status;
  Data? data;
  String? message;

  GetSubCategoryModel({
    this.status,
    this.data,
    this.message,
  });

  factory GetSubCategoryModel.fromJson(Map<String, dynamic> json) =>
      GetSubCategoryModel(
        status: json["status"] == null ? null : json["status"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] == null ? null : json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  List<Category>? subCategories;
  String? parentName;

  Data({
    this.subCategories,
    this.parentName,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        subCategories: json["sub_categories"] == null
            ? null
            : List<Category>.from(
                json["sub_categories"].map((x) => Category.fromJson(x))),
        parentName: json["parent_name"] == null ? null : json["parent_name"],
      );

  Map<String, dynamic> toJson() => {
        "sub_categories": subCategories == null
            ? null
            : List<dynamic>.from(subCategories!.map((x) => x.toJson())),
        "parent_name": parentName,
      };
}

class Category {
  int? id;
  String? name;
  String? guid;

  Category({
    this.id,
    this.name,
    this.guid,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        guid: json["guid"] == null ? null : json["guid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guid": guid,
      };
}
