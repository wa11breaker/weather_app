import 'package:permission_handler/permission_handler.dart';

class PermissionClient {
  Future<PermissionStatus> requestLocationPermission() async {
    return await Permission.locationWhenInUse.request();
  }

  Future<PermissionStatus> locationStatus() async {
    return await Permission.location.status;
  }

  Future<bool> openAppSettings() async {
    return await openAppSettings();
  }
}
