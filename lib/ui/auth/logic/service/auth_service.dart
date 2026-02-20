/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:touristapp/utils/config/api_client.dart';
import 'package:touristapp/utils/const/endpoints.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService(this.apiClient);

  Future register({required String phone}) async {
    final response = await apiClient.post(
      endPoint: Endpoints.telegramVerify,
      params: {
        "phone_number": phone,
        "otp_type": 1
      },
    );

    return response;
  }

    Future verifyOtp({required String phone, required int otp}) async {
      final response = await apiClient.post(
        endPoint: Endpoints.telegramVerify,
        params: {
          "phone_number": phone,
          "otp_type": 1,
          "otp_code": otp
        },
      );

      return response;
    }

    Future setPassword({required String phone, required String password, required String key}) async {
      final response = await apiClient.post(
        endPoint: Endpoints.setPassword,
        params: {
          "phone_number": phone,
          "password": password,
          "confirm_password": password,
          "secret_key": key
        },
      );

      return response;
    }
}
