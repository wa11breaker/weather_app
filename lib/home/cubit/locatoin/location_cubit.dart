import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:location/location.dart';
import 'package:weather_app/home/cubit/locatoin/location_client.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit({required LocationClient locationClient})
    : _locationClient = locationClient,
      super(LocationInitial());

  final LocationClient _locationClient;

  Future<void> getLocation() async {
    emit(LocationLoading());

    try {
      final location = await _locationClient.getLocation();
      emit(LocationLoaded(location: location));
      getCityName(location);
    } catch (e) {
      emit(LocationFailed());
    }
  }

  Future<void> getCityName(LocationData location) async {
    final cityName = await _locationClient.getCityFromCoordinates(location);
    emit(LocationLoaded(location: location, cityName: cityName));
  }
}
