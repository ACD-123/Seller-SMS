import 'dart:convert';

GetBrandsListModel getBrandsListModelFromJson(String str) =>
    GetBrandsListModel.fromJson(json.decode(str));

String getBrandsListModelToJson(GetBrandsListModel data) =>
    json.encode(data.toJson());

class GetBrandsListModel {
  bool? status;
  Data? data;
  String? message;

  GetBrandsListModel({
    this.status,
    this.data,
    this.message,
  });

  factory GetBrandsListModel.fromJson(Map<String, dynamic> json) =>
      GetBrandsListModel(
        status: json["status"] ,
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        message: json["message"] ,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  List<Brand>? brands;
  Pagination? pagination;

  Data({
    this.brands,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        brands: json["brands"] == null
            ? null
            : List<Brand>.from(json["brands"].map((x) => Brand.fromJson(x))),
        pagination: json["pagination"] == null
            ? null
            : Pagination.fromJson(json["pagination"]),
      );

  Map<String, dynamic> toJson() => {
        "brands": brands?.map((x) => x.toJson()).toList(),
        "pagination": pagination?.toJson(),
      };
}

class Brand {
  int? id;
  String? name;
  int? active;
  String? guid;
  DateTime? createdAt;
  DateTime? updatedAt;

  Brand({
    this.id,
    this.name,
    this.active,
    this.guid,
    this.createdAt,
    this.updatedAt,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"] ,
        name: json["name"] ,
        active: json["active"] ,
        guid: json["guid"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "active": active,
        "guid": guid,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
        page: json["page"] ,
        pageSize: json["page_size"],
        totalPages: json["total_pages"] ,
        remaining: json["remaining"],
        nextPage: json["next_page"],
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
