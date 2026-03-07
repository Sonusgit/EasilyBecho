import 'package:easilybecho/core/common/user_loction/bloc/user_location_event.dart';
import 'package:easilybecho/core/common/user_loction/model/user_location_model.dart';
import 'package:easilybecho/core/data/services/api_response.dart';
import 'package:easilybecho/core/utility/const/app_const.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationBloc
    extends Bloc<UserLocationEvent, ApiResponse<UserLocationModel>> {
  LocationBloc() : super(ApiResponse()) {
    on<FetchLocationEvent>(_onFetchLocation);
    on<ClearLocationEvent>(_onClearLocation);
  }

  // ── Fetch Location ──────────────────────────────────────────────────────

  Future<void> _onFetchLocation(
    FetchLocationEvent event,
    Emitter<ApiResponse<UserLocationModel>> emit,
  ) async {
    emit(ApiResponse.loading());

    try {
      // Step 1 — GPS service check
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(
          ApiResponse.error(
            message: 'Location services are disabled. Please enable GPS.',
          ),
        );
        return;
      }

      // Step 2 — Permission check
      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(ApiResponse.error(message: 'Location permission denied.'));
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        emit(
          ApiResponse.error(
            message:
                'Location permission permanently denied. Enable from Settings.',
          ),
        );
        return;
      }

      // Step 3 — Get GPS coordinates
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Step 4 — Reverse geocode → city, state, country
      final placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        emit(
          ApiResponse.error(
            message: 'Could not resolve address from coordinates.',
          ),
        );
        return;
      }

      final place = placemarks.first;

      final location = UserLocationModel(
        latitude: position.latitude,
        longitude: position.longitude,
        city: place.locality,
        state: place.administrativeArea,
        country: place.country,
        postalCode: place.postalCode,
        fullAddress: [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country,
          place.postalCode,
        ].where((p) => p != null && p!.isNotEmpty).join(', '),
      );

      // ✅ Sync to AppConst — accessible anywhere without context
      AppConst.setUserLocation(location);

      emit(
        ApiResponse.completed(
          data: location,
          message: 'Location fetched successfully.',
        ),
      );
    } catch (e) {
      emit(
        ApiResponse.error(message: 'Failed to get location: ${e.toString()}'),
      );
    }
  }

  // ── Clear Location ──────────────────────────────────────────────────────

  void _onClearLocation(
    ClearLocationEvent event,
    Emitter<ApiResponse<UserLocationModel>> emit,
  ) {
    AppConst.clearUserLocation();
    emit(ApiResponse()); // reset to initial
  }
}
