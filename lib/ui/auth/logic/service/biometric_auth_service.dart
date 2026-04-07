/* April 2026 , Baxrom Rajabov, Tashkent , Uzbekistan */

import 'package:local_auth/local_auth.dart';

class BiometricAuthService {
  final LocalAuthentication _auth = LocalAuthentication();

  Future<bool> canCheckBiometrics() async {
    try {
      return await _hasPermission() && await _auth.canCheckBiometrics &&
          await _auth.isDeviceSupported();
    } catch (e) {
      return false;
    }
  }

  Future<bool> _hasPermission() async {
    try {
      final availableBiometrics = await _auth.getAvailableBiometrics();

      return availableBiometrics.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<bool> authenticate() async {
    try {
      final isAvailable = await canCheckBiometrics();
      if (!isAvailable) return false;

      return await _auth.authenticate(
        localizedReason: 'Authenticate to unlock your app',
      );
    } catch (e) {
      return false;
    }
  }
}
