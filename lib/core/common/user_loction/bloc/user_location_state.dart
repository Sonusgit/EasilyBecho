import 'package:easilybecho/core/common/user_loction/model/user_location_model.dart';

abstract class UserLocationState {}

/// Initial — no location yet
class LocationInitial extends UserLocationState {}

/// Loading — fetching location
class LocationLoading extends UserLocationState {}

/// Success — location found
class LocationLoaded extends UserLocationState {
  final UserLocationModel location;
  LocationLoaded(this.location);
}