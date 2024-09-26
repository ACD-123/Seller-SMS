import 'dart:convert';

SellerProfileData sellerProfileDataFromJson(String str) =>
    SellerProfileData.fromJson(json.decode(str));

String sellerProfileDataToJson(SellerProfileData data) =>
    json.encode(data.toJson());

class SellerProfileData {
  bool? status;
  Data? data;
  String? message;

  SellerProfileData({
    this.status,
    this.data,
    this.message,
  });

  factory SellerProfileData.fromJson(Map<String, dynamic> json) =>
      SellerProfileData(
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
  int? id;
  String? name;
  String? email;
  DateTime? emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? phoneCode;
  String? phoneNumber;
  String? address;
  String? city;
  String? state;
  String? country;
  String? zipCode;
  String? phonecountrycode;
  String? provider;
  dynamic accessToken;
  String? orangepay;
  String? joined;
  int? isUser;
  bool? isTrustedSeller;
  Seller? seller;
  List<Media>? media;

  Data({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.phoneCode,
    this.phoneNumber,
    this.address,
    this.city,
    this.state,
    this.country,
    this.zipCode,
    this.provider,
    this.accessToken,
    this.joined,
    this.orangepay,
    this.isUser,
    this.isTrustedSeller,
    this.phonecountrycode,
    this.seller,
    this.media,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"] != null
            ? DateTime.parse(json["email_verified_at"])
            : null,
        createdAt: json["created_at"] != null
            ? DateTime.parse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.parse(json["updated_at"])
            : null,
        phoneCode: json["phone_code"],
        phoneNumber: json["phone_number"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        country: json["country"],
        zipCode: json["zip_code"],
        provider: json["provider"],
        accessToken: json["access_token"],
        phonecountrycode: json["phone_country_code"],
        joined: json["joined"],
        orangepay: json["orange_pay"],
        isUser: json["is_user"],
        isTrustedSeller: json["is_trusted_seller"],
        seller: json["seller"] == null ? null : Seller.fromJson(json["seller"]),
        media: json["media"] != null
            ? List<Media>.from(json["media"].map((x) => Media.fromJson(x)))
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "phone_code": phoneCode,
        "phone_number": phoneNumber,
        "address": address,
        "city": city,
        "state": state,
        "country": country,
        "zip_code": zipCode,
        "provider": provider,
        "access_token": accessToken,
        "joined": joined,
        "orangepay": orangepay,
        "is_user": isUser,
        "phonecountrycode": phonecountrycode,
        "seller": seller == null ? null : seller?.toJson(),
        "is_trusted_seller": isTrustedSeller,
        "media": media?.map((x) => x.toJson()).toList(),
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

  Seller({
    required this.id,
    required this.shopName,
  });

  factory Seller.fromJson(Map<String, dynamic> json) => Seller(
        id: json["id"],
        shopName: json["shop_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shop_name": shopName,
      };
}
