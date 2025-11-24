// To parse this JSON data, do:
// final loginModel = loginModelFromJson(jsonString);

class LoginModel {
  String status;
  String message;
  Payload payload;
  int statusCode;

  LoginModel({
    required this.status,
    required this.message,
    required this.payload,
    required this.statusCode,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    payload: Payload.fromJson(json["payload"]),
    statusCode: json["statusCode"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "payload": payload.toJson(),
    "statusCode": statusCode,
  };
}

class Payload {
  String userToken;
  String loginDate;
  String refreshToken;

  Payload({
    required this.userToken,
    required this.loginDate,
    required this.refreshToken,
  });

  factory Payload.fromJson(Map<String, dynamic> json) => Payload(
    userToken: json["userToken"],
    loginDate: json["loginDate"],
    refreshToken: json["refreshToken"],
  );

  Map<String, dynamic> toJson() => {
    "userToken": userToken,
    "loginDate": loginDate,
    "refreshToken": refreshToken,
  };
}
