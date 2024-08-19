import 'dart:convert';

SellerShopProfileData sellerShopProfileDataFromJson(String str) =>
    SellerShopProfileData.fromJson(json.decode(str));

String sellerShopProfileDataToJson(SellerShopProfileData data) =>
    json.encode(data.toJson());

class SellerShopProfileData {
  bool? status;
  Data? data;
  String? message;

  SellerShopProfileData({
    this.status,
    this.data,
    this.message,
  });

  factory SellerShopProfileData.fromJson(Map<String, dynamic> json) =>
      SellerShopProfileData(
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
  User? user;
  SellerData? sellerData;

  Data({
    this.user,
    this.sellerData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
        sellerData: json["sellerData"] != null
            ? SellerData.fromJson(json["sellerData"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "user": user?.toJson(),
        "sellerData": sellerData?.toJson(),
      };
}

class SellerData {
  int? id;
  int? userId;
  String? shopName;
  String? phoneCode;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? guid;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? shopDescription;
  String? sell;
  String? registrationNumber;
  String? coverImage;
  String? mainImage;String? joined;
  List<String>? banners;
  List<Category>? category;
  bool? isFavourite;
  int? favouriteCount;
  String? rating;

  SellerData({
    this.id,
    this.userId,
    this.shopName,
    this.phoneCode,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.guid,
    this.createdAt,
    this.updatedAt,
    this.shopDescription,
    this.sell,
    this.registrationNumber,
    this.coverImage,
    this.mainImage,
    this.banners,
    this.category,
    this.joined,
    this.isFavourite,
    this.favouriteCount,
    this.rating,
  });

  factory SellerData.fromJson(Map<String, dynamic> json) => SellerData(
        id: json["id"],
        userId: json["user_id"],
        shopName: json["shop_name"],
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zip_code"],
        guid: json["guid"],
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        shopDescription: json["shop_description"],
        sell: json["sell"],
        registrationNumber: json["registration_number"],
        coverImage: json["cover_image"],
        mainImage: json["main_image"],
        banners: json["banners"] != null
            ? List<String>.from(json["banners"].map((x) => x))
            : null,
        category: json["category"] != null
            ? List<Category>.from(
                json["category"].map((x) => Category.fromJson(x)))
            : null,
        isFavourite: json["is_favourite"],
        joined: json["joined"],
        favouriteCount: json["favourite_count"],
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "shop_name": shopName,
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "zip_code": zipCode,
        "guid": guid,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "shop_description": shopDescription,
        "sell": sell,
        "registration_number": registrationNumber,
        "cover_image": coverImage,
        "main_image": mainImage,
        "banners": banners != null ? List<dynamic>.from(banners!) : null,
        "category": category != null
            ? List<dynamic>.from(category!.map((x) => x.toJson()))
            : null,
        "is_favourite": isFavourite,
         "joined": joined,
        "favourite_count": favouriteCount,
        "rating": rating,
      };
}

class Category {
  int? id;
  String? name;
  String? description;
  int? active;
  String? guid;
  dynamic parentId;
  DateTime createdAt;
  DateTime updatedAt;

  Category({
    required this.id,
    required this.name,
    required this.description,
    required this.active,
    required this.guid,
    this.parentId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        active: json["active"],
        guid: json["guid"],
        parentId: json["parent_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "active": active,
        "guid": guid,
        "parent_id": parentId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  DateTime emailVerifiedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String? phoneCode;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? provider;
  dynamic accessToken;
  int importantNotification;
  int chatsNotification;
  int buyingNotification;
  int sellingNotification;
  int isUser;
  bool isTrustedSeller;
  List<dynamic>? media;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneCode,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
    required this.zipCode,
    required this.provider,
    this.accessToken,
    required this.importantNotification,
    required this.chatsNotification,
    required this.buyingNotification,
    required this.sellingNotification,
    required this.isUser,
    required this.isTrustedSeller,
    this.media,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zip_code"],
        provider: json["provider"],
        accessToken: json["access_token"],
        importantNotification: json["important_notification"],
        chatsNotification: json["chats_notification"],
        buyingNotification: json["buying_notification"],
        sellingNotification: json["selling_notification"],
        isUser: json["is_user"],
        isTrustedSeller: json["is_trusted_seller"],
        media: json["media"] != null
            ? List<dynamic>.from(json["media"].map((x) => x))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "zip_code": zipCode,
        "provider": provider,
        "access_token": accessToken,
        "important_notification": importantNotification,
        "chats_notification": chatsNotification,
        "buying_notification": buyingNotification,
        "selling_notification": sellingNotification,
        "is_user": isUser,
        "is_trusted_seller": isTrustedSeller,
        "media": media != null ? List<dynamic>.from(media!) : null,
      };
}
