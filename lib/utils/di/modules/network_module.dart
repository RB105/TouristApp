/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of '../di.dart';

Future<void> _registerNetwork() async {
  final dio = await createDio();
  _registerIfNotExists<Dio>(() => dio);
  // _registerIfNotExists<DeviceInfoService>(() => DeviceInfoService());

  // Interceptors
  _registerIfNotExists<BaseHeadersInterceptor>(() => BaseHeadersInterceptor());
  _registerIfNotExists<AuthHeaderInterceptor>(
    () => AuthHeaderInterceptor(getIt<GetStorage>()),
  );
  // _registerIfNotExists<DeviceInfoInterceptor>(() => DeviceInfoInterceptor(deviceInfo: getIt<DeviceInfoService>(),storage: getIt<GetStorage>()));

  _setupDio();
  _registerIfNotExists<ApiClient>(() => ApiClient(dio: getIt<Dio>()));
}

void _setupDio() {
  final dio = getIt<Dio>();

  dio.interceptors.addAll([
    getIt<BaseHeadersInterceptor>(),
    getIt<AuthHeaderInterceptor>(),
    // getIt<DeviceInfoInterceptor>(),
  ]);
}
