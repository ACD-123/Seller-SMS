import 'dart:convert';

SellerShopProfileData sellerShopProfileDataFromJson(String str) => SellerShopProfileData.fromJson(json.decode(str));

String sellerShopProfileDataToJson(SellerShopProfileData data) => json.encode(data.toJson());

class SellerShopProfileData {
  bool? status;
  Data? data;
  String? message;

  SellerShopProfileData({
    this.status,
    this.data,
    this.message,
  });

  factory SellerShopProfileData.fromJson(Map<String, dynamic> json) => SellerShopProfileData(
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
  User? user;
  SellerData? sellerData;

  Data({
    this.user,
    this.sellerData,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    sellerData: json["sellerData"] == null ? null : SellerData.fromJson(json["sellerData"]),
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
  dynamic sell;
  String? registrationNumber;
  dynamic phoneCountryCode;
  String? coverImage;
  String? mainImage;
  List<dynamic>? banners;
  List<dynamic>? category;
  String? joined;
  bool? isFavourite;
  int? favouriteCount;
  String? rating;
  int? ratingCount;
  int? productCount;
  List<Media>? media;

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
    this.phoneCountryCode,
    this.coverImage,
    this.mainImage,
    this.banners,
    this.category,
    this.joined,
    this.isFavourite,
    this.favouriteCount,
    this.rating,
    this.ratingCount,
    this.productCount,
    this.media,
    
  });
double get ratingAsDouble {
    if (rating == null || rating!.isEmpty) {
      return 0.0; 
    }
    return double.tryParse(rating!) ?? 0.0;
  }
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    shopDescription: json["shop_description"],
    sell: json["sell"],
    registrationNumber: json["registration_number"],
    phoneCountryCode: json["phone_country_code"],
    coverImage: json["cover_image"],
    mainImage: json["main_image"],
    banners: json["banners"] == null ? null : List<dynamic>.from(json["banners"].map((x) => x)),
    category: json["category"] == null ? null : List<dynamic>.from(json["category"].map((x) => x)),
    joined: json["joined"],
    isFavourite: json["is_favourite"],
    favouriteCount: json["favourite_count"],
    rating: json["rating"],
    ratingCount: json["rating_count"],
    productCount: json["product_count"],
    media: json["media"] == null ? null : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
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
    "phone_country_code": phoneCountryCode,
    "cover_image": coverImage,
    "main_image": mainImage,
    "banners": banners == null ? [] : List<dynamic>.from(banners!.map((x) => x)),
    "category": category == null ? [] : List<dynamic>.from(category!.map((x) => x)),
    "joined": joined,
    "is_favourite": isFavourite,
    "favourite_count": favouriteCount,
    "rating": rating,
    "rating_count": ratingCount,
    "product_count": productCount,
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
    id: json["id"],
    originalUrl: json["original_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "original_url": originalUrl,
  };
}

class User {
  int? id;
  String? name;
  String? email;
  String? phoneCode;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? provider;
  dynamic accessToken;
  int? isUser;
  String? phoneCountryCode;
  bool? isTrustedSeller;
  List<Media>? media;

  User({
    this.id,
    this.name,
    this.email,
    this.phoneCode,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.provider,
    this.accessToken,
    this.isUser,
    this.phoneCountryCode,
    this.isTrustedSeller,
    this.media,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phoneCode: json["phone_code"],
    phoneNumber: json["phone_number"],
    address: json["address"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    zipCode: json["zip_code"],
    provider: json["provider"],
    accessToken: json["access_token"],
    isUser: json["is_user"],
    phoneCountryCode: json["phone_country_code"],
    isTrustedSeller: json["is_trusted_seller"],
    media: json["media"] == null ? null : List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone_code": phoneCode,
    "phone_number": phoneNumber,
    "address": address,
    "city": city,
    "state": state,
    "country": country,
    "zip_code": zipCode,
    "provider": provider,
    "access_token": accessToken,
    "is_user": isUser,
    "phone_country_code": phoneCountryCode,
    "is_trusted_seller": isTrustedSeller,
    "media": media == null ? [] : List<dynamic>.from(media!.map((x) => x.toJson())),
  };
}
