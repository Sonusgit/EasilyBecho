class SignupResponse {
  final String userId;
  final String email;
  final String? name;
  final String? phone;
  final String? accessToken; 

  const SignupResponse({
    required this.userId,
    required this.email,
    this.name,
    this.phone,
    this.accessToken,
  });

  factory SignupResponse.fromJson(Map<String, dynamic> json) => SignupResponse(
        userId: json['user']?['id']?.toString() ?? json['id']?.toString() ?? '',
        email: json['user']?['email'] ?? json['email'] ?? '',
        name: json['user']?['name'] ?? json['name'],
        phone: json['user']?['phone'] ?? json['phone'],
        accessToken: json['access_token'] ?? json['token'],
      );
}