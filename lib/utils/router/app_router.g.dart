// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_router.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
  $rootRoute,
  $authRoute,
  $onBoardingRoute,
  $authWalletCreateRoute,
  $homeShellRoute,
  $qrAmountScreenRoute,
  $qrOtpScreenRoute,
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
