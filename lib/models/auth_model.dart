class AuthModel {
  final String? status;
  final String? message;
  final Payload? payload;
  final int? statusCode;

  AuthModel({
    this.status,
    this.message,
    this.payload,
    this.statusCode,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      status: json['status'],
      message: json['message'],
      payload: json['payload'] != null ? Payload.fromJson(json['payload']) : null,
      statusCode: json['statusCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'payload': payload?.toJson(),
      'statusCode': statusCode,
    };
  }
}

class Payload {
  final String? userToken;
  final List<int>? loginDate;
  final String? refreshToken;

  Payload({
    this.userToken,
    this.loginDate,
    this.refreshToken,
  });

  factory Payload.fromJson(Map<String, dynamic> json) {
    return Payload(
      userToken: json['userToken'],
      loginDate: List<int>.from(json['loginDate']),
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userToken': userToken,
      'loginDate': loginDate,
      'refreshToken': refreshToken,
    };
  }
}
