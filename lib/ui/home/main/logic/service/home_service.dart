/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:touristapp/ui/home/main/logic/model/home_details_result.dart';
import 'package:touristapp/utils/config/api_client.dart';
import 'package:touristapp/utils/config/response_config.dart';
import 'package:touristapp/utils/const/endpoints.dart';

class HomeService {
  final ApiClient api;

  HomeService(this.api);

  Future<NetworkResponse> getHomeDetails() async {
    final response = await api.get(
      endPoint: Endpoints.homeDetails,
      bearToken: true,
    );

    if (response.isSuccess) {
      return NetworkResponse.success(
        data: HomeDetailsResult.fromJson(response.data),
      );
    }



    return response;
  }
}
