/// API Endpoints
class Endpoints {
  // Authentication endpoints
  static const String register = '/v1/auth/register/';
  static const String confirmOtp = '/v1/auth/check/register/verify/';
  static const String setPassword = '/v1/auth/set/password/';

  static const String refreshToken = '/v1/auth/refresh/token/';

  // QR code endpoints
  static const String checkQr = '/v1/qr/check';

  // Wallet endpoints
  static const String createWallet = '/v1/wallet/create/';
}

