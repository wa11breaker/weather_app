import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:permission_handler/permission_handler.dart'
    show PermissionStatus;
import 'package:weather_app/home/cubit/permission_client.dart';

part 'permission_state.dart';

class PermissionCubit extends Cubit<PermissionState> {
  PermissionCubit({required PermissionClient permissionClient})
    : _permissionClient = permissionClient,
      super(PermissionInitial());

  final PermissionClient _permissionClient;

  void checkPermission() async {
    final status = await _permissionClient.locationStatus();
    if (status == PermissionStatus.granted) {
      emit(PermissionGranted());
    } else if (status == PermissionStatus.denied) {
      emit(PermissionDenied());
    } else if (status == PermissionStatus.permanentlyDenied) {
      emit(PermissionPermanentlyDenied());
    }
  }

  void requestPermission() async {
    final status = await _permissionClient.requestLocationPermission();
    if (status == PermissionStatus.granted) {
      emit(PermissionGranted());
    } else if (status == PermissionStatus.denied) {
      emit(PermissionDenied());
    } else if (status == PermissionStatus.permanentlyDenied) {
      emit(PermissionPermanentlyDenied());
    }
  }

  void openAppSettings() async {
    await _permissionClient.openAppSettings();
  }
}
