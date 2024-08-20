import 'dart:convert';

// To parse this JSON data, do
//
//     final getCategoriesListModel = getCategoriesListModelFromJson(jsonString);

GetSellerCategoriesListModel? getCategoriesListModelFromJson(String str) =>
    GetSellerCategoriesListModel.fromJson(json.decode(str));

String getCategoriesListModelToJson(GetSellerCategoriesListModel? data) =>
    json.encode(data?.toJson());

class GetSellerCategoriesListModel {
  bool? status;
  List<Datum>? data;
  String? message;

  GetSellerCategoriesListModel({
    this.status,
    this.data,
    this.message,
  });

  factory GetSellerCategoriesListModel.fromJson(Map<String, dynamic> json) =>
      GetSellerCategoriesListModel(
        status: json["status"] as bool?,
        data: json["data"] == null
            ? null
            : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  int? id;
  String? name;
  String? description;
  int? active;
  String? guid;
  dynamic parentId;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Media>? media;

  Datum({
    this.id,
    this.name,
    this.description,
    this.active,
    this.guid,
    this.parentId,
    this.createdAt,
    this.updatedAt,
    this.media,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"] ,
        name: json["name"],
        description: json["description"],
        active: json["active"] ,
        guid: json["guid"] ,
        parentId: json["parent_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"] ),
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
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
        id: json["id"] as int?,
      
        originalUrl: json["original_url"] ,
       
      );

  Map<String, dynamic> toJson() => {
        "id": id,
       
        "original_url": originalUrl,
      };
}
