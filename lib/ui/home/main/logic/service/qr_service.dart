/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:touristapp/ui/home/main/logic/model/payment_create_result.dart';
import 'package:touristapp/ui/home/main/logic/model/qr_check_result.dart';
import 'package:touristapp/ui/home/main/logic/model/transaction_result.dart';
import 'package:touristapp/utils/config/api_client.dart';
import 'package:touristapp/utils/config/response_config.dart';
import 'package:touristapp/utils/const/endpoints.dart';

class QrService {
  final ApiClient api;

  QrService(this.api);

  Future<NetworkResponse> check(String qrId) async {
    final response = await api.get(
      endPoint: "${Endpoints.checkQr}/$qrId/?currency=860",
      bearToken: true,
    );

    if (response.isSuccess) {
      final data = QrCheckResult.fromJson(response.data);
      return NetworkResponse.success(data: data);
    }

    return response;
  }

  Future<NetworkResponse> paymentCreate({
    required String extId,
    required double amount,
  }) async {
    final response = await api.post(
      endPoint: Endpoints.createPayment,
      bearToken: true,
      params: {"amount": amount * 100, "ext_id": extId},
    );

    if (response.isSuccess) {
      return NetworkResponse.success(
        data: PaymentCreateResult.fromJson(response.data),
      );
    }

    return response;
  }

  Future<NetworkResponse> paymentConfirm({
    required String extId,
    required String otpCode,
  }) async {
    final response = await api.post(
      endPoint: Endpoints.checkConfirm,
      bearToken: true,
      params: {"otp_code": otpCode, "ext_id": extId},
    );

    if (response.isSuccess) {
      return NetworkResponse.success(
        data: TransactionResult.fromJson(response.data),
      );
    }

    return response;
  }
}
