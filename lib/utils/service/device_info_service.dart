/* October 2025 , Baxrom Rajabov, Tashkent , Uzbekistan */
import 'dart:io' show InternetAddressType, NetworkInterface, Platform;

import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart' show debugPrint;
import 'package:flutter/services.dart' show MethodChannel;
import 'package:mobile_device_identifier/mobile_device_identifier.dart'
    show MobileDeviceIdentifier;
import 'package:uuid/uuid.dart' show Uuid;

class DeviceInfoService {

  DeviceInfo? deviceInfo;
  late IosDeviceInfo iosDeviceInfo;

  late int versionCode;
  late String versionName;

  static final _channel = MethodChannel("TouristChannel");

  DeviceInfoService() {
    getDeviceInfo();
    getVersionCode();
    getVersionName();
  }

  Future<DeviceInfo> getDeviceInfo() async {
    DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      final info = await deviceInfoPlugin.androidInfo;

      deviceInfo = DeviceInfo(
        platform: "ANDROID",
        name: info.name,
        model: info.model,
        id: info.id,
        isPhysicalDevice: info.isPhysicalDevice,
      );
      return deviceInfo!;
    } else {
      String? uuid = await AppMetrica.deviceId;
      iosDeviceInfo = await deviceInfoPlugin.iosInfo;

      final mobileDeviceIdentifier = await MobileDeviceIdentifier()
          .getDeviceId();
      debugPrint("$mobileDeviceIdentifier");
      deviceInfo = DeviceInfo(
        platform: "IOS",
        name: iosDeviceInfo.modelName,
        model: iosDeviceInfo.model,
        id: mobileDeviceIdentifier ?? uuid ?? Uuid().v4(),
        isPhysicalDevice: iosDeviceInfo.isPhysicalDevice,
      );
      return deviceInfo!;
    }
  }

  /// result => 1125
  Future<int> getVersionCode() async {
    final code = await _channel.invokeMethod("getVersionCode");

    versionCode = int.tryParse("$code") ?? 0;

    debugPrint("Version code: $versionCode");

    return versionCode;
  }

  /// result => "1.0.1"
  Future<String> getVersionName() async {
    versionName =  await _channel.invokeMethod<String>('getVersionName') ?? "";
    debugPrint("Version name: $versionName");
    return versionName;
  }

  /// result => 192.168.1.5
  Future<String> getDeviceIp() async {
    try {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );

      for (final interface in interfaces) {
        for (final addr in interface.addresses) {
          if (!addr.isLoopback) {
            return addr.address;
          }
        }
      }
      return "";
    } catch (e) {
      debugPrint('Error getting device IP: $e');
      return "";
    }
  }
}

class DeviceInfo {
  final String platform;
  final String name;
  final String model;
  final String id;
  final bool isPhysicalDevice;

  DeviceInfo({
    required this.platform,
    required this.name,
    required this.model,
    required this.id,
    required this.isPhysicalDevice,
  });

  /// Factory constructor to create DeviceInfo from a Map
  factory DeviceInfo.fromMap(Map<String, dynamic> map) {
    return DeviceInfo(
      platform: map['platform'] ?? '',
      name: map['name'] ?? '',
      model: map['model'] ?? '',
      id: map['id'] ?? '',
      isPhysicalDevice: map['isPhysicalDevice'] ?? false,
    );
  }

  /// Convert DeviceInfo to Map
  Map<String, dynamic> toMap() {
    return {
      'platform': platform,
      'name': name,
      'model': model,
      'id': id,
      'isPhysicalDevice': isPhysicalDevice,
    };
  }
}
