/* March 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart' show GetStorage;
import 'package:go_router/go_router.dart';
import 'package:touristapp/ui/auth/view/screens/auth_screen.dart';
import 'package:touristapp/ui/auth/view/screens/login_screen.dart';
import 'package:touristapp/ui/auth/view/screens/pin_code_screen.dart';
import 'package:touristapp/ui/home/chat/chat_screen.dart';
import 'package:touristapp/ui/home/home_screen.dart';
import 'package:touristapp/ui/home/main/logic/model/payment_create_result.dart';
import 'package:touristapp/ui/home/main/logic/model/qr_check_result.dart'
    show QrCheckResult;
import 'package:touristapp/ui/home/main/ui/main_screen.dart';
import 'package:touristapp/ui/home/main/ui/payments_screen.dart';
import 'package:touristapp/ui/home/main/ui/screens/top_up/amount_screen.dart';
import 'package:touristapp/ui/home/main/ui/screens/top_up/bank_launcher_screen.dart';
import 'package:touristapp/ui/home/main/ui/screens/top_up/sbp_cheque_screen.dart';
import 'package:touristapp/ui/home/monitoring/logic/model/monitoring_result.dart';
import 'package:touristapp/ui/home/monitoring/ui/cheque_screen.dart';
import 'package:touristapp/ui/home/monitoring/ui/monitoring_screen.dart';
import 'package:touristapp/ui/home/profile/profile_screen.dart';
import 'package:touristapp/ui/splash/on_boarding_screen.dart';

import '../../ui/auth/view/screens/auth_wallet_create.dart'
    show AuthWalletCreate;
import '../../ui/auth/view/screens/otp_screen.dart' show OtpScreen;
import '../../ui/auth/view/screens/register_screen.dart' show RegisterScreen;
import '../../ui/home/main/logic/model/transfer_create_sbp_result.dart'
    show TransferCreateSbpResult;
import '../../ui/home/main/ui/screens/qr/qr_amoun_screen.dart'
    show QrAmounScreen;
import '../../ui/home/main/ui/screens/qr/qr_otp_screen.dart' show QrOtpScreen;
import '../di/di.dart' show getIt;

part 'app_router.g.dart';

@TypedGoRoute<RootRoute>(path: '/')
class RootRoute extends GoRouteData with $RootRoute {
  const RootRoute();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    final box = getIt<GetStorage>();
    final firstLaunch = box.read<bool?>('first_launch');
    final access = box.read<String?>('access_token');
    final savedPin = box.read(PinCodeScreen.pinKey);

    if (firstLaunch ?? true) {
      debugPrint(firstLaunch.toString());
      return const OnBoardingRoute().location;
    }

    if (access == null) {
      debugPrint(access);
      // return const AuthWalletCreateRoute().location;
      return const AuthRoute().location;
    }

    if (savedPin == null) {
      // First time PIN setup
      return const PinCodeScreenRoute(initialStep: PinStep.set).location;
    }

    return const PinCodeScreenRoute(initialStep: PinStep.signIn).location;
  }

  @override
  Widget build(BuildContext context, GoRouterState state) => const SizedBox(); // never shown
}

@TypedGoRoute<LoginScreenRoute>(path: LoginScreen.routeName)
class LoginScreenRoute extends GoRouteData with $LoginScreenRoute {
  final String phoneNumber;

  const LoginScreenRoute({required this.phoneNumber});

  @override
  Widget build(BuildContext context, GoRouterState state) => LoginScreen(phoneNumber: phoneNumber);
}

@TypedGoRoute<OtpScreenRoute>(path: OtpScreen.routeName)
class OtpScreenRoute extends GoRouteData with $OtpScreenRoute {
  final String phoneNumber;
  final String? reqId;

  const OtpScreenRoute({required this.phoneNumber, this.reqId});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return OtpScreen(phoneNumber: phoneNumber,reqId: reqId,);
  }
}

@TypedGoRoute<RegisterScreenRoute>(path: RegisterScreen.routeName)
class RegisterScreenRoute extends GoRouteData with $RegisterScreenRoute {
  final String phoneNumber;
  final String secreyKey;
  final bool? isForgot;

  const RegisterScreenRoute({required this.phoneNumber, required this.secreyKey, this.isForgot});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RegisterScreen(phoneNumber: phoneNumber,secretKey: secreyKey, isForgot: isForgot);
  }
}

@TypedGoRoute<PinCodeScreenRoute>(path: PinCodeScreen.routeName)
class PinCodeScreenRoute extends GoRouteData with $PinCodeScreenRoute {
  final PinStep initialStep;

  const PinCodeScreenRoute({required this.initialStep});

  @override
  Page<void> buildPage(BuildContext context, GoRouterState state) {
    final child = PinCodeScreen(initialStep: initialStep);

    if (initialStep == .unlock) {
      // 🔥 bottom-up animation
      return CustomTransitionPage(
        key: state.pageKey,
        fullscreenDialog: true,
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curved = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );

          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          );
        },
      );
    }

    // 👇 default navigation (material / cupertino)
    return MaterialPage(key: state.pageKey, child: child);
  }
}

/// LOGIN
@TypedGoRoute<AuthRoute>(path: '/auth')
class AuthRoute extends GoRouteData with $AuthRoute {
  const AuthRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AuthScreen();
}

@TypedGoRoute<OnBoardingRoute>(path: '/onboarding')
class OnBoardingRoute extends GoRouteData with $OnBoardingRoute {
  const OnBoardingRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const OnBoardingScreen();
}

@TypedGoRoute<AuthWalletCreateRoute>(path: '/auth-wallet-create')
class AuthWalletCreateRoute extends GoRouteData with $AuthWalletCreateRoute {
  const AuthWalletCreateRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const AuthWalletCreate();
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
  ) => HomeScreen(shell: navigationShell);
}

/// MAIN TAB
class MainRoute extends GoRouteData with $MainRoute {
  const MainRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const MainScreen();
}

/// PAYMENTS
class PaymentsRoute extends GoRouteData with $PaymentsRoute {
  const PaymentsRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => PaymentsScreen();
}

/// CHAT
class ChatRoute extends GoRouteData with $ChatRoute {
  const ChatRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => const ChatScreen();
}

/// MONITORING
class MonitoringRoute extends GoRouteData with $MonitoringRoute {
  const MonitoringRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const MonitoringScreen();
}

/// PROFILE
class ProfileRoute extends GoRouteData with $ProfileRoute {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfileScreen();
}

@TypedGoRoute<QrAmountScreenRoute>(path: '/qr-amount-screen')
class QrAmountScreenRoute extends GoRouteData with $QrAmountScreenRoute {
  final QrCheckResult qrCheckResult;

  const QrAmountScreenRoute({required this.qrCheckResult});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      QrAmounScreen(qrCheckResult: qrCheckResult);
}

@TypedGoRoute<QrOtpScreenRoute>(path: '/qr-otp-screen')
class QrOtpScreenRoute extends GoRouteData with $QrOtpScreenRoute {
  final PaymentCreateResult paymentCreateResult;

  const QrOtpScreenRoute({required this.paymentCreateResult});

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      QrOtpScreen(paymentCreateResult: paymentCreateResult);
}

@TypedGoRoute<AmountScreenRoute>(path: AmountScreen.routeName)
class AmountScreenRoute extends GoRouteData with $AmountScreenRoute {
  const AmountScreenRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) => AmountScreen();
}

@TypedGoRoute<SbpChequesScreenRoute>(path: SbpChequeScreen.routeName)
class SbpChequesScreenRoute extends GoRouteData with $SbpChequesScreenRoute {
  final MonitoringHistory? monitoringItem;
  final String? extId;

  const SbpChequesScreenRoute({this.extId, this.monitoringItem});

  @override
  Page<void> buildPage(
    BuildContext context,
    GoRouterState state,
  ) => CustomTransitionPage(
    key: state.pageKey,
    opaque: true,
    child: ChequeScreen(extId: extId, item: monitoringItem),
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 1), // 👈 from bottom
            end: Offset.zero,
          ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        ),
  );
}

@TypedGoRoute<BankLauncherScreenRoute>(path: BankLauncherScreen.routeName)
class BankLauncherScreenRoute extends GoRouteData
    with $BankLauncherScreenRoute {
  final TransferCreateSbpResult sbpQrResult;

  const BankLauncherScreenRoute({required this.sbpQrResult});

  @override
  Widget build(BuildContext context, GoRouterState state) => BankLauncherScreen(sbpQrResult: sbpQrResult);
}
