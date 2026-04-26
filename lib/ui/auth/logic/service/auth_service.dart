/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:get_storage/get_storage.dart';
import 'package:touristapp/utils/config/api_client.dart';
import 'package:touristapp/utils/config/response_config.dart';
import 'package:touristapp/utils/const/endpoints.dart';
import 'package:touristapp/utils/di/di.dart';

class AuthService {
  final _getStorage = getIt<GetStorage>();
  final ApiClient apiClient;

  AuthService(this.apiClient);

  Future<NetworkResponse> register({required String phone}) async {
    final response = await apiClient.post(
      endPoint: Endpoints.register,
      params: {"imprement": phone, "social_type": 1},
    );

    if (response.isSuccess) {
      if (response.data['is_register'] == true) {
        return NetworkResponse.success(data: true);
      }
      return NetworkResponse.success(data: false);
    }

    return response;
  }

  Future<NetworkResponse> verifyOtp({
    required String phone,
    required String otp,
    String? reqId,
  }) async {
    final params = {"imprement": phone, "otp_code": otp, "social_type": 1};
    if (reqId?.isNotEmpty ?? false) {
      params['request_id'] = reqId!;
    }
    final response = await apiClient.post(
      endPoint: Endpoints.confirmOtp,
      params: params,
    );

    if (response.isSuccess) {
      return NetworkResponse.success(data: response.data['secret_key'] ?? "");
    }
    // else if login state
    else if (response.error == "You already registered") {
      return NetworkResponse.success(data: false);
    }

    return response;
  }

  Future<NetworkResponse> setPassword({
    required String phone,
    required String password,
    required String key,
  }) async {
    final response = await apiClient.post(
      endPoint: Endpoints.setPassword,
      params: {
        "imprement": phone,
        "password": password,
        "confirm_password": password,
        "secret_key": key,
      },
    );

    if (response.isSuccess) {
      _getStorage.write("refresh_token", response.data['refresh']);
      _getStorage.write("access_token", response.data['access']);
      return NetworkResponse.success(data: true);
    }

    return response;
  }

  Future<NetworkResponse> login({
    required String phone,
    required String password,
  }) async {
    final response = await apiClient.post(
      endPoint: Endpoints.login,
      params: {"imprement": phone, "password": password},
    );

    if (response.isSuccess) {
      _getStorage.write("refresh_token", response.data['result']['refresh']);
      _getStorage.write("access_token", response.data['result']['access']);
      return NetworkResponse.success(data: true);
    }

    return response;
  }

  Future<NetworkResponse> forgotPasswordPhone({required String phone}) async {
    final response = await apiClient.post(
      endPoint: Endpoints.forgotPasswordPhone,
      params: {"social_type": 1, "imprement": phone},
    );

    if (response.isSuccess) {
      return NetworkResponse.success(data: response.data);
    }

    return response;
  }

  Future<NetworkResponse> forgotPassword({required String phone,
    required String password,
    required String key,}) async {
    final response = await apiClient.post(
      endPoint: Endpoints.forgotPassword,
      params: {
        "imprement": phone,
        "password": password,
        "secret_key": key,
      },
    );

    if (response.isSuccess) {
      return NetworkResponse.success(data: true);
    }

    return response;
  }
}
