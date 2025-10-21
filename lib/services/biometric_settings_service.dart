import 'package:shared_preferences/shared_preferences.dart';

class BiometricSettingsService {
  static const String _biometricEnabledKey = 'biometric_auth_enabled';

  /// Verificar si la autenticación biométrica está habilitada en la configuración
  static Future<bool> isBiometricEnabled() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_biometricEnabledKey) ?? false;
  }

  /// Habilitar la autenticación biométrica
  static Future<void> enableBiometric() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, true);
  }

  /// Deshabilitar la autenticación biométrica
  static Future<void> disableBiometric() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_biometricEnabledKey, false);
  }

  /// Cambiar el estado de la autenticación biométrica
  static Future<void> toggleBiometric(bool enabled) async {
    if (enabled) {
      await enableBiometric();
    } else {
      await disableBiometric();
    }
  }
}
