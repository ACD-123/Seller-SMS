import 'dart:convert';

SellerChatRoomDetailsModel? sellerChatRoomDetailsModelFromJson(String str) => 
    SellerChatRoomDetailsModel.fromJson(json.decode(str));

String sellerChatRoomDetailsModelToJson(SellerChatRoomDetailsModel? data) => 
    json.encode(data?.toJson());

class SellerChatRoomDetailsModel {
    List<Datum?>? data;
    bool? status;
    String? message;
    Pagination? pagination;

    SellerChatRoomDetailsModel({
        this.data,
        this.status,
        this.message,
        this.pagination
    });

    factory SellerChatRoomDetailsModel.fromJson(Map<String, dynamic> json) => 
        SellerChatRoomDetailsModel(
            data: json["data"] == null 
                ? null 
                : List<Datum?>.from(json["data"].map((x) => Datum.fromJson(x))),
            status: json["status"],
            message: json["message"],
            pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        );

    Map<String, dynamic> toJson() => {
        "data": data == null 
            ? null 
            : List<dynamic>.from(data!.map((x) => x?.toJson())),
        "status": status,
        "message": message,
        "pagination": pagination?.toJson(),
    };
}

class Datum {
    int? id;
    int? roomId;
    String? uid;
    String? fromId;
    String? message;
    String? messageType;
    int? isRead;
    int? isSeen;
    String? time;
    Participants? user;
    Participants? participants;
    Seller? seller;
    Participants? testuser;

    Datum({
        this.id,
        this.roomId,
        this.uid,
        this.fromId,
        this.message,
        this.messageType,
        this.isRead,
        this.isSeen,
        this.time,
        this.user,
        this.participants,
        this.seller,
        this.testuser,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        roomId: json["room_id"],
        uid: json["uid"],
        fromId: json["from_id"],
        message: json["message"],
        messageType: json["message_type"],
        isRead: json["is_read"],
        isSeen: json["is_seen"],
        time: json["time"],
        user: json["user"] == null ? null : Participants.fromJson(json["user"]),
        participants: json["participants"] == null ? null : Participants.fromJson(json["participants"]),
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
        testuser: json["testuser"] == null ? null : Participants.fromJson(json["testuser"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "room_id": roomId,
        "uid": uid,
        "from_id": fromId,
        "message": message,
        "message_type": messageType,
        "is_read": isRead,
        "is_seen": isSeen,
        "time": time,
        "user": user?.toJson(),
        "participants": participants?.toJson(),
        "seller": seller?.toJson(),
        "testuser": testuser?.toJson(),
    };
}

class Participants {
    int? id;
    String? name;
    List<Media?>? media;

    Participants({
        this.id,
        this.name,
        this.media,
    });

    factory Participants.fromJson(Map<String, dynamic> json) => Participants(
        id: json["id"],
        name: json["name"],
        media: json["media"] == null 
            ? null 
            : List<Media?>.from(json["media"].map((x) => Media.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "media": media == null 
            ? null 
            : List<dynamic>.from(media!.map((x) => x?.toJson())),
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
        id: json["id"],
        originalUrl: json["original_url"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "original_url": originalUrl,
    };
}

class Seller {
    int? id;
    String? shopName;
    String? mainImage;

    Seller({
        this.id,
        this.shopName,
        this.mainImage,
    });

    factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        shopName: json["shop_name"],
        mainImage: json["main_image"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "shop_name": shopName,
        "main_image": mainImage,
    };
}
class Pagination {
    dynamic total;
    dynamic page;
    dynamic totalPages;

    Pagination({
        required this.total,
        required this.page,
        required this.totalPages,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        total: json["total"],
        page: json["page"],
        totalPages: json["total_pages"],
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "page": page,
        "total_pages": totalPages,
    };
}