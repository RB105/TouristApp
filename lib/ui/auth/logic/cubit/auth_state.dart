/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of 'auth_cubit.dart';

class AuthState {
  final String? errorMessage;
  final ApiStatus? registerStatus;
  final String? secretKey;

  final ApiStatus? confirmStatus;
  final String? confirmErrorMessage;
  final bool? isRegistered;

  AuthState({
    this.errorMessage,
    this.registerStatus,
    this.secretKey,
    //
    this.confirmStatus,
    this.confirmErrorMessage,
    this.isRegistered,
  });

  AuthState copyWith({
    ApiStatus? registerStatus,
    String? errorMessage,
    String? secretKey,
    //
    ApiStatus? confirmStatus,
    String? confirmErrorMessage,
    bool? isRegistered,
  }) {
    return AuthState(
      registerStatus: registerStatus ?? this.registerStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      secretKey: secretKey ?? this.secretKey,
      //
      confirmStatus: confirmStatus ?? this.confirmStatus,
      confirmErrorMessage: confirmErrorMessage ?? this.confirmErrorMessage,
      isRegistered: isRegistered ?? this.isRegistered,
    );
  }
}
