import 'dart:convert';

FaqModel? faqModelFromJson(String str) => 
    str.isNotEmpty ? FaqModel.fromJson(json.decode(str)) : null;

String? faqModelToJson(FaqModel? data) => 
    data != null ? json.encode(data.toJson()) : null;

class FaqModel {
    bool? status;
    List<Datum>? data;
    String? message;

    FaqModel({
        this.status,
        this.data,
        this.message,
    });

    factory FaqModel.fromJson(Map<String, dynamic> json) => FaqModel(
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
    String? question;
    String? answer;

    Datum({
        this.id,
        this.question,
        this.answer,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        question: json["question"],
        answer: json["answer"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "question": question,
        "answer": answer,
    };
}
