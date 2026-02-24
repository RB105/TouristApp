/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:touristapp/utils/config/api_client.dart';
import 'package:touristapp/utils/config/response_config.dart';
import 'package:touristapp/utils/const/endpoints.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService(this.apiClient);

  Future<NetworkResponse> register({required String phone}) async {
    final response = await apiClient.post(
      endPoint: Endpoints.telegramVerify,
      params: {"phone_number": phone, "otp_type": 1},
    );

    if (response.isSuccess) {
      return NetworkResponse.success(data: response.data['secret_key'] ?? "");
    }

    return response;
  }

  Future<NetworkResponse> verifyOtp({
    required String phone,
    required int otp,
  }) async {
    final response = await apiClient.post(
      endPoint: Endpoints.checkTelegramVerify,
      params: {"phone_number": phone, "otp_code": otp},
    );

    if (response.isSuccess) {
      return NetworkResponse.success(data: true);
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
        "phone_number": phone,
        "password": password,
        "confirm_password": password,
        "secret_key": key,
      },
    );

    return response;
  }

  Future<NetworkResponse> login({
    required String phone,
    required String password,
  }) async {
    final response = await apiClient.post(
      endPoint: Endpoints.setPassword,
      params: {"phone_number": phone, "password": password},
    );

    return response;
  }
}
