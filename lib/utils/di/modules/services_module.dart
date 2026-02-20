/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */
part of '../di.dart';

void _registerServicesModule() {
  _registerIfNotExists<AuthService>(() => AuthService(getIt<ApiClient>()));
}