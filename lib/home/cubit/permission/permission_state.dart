part of 'permission_cubit.dart';

sealed class PermissionState extends Equatable {
  const PermissionState();

  @override
  List<Object> get props => [];
}

final class PermissionInitial extends PermissionState {}

final class PermissionGranted extends PermissionState {}

final class PermissionDenied extends PermissionState {}

final class PermissionPermanentlyDenied extends PermissionState {}
