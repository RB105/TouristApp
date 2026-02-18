/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

// import 'package:a_pay/utils/service/device_info_service.dart' show DeviceInfoService;
import 'package:dio/dio.dart';
// import 'package:get_storage/get_storage.dart' show GetStorage;

/// ```
/// ("User-Agent") —> User Agent
/// ("REMOTE_ADDR") —> IP address
/// ("X-Language") —> App lang
/// ("X-Device-ID") —> Device Unique ID
/// ("X-Device-Name")  —> Device Name
/// ("X-Device-Os") —> Device OS
/// ("X-Device-Os-Version") —> Device OS version
/// ("X-Version") —> App version
/// ("X-Firebase-Token") —> Firebase Reg ID
/// ```
class DeviceInfoInterceptor extends Interceptor {
  // final DeviceInfoService deviceInfo;
  // final GetStorage storage;
  //
  // DeviceInfoInterceptor({required this.storage, required this.deviceInfo});
  //
  // @override
  // void onRequest(
  //     RequestOptions options,
  //     RequestInterceptorHandler handler,
  //     ) async {
  //   try {
  //     final version = await deviceInfo.getVersionName();
  //     final device = await deviceInfo.getDeviceInfo();
  //
  //     // final ip = await deviceInfo.getDeviceIp();
  //     // options.headers['X-Version'] = version;
  //     // options.headers['REMOTE_ADDR'] = ip;
  //     // options.headers['X-Device-ID'] = device.id;
  //     // options.headers['X-Language'] = storage.read('lang') ?? "ru";
  //     // options.headers['X-Device-Name'] = device.name;
  //     // options.headers['X-Device-Os'] = device.platform;
  //     // // options.headers['X-Device-Os-Version'] = device.platformVersion;
  //     // options.headers['X-Firebase-Token'] = storage.read('reg_id') ?? "";
  //     options.headers['Version'] = version;
  //     options.headers['Uuid'] = device.id;
  //   } catch (_) {}
  //   super.onRequest(options, handler);
  // }
}
