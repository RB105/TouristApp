// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $rootRoute,
  $loginScreenRoute,
  $otpScreenRoute,
  $registerScreenRoute,
  $pinCodeScreenRoute,
  $authRoute,
  $onBoardingRoute,
  $authWalletCreateRoute,
  $homeShellRoute,
  $qrAmountScreenRoute,
  $qrOtpScreenRoute,
  $amountScreenRoute,
  $sbpChequesScreenRoute,
  $bankLauncherScreenRoute,
];

RouteBase get $rootRoute =>
    GoRouteData.$route(path: '/', factory: $RootRoute._fromState);

mixin $RootRoute on GoRouteData {
  static RootRoute _fromState(GoRouterState state) => const RootRoute();

  @override
  String get location => GoRouteData.$location('/');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $loginScreenRoute =>
    GoRouteData.$route(path: '/login', factory: $LoginScreenRoute._fromState);

mixin $LoginScreenRoute on GoRouteData {
  static LoginScreenRoute _fromState(GoRouterState state) =>
      LoginScreenRoute(phoneNumber: state.uri.queryParameters['phone-number']!);

  LoginScreenRoute get _self => this as LoginScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/login',
    queryParams: {'phone-number': _self.phoneNumber},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $otpScreenRoute => GoRouteData.$route(
  path: '/auth-otp-screen',
  factory: $OtpScreenRoute._fromState,
);

mixin $OtpScreenRoute on GoRouteData {
  static OtpScreenRoute _fromState(GoRouterState state) => OtpScreenRoute(
    phoneNumber: state.uri.queryParameters['phone-number']!,
    reqId: state.uri.queryParameters['req-id'],
  );

  OtpScreenRoute get _self => this as OtpScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/auth-otp-screen',
    queryParams: {
      'phone-number': _self.phoneNumber,
      if (_self.reqId != null) 'req-id': _self.reqId,
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $registerScreenRoute => GoRouteData.$route(
  path: '/register-screen',
  factory: $RegisterScreenRoute._fromState,
);

mixin $RegisterScreenRoute on GoRouteData {
  static RegisterScreenRoute _fromState(GoRouterState state) =>
      RegisterScreenRoute(
        phoneNumber: state.uri.queryParameters['phone-number']!,
        secreyKey: state.uri.queryParameters['secrey-key']!,
        isForgot: _$convertMapValue(
          'is-forgot',
          state.uri.queryParameters,
          _$boolConverter,
        ),
      );

  RegisterScreenRoute get _self => this as RegisterScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/register-screen',
    queryParams: {
      'phone-number': _self.phoneNumber,
      'secrey-key': _self.secreyKey,
      if (_self.isForgot != null) 'is-forgot': _self.isForgot!.toString(),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

T? _$convertMapValue<T>(
  String key,
  Map<String, String> map,
  T? Function(String) converter,
) {
  final value = map[key];
  return value == null ? null : converter(value);
}

bool _$boolConverter(String value) {
  switch (value) {
    case 'true':
      return true;
    case 'false':
      return false;
    default:
      throw UnsupportedError('Cannot convert "$value" into a bool.');
  }
}

RouteBase get $pinCodeScreenRoute => GoRouteData.$route(
  path: '/pin_code',
  factory: $PinCodeScreenRoute._fromState,
);

mixin $PinCodeScreenRoute on GoRouteData {
  static PinCodeScreenRoute _fromState(GoRouterState state) =>
      PinCodeScreenRoute(
        initialStep: _$PinStepEnumMap._$fromName(
          state.uri.queryParameters['initial-step']!,
        )!,
      );

  PinCodeScreenRoute get _self => this as PinCodeScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/pin_code',
    queryParams: {'initial-step': _$PinStepEnumMap[_self.initialStep]},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

const _$PinStepEnumMap = {
  PinStep.set: 'set',
  PinStep.confirm: 'confirm',
  PinStep.unlock: 'unlock',
  PinStep.signIn: 'sign-in',
};

extension<T extends Enum> on Map<T, String> {
  T? _$fromName(String? value) =>
      entries.where((element) => element.value == value).firstOrNull?.key;
}

RouteBase get $authRoute =>
    GoRouteData.$route(path: '/auth', factory: $AuthRoute._fromState);

mixin $AuthRoute on GoRouteData {
  static AuthRoute _fromState(GoRouterState state) => const AuthRoute();

  @override
  String get location => GoRouteData.$location('/auth');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $onBoardingRoute => GoRouteData.$route(
  path: '/onboarding',
  factory: $OnBoardingRoute._fromState,
);

mixin $OnBoardingRoute on GoRouteData {
  static OnBoardingRoute _fromState(GoRouterState state) =>
      const OnBoardingRoute();

  @override
  String get location => GoRouteData.$location('/onboarding');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $authWalletCreateRoute => GoRouteData.$route(
  path: '/auth-wallet-create',
  factory: $AuthWalletCreateRoute._fromState,
);

mixin $AuthWalletCreateRoute on GoRouteData {
  static AuthWalletCreateRoute _fromState(GoRouterState state) =>
      const AuthWalletCreateRoute();

  @override
  String get location => GoRouteData.$location('/auth-wallet-create');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $homeShellRoute => StatefulShellRouteData.$route(
  factory: $HomeShellRouteExtension._fromState,
  branches: [
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/main',
          factory: $MainRoute._fromState,
          routes: [
            GoRouteData.$route(
              path: 'payments',
              factory: $PaymentsRoute._fromState,
            ),
          ],
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/chat', factory: $ChatRoute._fromState),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(
          path: '/monitoring',
          factory: $MonitoringRoute._fromState,
        ),
      ],
    ),
    StatefulShellBranchData.$branch(
      routes: [
        GoRouteData.$route(path: '/profile', factory: $ProfileRoute._fromState),
      ],
    ),
  ],
);

extension $HomeShellRouteExtension on HomeShellRoute {
  static HomeShellRoute _fromState(GoRouterState state) =>
      const HomeShellRoute();
}

mixin $MainRoute on GoRouteData {
  static MainRoute _fromState(GoRouterState state) => const MainRoute();

  @override
  String get location => GoRouteData.$location('/main');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $PaymentsRoute on GoRouteData {
  static PaymentsRoute _fromState(GoRouterState state) => const PaymentsRoute();

  @override
  String get location => GoRouteData.$location('/main/payments');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ChatRoute on GoRouteData {
  static ChatRoute _fromState(GoRouterState state) => const ChatRoute();

  @override
  String get location => GoRouteData.$location('/chat');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $MonitoringRoute on GoRouteData {
  static MonitoringRoute _fromState(GoRouterState state) =>
      const MonitoringRoute();

  @override
  String get location => GoRouteData.$location('/monitoring');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

mixin $ProfileRoute on GoRouteData {
  static ProfileRoute _fromState(GoRouterState state) => const ProfileRoute();

  @override
  String get location => GoRouteData.$location('/profile');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $qrAmountScreenRoute => GoRouteData.$route(
  path: '/qr-amount-screen',
  factory: $QrAmountScreenRoute._fromState,
);

mixin $QrAmountScreenRoute on GoRouteData {
  static QrAmountScreenRoute _fromState(GoRouterState state) =>
      QrAmountScreenRoute(
        qrCheckResult: (String json0) {
          return QrCheckResult.fromJson(
            jsonDecode(json0) as Map<String, dynamic>,
          );
        }(state.uri.queryParameters['qr-check-result']!),
      );

  QrAmountScreenRoute get _self => this as QrAmountScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/qr-amount-screen',
    queryParams: {'qr-check-result': jsonEncode(_self.qrCheckResult.toJson())},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $qrOtpScreenRoute => GoRouteData.$route(
  path: '/qr-otp-screen',
  factory: $QrOtpScreenRoute._fromState,
);

mixin $QrOtpScreenRoute on GoRouteData {
  static QrOtpScreenRoute _fromState(GoRouterState state) => QrOtpScreenRoute(
    paymentCreateResult: (String json0) {
      return PaymentCreateResult.fromJson(
        jsonDecode(json0) as Map<String, dynamic>,
      );
    }(state.uri.queryParameters['payment-create-result']!),
  );

  QrOtpScreenRoute get _self => this as QrOtpScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/qr-otp-screen',
    queryParams: {
      'payment-create-result': jsonEncode(_self.paymentCreateResult.toJson()),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $amountScreenRoute => GoRouteData.$route(
  path: '/amount-screen',
  factory: $AmountScreenRoute._fromState,
);

mixin $AmountScreenRoute on GoRouteData {
  static AmountScreenRoute _fromState(GoRouterState state) =>
      const AmountScreenRoute();

  @override
  String get location => GoRouteData.$location('/amount-screen');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $sbpChequesScreenRoute => GoRouteData.$route(
  path: '/sbp-cheque',
  factory: $SbpChequesScreenRoute._fromState,
);

mixin $SbpChequesScreenRoute on GoRouteData {
  static SbpChequesScreenRoute _fromState(GoRouterState state) =>
      SbpChequesScreenRoute(
        extId: state.uri.queryParameters['ext-id'],
        monitoringItem: _$convertMapValue(
          'monitoring-item',
          state.uri.queryParameters,
          (String json0) {
            return MonitoringHistory.fromJson(
              jsonDecode(json0) as Map<String, dynamic>,
            );
          },
        ),
      );

  SbpChequesScreenRoute get _self => this as SbpChequesScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/sbp-cheque',
    queryParams: {
      if (_self.extId != null) 'ext-id': _self.extId,
      if (_self.monitoringItem != null)
        'monitoring-item': jsonEncode(_self.monitoringItem!.toJson()),
    },
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $bankLauncherScreenRoute => GoRouteData.$route(
  path: '/bankLauncher',
  factory: $BankLauncherScreenRoute._fromState,
);

mixin $BankLauncherScreenRoute on GoRouteData {
  static BankLauncherScreenRoute _fromState(GoRouterState state) =>
      BankLauncherScreenRoute(
        sbpQrResult: (String json0) {
          return TransferCreateSbpResult.fromJson(
            jsonDecode(json0) as Map<String, dynamic>,
          );
        }(state.uri.queryParameters['sbp-qr-result']!),
      );

  BankLauncherScreenRoute get _self => this as BankLauncherScreenRoute;

  @override
  String get location => GoRouteData.$location(
    '/bankLauncher',
    queryParams: {'sbp-qr-result': jsonEncode(_self.sbpQrResult.toJson())},
  );

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
