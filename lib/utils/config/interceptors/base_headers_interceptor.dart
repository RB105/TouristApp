/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:dio/dio.dart' show Interceptor, RequestOptions, RequestInterceptorHandler, Response, ResponseInterceptorHandler;
import 'package:flutter/foundation.dart' show debugPrint;

class BaseHeadersInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Content-Type'] = 'application/json';
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
    debugPrint('\nRequest(url: ${options.path}  , \n body: ${options.data} )');
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    debugPrint('\nResponse(code: ${response.statusCode} , \n data: ${response.data} )');
  }
}