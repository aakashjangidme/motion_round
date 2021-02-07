abstract class DeviceInfoService {
  String get operatingSystem;
  String get device;
  String get udid;

  Future<void> init();
}
