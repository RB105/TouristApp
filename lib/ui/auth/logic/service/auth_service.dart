/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:touristapp/utils/config/api_client.dart';
import 'package:touristapp/utils/const/endpoints.dart';

class AuthService {
  final ApiClient apiClient;

  AuthService(this.apiClient);

  Future register() async {
    final response = await apiClient.post(
      endPoint: Endpoints.telegramVerify,
      params: {
        "phone_number": "+998974559995",
        "otp_type": 1
      },
    );

    return response;
  }

    Future verifyOtp() async {
      final response = await apiClient.post(
        endPoint: Endpoints.telegramVerify,
        params: {
          "phone_number": "+998974559995",
          "otp_type": 1,
          "otp_code": 1234
        },
      );

      return response;
    }

    Future setPassword() async {
      final response = await apiClient.post(
        endPoint: Endpoints.setPassword,
        params: {
          "phone_number": "998974559995",
          "password": "125698_Sa",
          "confirm_password": "125698_Sa",
          "secret_key": "31b3c505-b417-4f1e-a937-3d439ea62d00"
        },
      );

      return response;
    }
}
