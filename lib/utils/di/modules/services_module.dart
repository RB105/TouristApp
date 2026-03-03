/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */
part of '../di.dart';

void _registerServicesModule() {
  _registerIfNotExists<AuthService>(() => AuthService(getIt<ApiClient>()));
  _registerIfNotExists<WalletService>(() => WalletService(getIt<ApiClient>()));
  _registerIfNotExists<QrService>(() => QrService(getIt<ApiClient>()));
}
