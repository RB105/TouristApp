/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of '../di.dart';

void _registerCubitModule() {
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthService>()));
}
