/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:touristapp/utils/config/api_client.dart';
import 'package:touristapp/utils/config/response_config.dart';
import 'package:touristapp/utils/const/endpoints.dart';

class WalletService {
  final ApiClient api;

  WalletService(this.api);

  Future<NetworkResponse> createWallet() async {
    final response = await api.post(
      endPoint: Endpoints.createWallet,
      bearToken: true,
    );
    if (response.isSuccess) {
      return NetworkResponse.success(data: true);
    }
    return response;
  }
}
