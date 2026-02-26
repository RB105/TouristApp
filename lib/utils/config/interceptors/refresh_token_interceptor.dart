/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:touristapp/utils/const/endpoints.dart';

class RefreshTokenInterceptor extends Interceptor {
  final Dio dio;
  final GetStorage storage;

  bool _isRefreshing = false;
  final List<void Function()> _queue = [];

  RefreshTokenInterceptor({required this.dio, required this.storage});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401) {
      return handler.next(err);
    }

    final refreshToken = storage.read<String>('refresh_token');
    if (refreshToken == null) {
      return handler.next(err);
    }

    if (_isRefreshing) {
      _queue.add(() async {
        final response = await _retry(err.requestOptions);
        handler.resolve(response);
      });
      return;
    }

    _isRefreshing = true;

    try {
      final newTokens = await _refresh(refreshToken);

      storage.write('access_token', newTokens['access_token']);
      storage.write('refresh_token', newTokens['refresh_token']);

      for (final cb in _queue) {
        cb();
      }

      _queue.clear();

      final response = await _retry(err.requestOptions);
      handler.resolve(response);
    } catch (_) {
      storage.erase();
      handler.next(err);
    } finally {
      _isRefreshing = false;
    }
  }

  Future<Response> _retry(RequestOptions options) {
    final opts = Options(method: options.method, headers: options.headers);

    return dio.request(
      options.path,
      data: options.data,
      queryParameters: options.queryParameters,
      options: opts,
    );
  }

  Future<Map<String, dynamic>> _refresh(String refreshToken) async {
    final response = await dio.post(
      Endpoints.refreshToken,
      data: {'refresh_token': refreshToken},
    );

    return (response.data['result']);
  }
}
