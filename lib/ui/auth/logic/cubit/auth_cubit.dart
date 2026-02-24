/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touristapp/ui/auth/logic/service/auth_service.dart';
import 'package:touristapp/utils/enums/api_status.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authService) : super(AuthState());
  final AuthService authService;

  void register({required String phone}) async {
    emit(state.copyWith(registerStatus: ApiStatus.loading));
    try {
      final response = await authService.register(phone: phone);
      if (response.isSuccess) {
        emit(
          state.copyWith(
            registerStatus: ApiStatus.success,
            secretKey: response.data ?? "",
          ),
        );
      } else {
        emit(
          state.copyWith(
            registerStatus: ApiStatus.error,
            errorMessage: response.error.toString(),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          registerStatus: ApiStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void verifyOtp({required String phone, required int otp}) async {
    emit(state.copyWith(confirmStatus: ApiStatus.loading));
    try {
      final response = await authService.verifyOtp(phone: phone, otp: otp);
      if (response.isSuccess) {
        emit(
          state.copyWith(
            confirmStatus: ApiStatus.success,
            isRegistered: response.data ?? false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            confirmStatus: ApiStatus.error,
            confirmErrorMessage: response.error.toString(),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          confirmStatus: ApiStatus.error,
          confirmErrorMessage: e.toString(),
        ),
      );
    }
  }

  void setPassword({
    required String password,
    required String phone,
    required String key,
  }) async {
    emit(state.copyWith(registerPasswordStatus: .loading));
    try {
      final response = await authService.setPassword(
        password: password,
        phone: phone,
        key: key,
      );
      if (response.isSuccess) {
        emit(
          state.copyWith(
            registerPasswordStatus: ApiStatus.success,
            registerSuccess: response.data ?? false,
          ),
        );
      } else {
        emit(
          state.copyWith(
            registerPasswordStatus: ApiStatus.error,
            registerErrorMessage: response.error.toString(),
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          registerPasswordStatus: ApiStatus.error,
          registerErrorMessage: e.toString(),
        ),
      );
    }
  }
}
