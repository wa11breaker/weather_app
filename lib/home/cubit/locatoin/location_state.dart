part of 'location_cubit.dart';

@immutable
sealed class LocationState {}

final class LocationInitial extends LocationState {}

final class LocationLoading extends LocationState {}

final class LocationLoaded extends LocationState {
  final LocationData location;
  final String? cityName;

  LocationLoaded({required this.location, this.cityName});
}

final class LocationFailed extends LocationState {}
