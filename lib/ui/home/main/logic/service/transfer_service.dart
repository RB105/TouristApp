/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:touristapp/ui/home/main/logic/model/carusel_transfer_service.dart';
import 'package:touristapp/ui/home/main/logic/model/transfer_create_sbp_result.dart';
import 'package:touristapp/ui/home/monitoring/logic/model/monitoring_result.dart';
import 'package:touristapp/utils/config/api_client.dart';
import 'package:touristapp/utils/config/response_config.dart';
import 'package:touristapp/utils/const/endpoints.dart';

class TransferService {
  final ApiClient _api;

  TransferService(this._api);

  Future<NetworkResponse> getTransferServices() async {
    final response = await _api.post(
      endPoint: Endpoints.transferServices,
      bearToken: true,
      params: {
        // "service_code": "V2S0014",
        // "service_name": "Ucoin Account to wallet"
        "sender_codes": ["V2S0008", "V2S0014"],
      },
    );

    if (response.isSuccess) {
      return NetworkResponse.success(
        data: CaruselTransferServiceResult.fromJson(response.data),
      );
    }

    return response;
  }

  Future<NetworkResponse> transferCreate({
    required String currency,
    required int amount,
    required String creditCode,
    required String debitCode,
  }) async {
    final response = await _api.post(
      endPoint: Endpoints.transferCreate,
      bearToken: true,
      params: {
        "amount": amount * 100,
        "currency": currency,
        "service_code": creditCode,
        "fields": {"debit_ext_id": debitCode},
      },
    );

    if (response.isSuccess) {
      return NetworkResponse.success(
        data: TransferCreateSbpResult.fromJson(response.data),
      );
    }
    return response;
  }

  Future<NetworkResponse> transferState({required String extId}) async {
    final response = await _api.post(
      endPoint: Endpoints.transferState,
      bearToken: true,
      params: {"ext_id": extId},
    );

    if (response.isSuccess) {
      return NetworkResponse.success(
        data: MonitoringHistory.fromJson(response.data),
      );
    }

    return response;
  }
}
