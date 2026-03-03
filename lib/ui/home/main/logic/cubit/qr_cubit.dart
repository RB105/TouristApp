/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touristapp/ui/home/main/logic/model/qr_check_result.dart';
import 'package:touristapp/ui/home/main/logic/service/qr_service.dart';
import 'package:touristapp/utils/enums/api_status.dart';

part 'qr_state.dart';

class QrCubit extends Cubit<QrState> {
  QrCubit(this.qrService): super(const QrState());

  final QrService qrService;

  void checkQr(String qrId) async {
    emit(state.copyWith(qrCheckStatus: ApiStatus.loading));
    final response = await qrService.check(qrId);
    if (response.isSuccess) {
      final data = response.data as QrCheckResult;
      emit(state.copyWith(qrCheckStatus: .success, qrCheckResult: data));
    } else {
      emit(
        state.copyWith(
          qrCheckStatus: .error,
          qrCheckError: response.error ?? "Unknown error",
        ),
      );
    }
  }
}