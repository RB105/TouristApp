/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:touristapp/utils/enums/error_type.dart' show ErrorType;

class NetworkResponse<T> {
  final T? data;
  final T? error;
  final ErrorType? errorType;
  final int? errorCode;

  NetworkResponse._({this.data, this.error, this.errorType, this.errorCode});

  factory NetworkResponse.success({required T data}) {
    return NetworkResponse._(data: data);
  }

  factory NetworkResponse.error({
    required T error,
    final ErrorType? errorType,
    final int? errorCode,
  }) {
    return NetworkResponse._(
      error: error,
      errorType: errorType,
      errorCode: errorCode,
    );
  }

  int get code => errorCode ?? 0;

  bool get isSuccess => data != null && error == null;

  bool get isError => error != null;
}
