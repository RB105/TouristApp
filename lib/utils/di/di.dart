/* January 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart' show GetIt;
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:touristapp/ui/auth/logic/cubit/auth_cubit.dart';
import 'package:touristapp/ui/auth/logic/service/auth_service.dart'
    show AuthService;
import 'package:touristapp/ui/home/main/logic/cubit/wallet_cubit.dart';
import 'package:touristapp/ui/home/main/logic/service/wallet_service.dart';
import 'package:touristapp/utils/config/api_client.dart' show ApiClient;
import 'package:touristapp/utils/config/dio_client.dart' show createDio;
import 'package:touristapp/utils/config/interceptors/auth_header_interceptor.dart'
    show AuthHeaderInterceptor;
import 'package:touristapp/utils/config/interceptors/base_headers_interceptor.dart'
    show BaseHeadersInterceptor;

part 'modules/services_module.dart';

part 'modules/network_module.dart';

part 'modules/storage_module.dart';

part 'modules/cubit_module.dart';

final getIt = GetIt.instance;

void setUpDI() async {
  _registerStorage();
  await _registerNetwork();
  _registerServicesModule();
  _registerCubitModule();
}

void _registerIfNotExists<T extends Object>(T Function() factory) {
  if (!getIt.isRegistered<T>()) {
    getIt.registerLazySingleton<T>(factory);
  }
}
