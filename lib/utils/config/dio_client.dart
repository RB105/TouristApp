/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:dio/dio.dart';

Future<Dio> createDio() async {

  // final methodChannel = const MethodChannel('TouristChannel');
  //
  // // BASE_URL
  // // LOCAL_URL
  // final String baseUrl = await methodChannel.invokeMethod('getKey', {
  //   'key': 'BASE_URL',
  // });
  // final String baseUrl = "https://staging-tourist-app.cloudgate.uz";
  final String baseUrl = "https://tourist-app.cloudgate.uz";
  final dio = Dio(
    BaseOptions(
      baseUrl: baseUrl,
      validateStatus: _validateStatus,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 120),
      sendTimeout: const Duration(seconds: 120),
      receiveTimeout: const Duration(seconds: 120),
    ),
  );
  return dio;
}

bool _validateStatus(int? statusCode) {
  if (statusCode != null) {

    return true;
  } else {
    return false;
  }
}
