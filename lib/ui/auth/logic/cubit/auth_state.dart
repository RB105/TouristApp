/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of 'auth_cubit.dart';

class AuthState {
  final String? errorMessage;
  final ApiStatus? registerStatus;
  final String? secretKey;

  final ApiStatus? confirmStatus;
  final String? confirmErrorMessage;
  final bool? isRegistered;

  final ApiStatus registerPasswordStatus;
  final String? registerErrorMessage;

  final ApiStatus loginStatus;
  final String loginErrorMessage;
  //
  final ApiStatus forgotPasswordPhoneState;
  final String forgotPasswordPhoneError;
  final String? requestId;
  //
  final ApiStatus forgotPasswordState;
  final String forgotPasswordError;


  AuthState({
    this.errorMessage,
    this.registerStatus,
    this.secretKey,
    //
    this.confirmStatus,
    this.confirmErrorMessage,
    this.isRegistered,
    //
    this.registerPasswordStatus = ApiStatus.initial,
    this.registerErrorMessage,
    //
    this.loginStatus = .initial,
    this.loginErrorMessage = '',
    //
    this.forgotPasswordPhoneState = ApiStatus.initial,
    this.forgotPasswordPhoneError = '',
    this.requestId,
    //
    this.forgotPasswordState = ApiStatus.initial,
    this.forgotPasswordError = '',
  });

  AuthState copyWith({
    ApiStatus? registerStatus,
    String? errorMessage,
    String? secretKey,
    //
    ApiStatus? confirmStatus,
    String? confirmErrorMessage,
    bool? isRegistered,
    //
    ApiStatus? registerPasswordStatus,
    String? registerErrorMessage,
    bool? registerSuccess,
    //
    ApiStatus? loginStatus,
    String? loginErrorMessage,
    //
    ApiStatus? forgotPasswordPhoneState,
    String? forgotPasswordPhoneError,
    String? requestId,
    //
    ApiStatus? forgotPasswordState,
    String? forgotPasswordError,
    //
  }) {
    return AuthState(
      registerStatus: registerStatus ?? this.registerStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      secretKey: secretKey ?? this.secretKey,
      //
      confirmStatus: confirmStatus ?? this.confirmStatus,
      confirmErrorMessage: confirmErrorMessage ?? this.confirmErrorMessage,
      isRegistered: isRegistered ?? this.isRegistered,
      //
      registerPasswordStatus:
          registerPasswordStatus ?? this.registerPasswordStatus,
      registerErrorMessage: registerErrorMessage ?? this.registerErrorMessage,
      //
      loginStatus: loginStatus ?? this.loginStatus,
      loginErrorMessage: loginErrorMessage ?? this.loginErrorMessage,
      //
      forgotPasswordPhoneState: forgotPasswordPhoneState ?? this.forgotPasswordPhoneState,
      forgotPasswordPhoneError: forgotPasswordPhoneError ?? this.forgotPasswordPhoneError,
      requestId: requestId ?? this.requestId,
      //
      forgotPasswordState: forgotPasswordState ?? this.forgotPasswordState,
      forgotPasswordError: forgotPasswordError ?? this.forgotPasswordError
    );
  }
}
