// ─────────────────────────────────────────────────────────────────────────────
// User Location Model
// ─────────────────────────────────────────────────────────────────────────────

class UserLocationModel {
  final double? latitude;
  final double? longitude;
  final String? city;
  final String? state;
  final String? country;
  final String? postalCode;
  final String? fullAddress;

  const UserLocationModel({
    this.latitude,
    this.longitude,
    this.city,
    this.state,
    this.country,
    this.postalCode,
    this.fullAddress,
  });

  /// Empty / default state
  const UserLocationModel.empty()
      : latitude = null,
        longitude = null,
        city = null,
        state = null,
        country = null,
        postalCode = null,
        fullAddress = null;

  bool get isEmpty => city == null && latitude == null;
  bool get isNotEmpty => !isEmpty;

  UserLocationModel copyWith({
    double? latitude,
    double? longitude,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? fullAddress,
  }) {
    return UserLocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      fullAddress: fullAddress ?? this.fullAddress,
    );
  }

  @override
  String toString() =>
      'UserLocationModel(city: $city, state: $state, country: $country)';
}