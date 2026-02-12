class LoginResponseModel {
  final String status;
  final String message;
  final UserData? payload;
  final int statusCode;

  LoginResponseModel({
    required this.status,
    required this.message,
    this.payload,
    required this.statusCode,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      status: json['status'] ?? '',
      message: json['message'] ?? '',
      payload: json['payload'] != null 
          ? UserData.fromJson(json['payload']) 
          : null,
      statusCode: json['statusCode'] ?? 0,
    );
  }
}

class UserData {
  final String userId;
  final String email;
  final String? name;
  final String? phone;
  final String accessToken;
  final String? refreshToken;

  UserData({
    required this.userId,
    required this.email,
    this.name,
    this.phone,
    required this.accessToken,
    this.refreshToken,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json['userId'] ?? json['id'] ?? '',
      email: json['email'] ?? '',
      name: json['name'],
      phone: json['phone'],
      accessToken: json['accessToken'] ?? json['token'] ?? '',
      refreshToken: json['refreshToken'],
    );
  }
}