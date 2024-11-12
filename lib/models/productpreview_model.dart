// To parse this JSON data, do
//
//     final productPreviewModel = productPreviewModelFromJson(jsonString);

import 'dart:convert';

ProductPreviewModel productPreviewModelFromJson(String str) =>
    ProductPreviewModel.fromJson(json.decode(str));

String productPreviewModelToJson(ProductPreviewModel data) =>
    json.encode(data.toJson());

class ProductPreviewModel {
  bool? status;
  Data? data;
  String? message;

  ProductPreviewModel({
    required this.status,
    required this.data,
    required this.message,
  });

  factory ProductPreviewModel.fromJson(Map<String, dynamic> json) =>
      ProductPreviewModel(
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
  int? id;
  String? title;
  int? stock;
  int? categoryId;
  int? brandId;
  String? description;
  String? price;
  String? discountPrice;
  String? guid;
  String? rating;
  int? ratingCount;
  Brand? brand;
  Category? category;
List<NewAttribute>? newattributes;
  List<Attribute>? attributes;
  List<Media>? media;

  Data({
    required this.id,
    required this.title,
    required this.stock,
    required this.categoryId,
    required this.brandId,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.guid,
    required this.rating,
    required this.ratingCount,
    required this.brand,
    required this.category,
    required this.attributes,
    required this.newattributes,
    required this.media,
  });
double ratingasdouble(){
  if (rating == null || rating!.isEmpty){
    return 0.0;
  }
  return double.tryParse(rating ?? "") ?? 0.0;
}
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        title: json["title"],
        stock: json["stock"],
        categoryId: json["category_id"],
        brandId: json["brand_id"],
        description: json["description"],
        price: json["price"],
        discountPrice: json["discount_price"],
        guid: json["guid"],
        rating: json["rating"],
        ratingCount: json["rating_count"],
        brand: json["brand"] == null ? null : Brand.fromJson(json["brand"]),
        category:
            json["category"] == null ? null : Category.fromJson(json["category"]),
        attributes: json["attributes"] == null
            ? null
            : List<Attribute>.from(
                json["attributes"].map((x) => Attribute.fromJson(x))),
                 newattributes: json["new_attributes"] == null
            ? null
            : List<NewAttribute>.from(
                json["new_attributes"].map((x) => NewAttribute.fromJson(x))),
        media: json["media"] == null
            ? null
            : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "stock": stock,
        "category_id": categoryId,
        "brand_id": brandId,
        "description": description,
        "price": price,
        "discount_price": discountPrice,
        "guid": guid,
        "rating": rating,
        "rating_count": ratingCount,
        "brand": brand == null ? null : brand!.toJson(),
        "category": category == null ? null : category!.toJson(),
        "attributes": attributes == null
            ? null
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
         "new_attributes": newattributes == null
            ? null
            : List<dynamic>.from(newattributes!.map((x) => x.toJson())),
        "media": media == null
            ? null
            : List<dynamic>.from(media!.map((x) => x.toJson())),
      };
}

class Category {
    int? id;
    String? guid;
     String? name;
    String? parentId;

    Category({
        required this.id,
        required this.guid,
         required this.name,
        required this.parentId,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        guid: json["guid"],
           name: json["name"],
        parentId: json["parent_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "name": name,
        "parent_id": parentId,
    };
}
class Attribute {
  int? id;
  String? name;
  int? attributeid;
  String? colorimageurl;
  String? colorcode;
  Attribute({
    required this.id,
    required this.name,
    required this.attributeid,
     required this.colorcode,
    required this.colorimageurl,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        id: json["id"],
        name: json["name"],
        attributeid: json["attribute_id"],
        colorcode: json["code"],
        colorimageurl: json["image_url"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "attributeid": attributeid,
        "colorcode": colorcode,
        "colorimageurl": colorimageurl,
      };
}

class Brand {
  int? id;
  String? name;
  String? guid;
  Brand({
    required this.id,
    required this.name,
     required this.guid,
  });

  factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
         guid: json["guid"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "guid": guid,
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

class NewAttribute {
  String? key;
  List<Attribute>? value;
  NewAttribute({
    required this.key,
    required this.value,
  });

  factory NewAttribute.fromJson(Map<String, dynamic> json) => NewAttribute(
        key: json["key"],
        value: json["value"] == null
            ? null
            : List<Attribute>.from(
                json["value"].map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value == null
            ? null
            : List<dynamic>.from(value!.map((x) => x.toJson())),
      };
}
