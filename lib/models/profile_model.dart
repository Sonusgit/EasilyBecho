class ProfileModel {
  final String status;
  final String message;
  final Payload payload;
  final int statusCode;

  ProfileModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.statusCode,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'],
      message: json['message'],
      payload: Payload.fromJson(json['payload']),
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'payload': payload.toJson(),
      'statusCode': statusCode,
    };
  }
}

class Payload {
  final int id;
  final String shopId;
  final String shopStoreName;
  final String email;
  final String? password;
  final DateTime? passwordUpdatedAt;
  final String? shopAddress;
  final List<SocialMediaLink> socialMediaLinks;
  final List<ImageModel> images;
  final String? profilePhotoUrl;
  final int status;
  final bool notifyByEmail;
  final bool notifyBySMS;
  final bool notifyByWhatsApp;
  final String? gstnumber;
  final String adhaarNumber;
  final DateTime? creationDate;

  Payload({
    required this.id,
    required this.shopId,
    required this.shopStoreName,
    required this.email,
    this.password,
    this.passwordUpdatedAt,
    this.shopAddress,
    required this.socialMediaLinks,
    required this.images,
    this.profilePhotoUrl,
    required this.status,
    required this.notifyByEmail,
    required this.notifyBySMS,
    required this.notifyByWhatsApp,
    this.gstnumber,
    required this.adhaarNumber,
    this.creationDate,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      id: json['id'],
      shopId: json['shopId'],
      shopStoreName: json['shopStoreName'],
      email: json['email'],
      password: json['password'],
      passwordUpdatedAt: _parseDateTime(json['passwordUpdatedAt']),
      shopAddress: json['shopAddress'],
      socialMediaLinks: (json['socialMediaLinks'] as List)
          .map((e) => SocialMediaLink.fromJson(e))
          .toList(),
      images:
          (json['images'] as List).map((e) => ImageModel.fromJson(e)).toList(),
      profilePhotoUrl: json['profilePhotoUrl'],
      status: json['status'],
      notifyByEmail: json['notifyByEmail'],
      notifyBySMS: json['notifyBySMS'],
      notifyByWhatsApp: json['notifyByWhatsApp'],
      gstnumber: json['gstnumber'],
      adhaarNumber: json['adhaarNumber'] ?? '',
      creationDate: _parseDateTime(json['creationDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'shopId': shopId,
      'shopStoreName': shopStoreName,
      'email': email,
      'password': password,
      'passwordUpdatedAt': passwordUpdatedAt?.toIso8601String(),
      'shopAddress': shopAddress,
      'socialMediaLinks':
          socialMediaLinks.map((link) => link.toJson()).toList(),
      'images': images.map((image) => image.toJson()).toList(),
      'profilePhotoUrl': profilePhotoUrl,
      'status': status,
      'notifyByEmail': notifyByEmail,
      'notifyBySMS': notifyBySMS,
      'notifyByWhatsApp': notifyByWhatsApp,
      'gstnumber': gstnumber,
      'adhaarNumber': adhaarNumber,
      'creationDate': creationDate?.toIso8601String(),
    };
  }

  static DateTime? _parseDateTime(List<dynamic>? list) {
    if (list == null || list.isEmpty) return null;
    if (list.length >= 3) {
      return DateTime(
        list[0],
        list[1],
        list[2],
        list.length > 3 ? list[3] : 0,
        list.length > 4 ? list[4] : 0,
      );
    }
    return null;
  }
}

class SocialMediaLink {
  final int id;
  final String platform;
  final String url;

  SocialMediaLink({
    required this.id,
    required this.platform,
    required this.url,
  });

  factory SocialMediaLink.fromJson(Map<String, dynamic> json) {
    return SocialMediaLink(
      id: json['id'],
      platform: json['platform'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'platform': platform,
      'url': url,
    };
  }
}

class ImageModel {
  final int id;
  final String imageUrl;

  ImageModel({
    required this.id,
    required this.imageUrl,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
    };
  }
}
