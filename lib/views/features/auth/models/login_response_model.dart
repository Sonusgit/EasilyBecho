class LoginResponse {
  final String accessToken;
  final String userId;
  final String? name;
  final String? email;
  final String? phone;

  const LoginResponse({
    required this.accessToken,
    required this.userId,
    this.name,
    this.email,
    this.phone,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        accessToken: json['access_token'] ?? json['token'] ?? '',
        userId: json['user']?['id']?.toString() ?? json['id']?.toString() ?? '',
        name: json['user']?['name'] ?? json['name'],
        email: json['user']?['email'] ?? json['email'],
        phone: json['user']?['phone'] ?? json['phone'],
      );
}