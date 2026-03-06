/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of '../di.dart';

void _registerCubitModule() {
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthService>()));
  getIt.registerFactory<WalletCubit>(() => WalletCubit(getIt<WalletService>()));
  getIt.registerFactory<QrCubit>(() => QrCubit(getIt<QrService>()));
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeService>()));
}
