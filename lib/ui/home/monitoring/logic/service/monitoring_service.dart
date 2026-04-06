/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:touristapp/utils/config/api_client.dart';
import 'package:touristapp/utils/config/response_config.dart';
import 'package:touristapp/utils/const/endpoints.dart';

import '../model/monitoring_result.dart' show MonitoringResult;

class MonitoringService {
  final ApiClient api;

  MonitoringService(this.api);


  Future<NetworkResponse> getMonitoring(int page) async {
    final response = await api.get(
      endPoint: "${Endpoints.monitoring}?page=$page",
      bearToken: true,
    );

    if(response.isSuccess){
      return NetworkResponse.success(
        data: MonitoringResult.fromJson(response.data),
      );
    }

    return response;
  }
}