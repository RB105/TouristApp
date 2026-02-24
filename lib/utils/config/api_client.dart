/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:dio/dio.dart'
    show Dio, DioException, DioExceptionType, Response;
import 'package:easy_localization/easy_localization.dart'
    show StringTranslateExtension, Intl;
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:touristapp/utils/config/response_config.dart'
    show NetworkResponse;
import 'package:touristapp/utils/enums/error_type.dart' show ErrorType;

class ApiClient {
  final Dio dio;

  ApiClient({required this.dio});

  /// Makes RPC POST request
  Future<NetworkResponse> post<T>({
    required String? endPoint,
    Map<String, dynamic>? params,
  }) async {
    try {
      debugPrint('\nRequest(url: $endPoint  , \n body: $params )');
      final response = await dio.post(endPoint ?? '', data: params);

      debugPrint('\nResponse(url: $endPoint , \n data: ${response.data} )');
      return _getResponse(response);
    } on DioException catch (e) {
      return _catchException(e);
    } catch (_) {
      return NetworkResponse.error(
        error: 'errors.error_other'.tr(),
        errorType: ErrorType.other,
      );
    }
  }

  /// Makes RPC GET request
  Future<NetworkResponse> get<T>({
    required String? endPoint,
    Map<String, dynamic>? params,
  }) async {
    try {
      debugPrint('\nRequest(url: $endPoint  , \n body: $params )');
      final response = await dio.get(endPoint ?? '', data: params);

      debugPrint('\nResponse(url: $endPoint , \n data: ${response.data} )');
      return _getResponse(response);
    } on DioException catch (e) {
      return _catchException(e);
    } catch (_) {
      return NetworkResponse.error(
        error: 'errors.error_other'.tr(),
        errorType: ErrorType.other,
      );
    }
  }

  NetworkResponse _getResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        if (response.data['success'] == true) {
          return NetworkResponse.success(data: response.data);
        }
        final lang = Intl.getCurrentLocale();

        // Defensive parsing
        final error = response.data['error'];
        if (error != null) {
          final message = error['message'];
          if (message is Map && message[lang] != null) {
            return NetworkResponse.error(
              error: message[lang],
              errorCode: error['code'] ?? 0,
            );
          } else if (message is String) {
            return NetworkResponse.error(error: message);
          }
        }

        // If the API doesn't use "error" key but returns "message" instead
        if (response.data['message'] != null) {
          return NetworkResponse.error(
            error: response.data['message'],
            errorCode: response.data['code'] ?? 0,
          );
        }

        return NetworkResponse.error(error: 'errors.error_unknown'.tr());
      case 400:
        return NetworkResponse.error(
          error: response.data['message'] ?? 'errors.error_400'.tr(),
          errorType: ErrorType.badRequest_400,
          errorCode: response.data['code'] ?? 400,
        );
        case 401:
        return NetworkResponse.error(
          error: response.data['message'] ?? 'errors.error_401'.tr(),
          errorType: ErrorType.unAuthorized_401,
          errorCode: response.data['code'] ?? 401,
        );
      case 500:
        return NetworkResponse.error(
          error: response.data['message'] ?? 'errors.error_500'.tr(),
          errorType: ErrorType.internalServer_500,
          errorCode: response.data['code'] ?? 500,
        );
      case 502:
        return NetworkResponse.error(
          error: response.data['message'] ?? 'errors.error_502'.tr(),
          errorType: ErrorType.badGateway_502,
          errorCode: response.data['code'] ?? 502,
        );
      case 503:
        return NetworkResponse.error(
          error: response.data['message'] ?? 'errors.error_503'.tr(),
          errorType: ErrorType.serviceUnavailable_503,
          errorCode: response.data['code'] ?? 503,
        );
      default:
        return NetworkResponse.error(error: 'errors.error_unknown'.tr());
    }
  }

  NetworkResponse _catchException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return NetworkResponse.error(
          error: 'errors.error_timeout'.tr(),
          errorType: ErrorType.timeout,
        );
      case DioExceptionType.connectionError:
        return NetworkResponse.error(
          error: 'errors.error_connection'.tr(),
          errorType: ErrorType.connectionError,
        );
      case DioExceptionType.unknown:
        return NetworkResponse.error(
          error: 'errors.error_connection'.tr(),
          errorType: ErrorType.connectionError,
        );
      default:
        return NetworkResponse.error(
          error: 'errors.error_other'.tr(),
          errorType: ErrorType.other,
        );
    }
  }
}
