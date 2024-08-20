import 'dart:convert';

// To parse this JSON data, do
//
//     final categoryWiseAttributesModel = categoryWiseAttributesModelFromJson(jsonString);

CategoryWiseAttributesModel? categoryWiseAttributesModelFromJson(String str) =>
    CategoryWiseAttributesModel.fromJson(json.decode(str));

String categoryWiseAttributesModelToJson(CategoryWiseAttributesModel? data) =>
    json.encode(data?.toJson());

class CategoryWiseAttributesModel {
  bool? status;
  Data? data;
  String? message;

  CategoryWiseAttributesModel({
    this.status,
    this.data,
    this.message,
  });

  factory CategoryWiseAttributesModel.fromJson(Map<String, dynamic> json) =>
      CategoryWiseAttributesModel(
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
  List<Attribute>? attributes;

  Data({
    this.attributes,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        attributes: json["attributes"] == null
            ? null
            : List<Attribute>.from(
                json["attributes"].map((x) => Attribute.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "attributes": attributes == null
            ? []
            : List<dynamic>.from(attributes!.map((x) => x.toJson())),
      };
}

class Attribute {
  String? name;
  List<String>? options;
  int? id;

  Attribute({
    this.name,
    this.options,
    this.id,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) => Attribute(
        name: json["name"],
        options: json["options"] == null
            ? null
            : List<String>.from(json["options"].map((x) => x)),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "options":
            options == null ? [] : List<dynamic>.from(options!.map((x) => x)),
        "id": id,
      };
}
