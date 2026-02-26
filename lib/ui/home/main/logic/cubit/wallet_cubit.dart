/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:touristapp/ui/home/main/logic/service/wallet_service.dart'
    show WalletService;
import 'package:touristapp/utils/enums/api_status.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit(this.walletService) : super(const WalletState());

  final WalletService walletService;

  Future<void> createWallet() async {
    emit(state.copyWith(walletCreateStatus: ApiStatus.loading));
    final response = await walletService.createWallet();
    if (response.isSuccess) {
      emit(state.copyWith(walletCreateStatus: .success));
    } else {
      emit(
        state.copyWith(
          walletCreateStatus: .error,
          walletCreateError: response.error ?? "Unknown error",
        ),
      );
    }
  }
}
