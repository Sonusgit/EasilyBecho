class SignupRequest {
  final String name;
  final String email;
  final String password;
  final String? phone;
  final String? referralCode;

  const SignupRequest({
    required this.name,
    required this.email,
    required this.password,
    this.phone,
    this.referralCode,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        if (phone != null) 'phone': phone,
        if (referralCode != null) 'referral_code': referralCode,
      };
}