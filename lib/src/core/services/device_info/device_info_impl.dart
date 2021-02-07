import 'dart:io';

import 'package:device_info/device_info.dart';

import 'device_info.dart';

/// Service that is responsible for getting hardware device info
class DeviceInfoServiceImpl implements DeviceInfoService {
  String _operatingSystem;
  String _device;
  String _udid;

  @override
  String get operatingSystem => _operatingSystem;

  @override
  String get device => _device;

  @override
  String get udid => _udid;

  DeviceInfoServiceImpl() {
    init();
  }

  @override
  Future<void> init() async {
    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      _udid = iosInfo.identifierForVendor;
      _operatingSystem = 'iOS';
      _device = iosInfo.utsname.machine;
    } else if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      _udid = androidInfo.androidId;
      _operatingSystem = 'Android';
      _device = androidInfo.brand + ' ' + androidInfo.model;
    }
  }

  @override
  String toString() =>
      'DeviceInfoServiceImpl(_operatingSystem: $_operatingSystem, _device: $_device, _udid: $_udid)';
}
