/* February 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

part of '../di.dart';

void _registerStorage() async {
  _registerIfNotExists<GetStorage>(() => GetStorage());
}
