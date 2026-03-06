/// API Endpoints
class Endpoints {
  // Authentication endpoints
  static const String register = '/v1/auth/register/';
  static const String confirmOtp = '/v1/auth/check/register/verify/';
  static const String setPassword = '/v1/auth/set/password/';
  static const String login = '/v1/auth/login/';

  static const String refreshToken = '/v1/auth/refresh/token/';

  // QR code endpoints
  static const String checkQr = '/v1/qr/check';
  static const String createPayment = '/v1/qr/wallet/pay-out/create/transaction/';
  static const String checkConfirm = '/v1/qr/confirm/';

  // Wallet endpoints
  static const String createWallet = '/v1/wallet/create/';

  // Home details endpoint
  static const String homeDetails = '/v1/user/index/';

}

