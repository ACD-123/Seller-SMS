// To parse this JSON data, do
//
//     final transectionModel = transectionModelFromJson(jsonString);

import 'dart:convert';

TransectionModel? transectionModelFromJson(String str) =>
    TransectionModel.fromJson(json.decode(str));

String transectionModelToJson(TransectionModel? data) =>
    json.encode(data?.toJson());

class TransectionModel {
  bool? status;
  Data? data;
  String? message;

  TransectionModel({
    this.status,
    this.data,
    this.message,
  });

  factory TransectionModel.fromJson(Map<String, dynamic> json) =>
      TransectionModel(
        status: json["status"],
        data: json["data"] != null ? Data.fromJson(json["data"]) : null,
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data?.toJson(),
        "message": message,
      };
}

class Data {
  List<Transaction>? transactions;
  dynamic availableBalance;
  dynamic earned;
  dynamic earnedGrowth;
  dynamic finalGrowth;
  Pagination? pagination;

  Data({
    this.transactions,
    this.availableBalance,
    this.earned,
    this.earnedGrowth,
    this.finalGrowth,
    this.pagination,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        transactions: json["transactions"] != null
            ? List<Transaction>.from(
                json["transactions"].map((x) => Transaction.fromJson(x)))
            : null,
        availableBalance: json["availableBalance"],
        earned: json["earned"],
        earnedGrowth: json["earnedGrowth"]?.toDouble(),
        finalGrowth: json["finalGrowth"]?.toDouble(),
        pagination: json["pagination"] != null
            ? Pagination.fromJson(json["pagination"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "transactions": transactions != null
            ? List<dynamic>.from(transactions!.map((x) => x.toJson()))
            : null,
        "availableBalance": availableBalance,
        "earned": earned,
        "earnedGrowth": earnedGrowth,
        "finalGrowth": finalGrowth,
        "pagination": pagination?.toJson(),
      };
}

class Pagination {
  dynamic totalPages;

  Pagination({
    this.totalPages,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        totalPages: json["total_pages"],
      );

  Map<String, dynamic> toJson() => {
        "total_pages": totalPages,
      };
}

class Transaction {
  int? id;
  dynamic amount;
  String? type;
  String? date;

  Transaction({
    this.id,
    this.amount,
    this.type,
    this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
        id: json["id"],
        amount: json["amount"],
        type: json["type"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "type": type,
        "date": date,
      };
}
