/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:go_router/go_router.dart';
import 'package:touristapp/ui/auth/view/auth_screen.dart';
import 'package:touristapp/ui/auth/view/auth_wallet_create.dart';
import 'package:touristapp/ui/home/chat/chat_screen.dart';
import 'package:touristapp/ui/home/home_screen.dart';
import 'package:touristapp/ui/home/main/logic/model/payment_create_result.dart';
import 'package:touristapp/ui/home/main/logic/model/qr_check_result.dart' show QrCheckResult;
import 'package:touristapp/ui/home/main/ui/main_screen.dart';
import 'package:touristapp/ui/home/main/ui/payments_screen.dart';
import 'package:touristapp/ui/home/main/ui/screens/top_up/bank_launcher_screen.dart';
import 'package:touristapp/ui/home/main/ui/screens/top_up/cheque_screen.dart';
import 'package:touristapp/ui/home/monitoring/ui/monitoring_screen.dart';
import 'package:touristapp/ui/home/profile/profile_screen.dart';
import 'package:touristapp/ui/splash/on_boarding_screen.dart';

import '../../ui/home/main/logic/model/transfer_create_sbp_result.dart' show TransferCreateSbpResult;
import '../../ui/home/main/ui/screens/qr/qr_amoun_screen.dart' show QrAmounScreen;
import '../../ui/home/main/ui/screens/qr/qr_otp_screen.dart' show QrOtpScreen;

part 'app_router.g.dart';


@TypedGoRoute<RootRoute>(path: '/')
class RootRoute extends GoRouteData with $RootRoute {
  const RootRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final firstLaunch = GetStorage().read<bool?>('first_launch');
    final access = GetStorage().read<String?>('access_token');

    if (firstLaunch ?? true) {
      debugPrint(firstLaunch.toString());
      return const OnBoardingRoute().location;
    }

    if (access == null) {
      debugPrint(access);
      // return const AuthWalletCreateRoute().location;
      return const AuthRoute().location;
    }
    debugPrint('/main');

    return const MainRoute().location;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SizedBox(); // never shown
  }
}

/// LOGIN
@TypedGoRoute<AuthRoute>(path: '/auth')
class AuthRoute extends GoRouteData with $AuthRoute {
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AuthScreen();
  }
}

@TypedGoRoute<OnBoardingRoute>(path: '/onboarding')
class OnBoardingRoute extends GoRouteData with $OnBoardingRoute {
  const OnBoardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const OnBoardingScreen();
  }
}

@TypedGoRoute<AuthWalletCreateRoute>(path: '/auth-wallet-create')
class AuthWalletCreateRoute extends GoRouteData with $AuthWalletCreateRoute {
  const AuthWalletCreateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const AuthWalletCreate();
  }
}


/// MAIN SHELL
@TypedStatefulShellRoute<HomeShellRoute>(
  branches: [
    TypedStatefulShellBranch(
      routes: [
        TypedGoRoute<MainRoute>(
          path: '/main',
          routes: [TypedGoRoute<PaymentsRoute>(path: 'payments')],
        ),
      ],
    ),
    TypedStatefulShellBranch(routes: [TypedGoRoute<ChatRoute>(path: '/chat')]),
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<MonitoringRoute>(path: '/monitoring')],
    ),
    TypedStatefulShellBranch(
      routes: [TypedGoRoute<ProfileRoute>(path: '/profile')],
    ),
  ],
)
class HomeShellRoute extends StatefulShellRouteData {
  const HomeShellRoute();

  @override
  Widget builder(
    BuildContext context,
    GoRouterState state,
    StatefulNavigationShell navigationShell,
  ) {
    return HomeScreen(shell: navigationShell);
  }
}

/// MAIN TAB
class MainRoute extends GoRouteData with $MainRoute {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MainScreen();
  }
}

/// PAYMENTS
class PaymentsRoute extends GoRouteData with $PaymentsRoute {
  const PaymentsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return PaymentsScreen();
  }
}

/// CHAT
class ChatRoute extends GoRouteData with $ChatRoute {
  const ChatRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ChatScreen();
  }
}

/// MONITORING
class MonitoringRoute extends GoRouteData with $MonitoringRoute {
  const MonitoringRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const MonitoringScreen();
  }
}

/// PROFILE
class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const ProfileScreen();
  }
}

@TypedGoRoute<QrAmountScreenRoute>(path: '/qr-amount-screen')
class QrAmountScreenRoute extends GoRouteData with $QrAmountScreenRoute {
  final QrCheckResult qrCheckResult;

  const QrAmountScreenRoute({required this.qrCheckResult});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return QrAmounScreen(qrCheckResult: qrCheckResult);
  }
}

@TypedGoRoute<QrOtpScreenRoute>(path: '/qr-otp-screen')
class QrOtpScreenRoute extends GoRouteData with $QrOtpScreenRoute {
  final PaymentCreateResult paymentCreateResult;

  const QrOtpScreenRoute({required this.paymentCreateResult});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return QrOtpScreen(paymentCreateResult: paymentCreateResult);
  }
}

@TypedGoRoute<ChequesScreenRoute>(path: ChequeScreen.routeName)
class ChequesScreenRoute extends GoRouteData with $ChequesScreenRoute {
  final String extId;

  const ChequesScreenRoute({required this.extId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ChequeScreen(extId: extId,);
  }
}

@TypedGoRoute<BankLauncherScreenRoute>(path: BankLauncherScreen.routeName)
class BankLauncherScreenRoute extends GoRouteData with $BankLauncherScreenRoute {
  final TransferCreateSbpResult sbpQrResult;

  const BankLauncherScreenRoute({required this.sbpQrResult});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return BankLauncherScreen(sbpQrResult: sbpQrResult,);
  }
}