/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touristapp/ui/home/main/logic/model/payment_create_result.dart'
    show PaymentCreateResult;
import 'package:touristapp/ui/home/main/logic/model/qr_check_result.dart';
import 'package:touristapp/ui/home/main/logic/model/transaction_result.dart';
import 'package:touristapp/ui/home/main/logic/service/qr_service.dart';
import 'package:touristapp/utils/enums/api_status.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  QrCubit(this.qrService) : super(const QrState());

  final QrService qrService;

  void checkQr(String qrId) async {
    emit(state.copyWith(qrCheckStatus: ApiStatus.loading));
    final response = await qrService.check(qrId);
    if (response.isSuccess) {
      emit(
        state.copyWith(qrCheckStatus: .success, qrCheckResult: response.data),
      );
    } else {
      emit(
        state.copyWith(
          qrCheckStatus: .error,
          qrCheckError: response.error ?? "Unknown error",
        ),
      );
    }
  }

  void createPayment({
    required String extId,
    required double amount,
  }) async {
    emit(state.copyWith(paymentCreateStatus: ApiStatus.loading));
    final response = await qrService.paymentCreate(
      extId: extId,
      amount: amount,
    );
    if (response.isSuccess) {
      emit(
        state.copyWith(
          paymentCreateStatus: .success,
          paymentCreateResult: response.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          paymentCreateStatus: .error,
          paymentCreateError: response.error ?? "Unknown error",
        ),
      );
    }
  }

  void confirmPayment({required String extId, required String otpCode}) async {
    emit(state.copyWith(paymentConfirmStatus: ApiStatus.loading));
    final response = await qrService.paymentConfirm(
      extId: extId,
      otpCode: otpCode,
    );
    if (response.isSuccess) {
      emit(
        state.copyWith(
          paymentConfirmStatus: .success,
          transaction: response.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          paymentConfirmStatus: .error,
          paymentConfirmError: response.error ?? "Unknown error",
        ),
      );
    }
  }
}
