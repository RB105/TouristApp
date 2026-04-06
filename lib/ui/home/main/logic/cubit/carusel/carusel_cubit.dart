/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touristapp/ui/home/main/logic/model/carusel_transfer_service.dart';
import 'package:touristapp/ui/home/main/logic/model/transfer_create_sbp_result.dart';
import 'package:touristapp/ui/home/main/logic/service/transfer_service.dart';
import 'package:touristapp/utils/enums/api_status.dart';

part 'carusel_state.dart';

class CaruselCubit extends Cubit<CaruselState> {
  CaruselCubit(this._transferService) : super(CaruselState());

  final TransferService _transferService;

  Future<void> getTransferServices() async {
    emit(CaruselState(transferServiceStatus: ApiStatus.loading));

    final response = await _transferService.getTransferServices();

    if (response.isSuccess) {
      emit(
        state.copyWith(
          transferServiceStatus: ApiStatus.success,
          transferServiceResult: response.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          transferServiceStatus: ApiStatus.error,
          transferServiceError: response.error.toString(),
        ),
      );
    }
  }

  void transferSbpCreate() async {
    emit(CaruselState(transferCreateStatus: .loading));
    final response = await _transferService.transferCreate(
      currency: "643",
      amount: 100,
      creditCode: "V2S0008",
      debitCode: "V2S0008",
    );
    if (response.isSuccess) {
      emit(
        state.copyWith(
          transferCreateStatus: .success,
          transferCreateSbpResult: response.data,
        ),
      );
    } else {
      emit(
        state.copyWith(
          transferCreateStatus: .error,
          transferCreateError: response.error.toString(),
        ),
      );
    }
  }
}
