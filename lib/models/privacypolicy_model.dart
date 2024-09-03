import 'dart:convert';

PrivayPolicyModel? privayPolicyModelFromJson(String str) => 
    str.isNotEmpty ? PrivayPolicyModel.fromJson(json.decode(str)) : null;

String? privayPolicyModelToJson(PrivayPolicyModel? data) => 
    data != null ? json.encode(data.toJson()) : null;

class PrivayPolicyModel {
    bool? status;
    List<Datum>? data;
    String? message;

    PrivayPolicyModel({
        this.status,
        this.data,
        this.message,
    });

    factory PrivayPolicyModel.fromJson(Map<String, dynamic> json) => PrivayPolicyModel(
        status: json["status"],
        data: json["data"] != null ? List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))) : null,
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data != null ? List<dynamic>.from(data!.map((x) => x.toJson())) : null,
        "message": message,
    };
}

class Datum {
    int? id;
    String? title;
    String? description;
    String? createdat;

    Datum({
        this.id,
        this.title,
        this.description,
        this.createdat,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdat: json["createDate"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "createdat": createdat,
    };
}
