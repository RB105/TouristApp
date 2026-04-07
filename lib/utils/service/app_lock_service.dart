/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:touristapp/utils/di/di.dart';

import '../../ui/auth/view/screens/pin_code_screen.dart' show PinCodeScreen, PinStep;
import '../router/router.dart' show navigatorKey;

class AppLockService with WidgetsBindingObserver {
  static final AppLockService instance = AppLockService._();

  AppLockService._();

  DateTime? _backgroundTime;
  bool enabled = true;

  bool _isPinScreenOpen = false;

  void init() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!enabled) return;

    if (state == AppLifecycleState.paused) {
      _backgroundTime = DateTime.now();
    }

    if (state == AppLifecycleState.resumed) {
      if (_backgroundTime == null) return;

      final diff = DateTime.now().difference(_backgroundTime!).inSeconds;

      if (diff >= 300) _showPinScreen();

      _backgroundTime = null;
    }
  }

  void _showPinScreen() async {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    if (_isOnPinPage(context)) return;

    if (_isPinScreenOpen) return;
    _isPinScreenOpen = true;

    final box = getIt<GetStorage>();
    final savedPin = box.read(PinCodeScreen.pinKey);
    if (savedPin == null) {
      _isPinScreenOpen = false;
      return;
    }

    await GoRouter.of(
      context,
    ).push(PinCodeScreen.routeName, extra: PinStep.unlock);

    _isPinScreenOpen = false;
  }

  bool _isOnPinPage(BuildContext context) {
    final router = GoRouter.of(context);
    final matches = router.routerDelegate.currentConfiguration.matches;

    if (matches.isEmpty) return false;

    final currentRouteName = matches.last.matchedLocation;
    return currentRouteName == '/';
  }
}
