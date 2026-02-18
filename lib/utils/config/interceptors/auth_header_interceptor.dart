/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;

class AuthHeaderInterceptor extends Interceptor {
  final GetStorage storage;

  AuthHeaderInterceptor(this.storage);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final token = storage.read<String>('access_token');
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
