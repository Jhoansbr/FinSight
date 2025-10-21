import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiometricService {
  static final LocalAuthentication _localAuth = LocalAuthentication();

  /// Verifica si el dispositivo soporta autenticación biométrica
  static Future<bool> isBiometricAvailable() async {
    try {
      final bool isAvailable = await _localAuth.canCheckBiometrics;
      final bool isDeviceSupported = await _localAuth.isDeviceSupported();
      
      return isAvailable && isDeviceSupported;
    } catch (e) {
      debugPrint('Error checking biometric availability: $e');
      return false;
    }
  }

  /// Obtiene los tipos de autenticación biométrica disponibles
  static Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      return await _localAuth.getAvailableBiometrics();
    } catch (e) {
      debugPrint('Error getting available biometrics: $e');
      return [];
    }
  }

  /// Autentica al usuario usando biometría
  static Future<BiometricResult> authenticateWithBiometrics({
    String reason = 'Autenticación requerida',
    String cancelButton = 'Cancelar',
    String goToSettingsButton = 'Configuración',
    String goToSettingsDescription = 'Por favor configure la autenticación biométrica en la configuración del dispositivo',
  }) async {
    try {
      // Verificar si la biometría está disponible
      final bool isAvailable = await isBiometricAvailable();
      if (!isAvailable) {
        return BiometricResult(
          success: false,
          errorMessage: 'La autenticación biométrica no está disponible en este dispositivo',
        );
      }

      // Obtener tipos de biometría disponibles
      final List<BiometricType> availableBiometrics = await getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        return BiometricResult(
          success: false,
          errorMessage: 'No hay métodos de autenticación biométrica configurados',
        );
      }

      // Realizar autenticación
      final bool didAuthenticate = await _localAuth.authenticate(
        localizedReason: reason,
        options: const AuthenticationOptions(
          biometricOnly: false,
          stickyAuth: true,
          sensitiveTransaction: true,
        ),
      );

      if (didAuthenticate) {
        return BiometricResult(
          success: true,
          biometricType: availableBiometrics.first,
        );
      } else {
        return BiometricResult(
          success: false,
          errorMessage: 'Autenticación cancelada por el usuario',
        );
      }
    } on PlatformException catch (e) {
      String errorMessage = 'Error de autenticación biométrica';
      
      switch (e.code) {
        case auth_error.notAvailable:
          errorMessage = 'La autenticación biométrica no está disponible';
          break;
        case auth_error.notEnrolled:
          errorMessage = 'No hay huellas dactilares registradas. Configure la autenticación biométrica en la configuración del dispositivo';
          break;
        case auth_error.lockedOut:
          errorMessage = 'La autenticación biométrica está bloqueada temporalmente';
          break;
        case auth_error.permanentlyLockedOut:
          errorMessage = 'La autenticación biométrica está bloqueada permanentemente. Use su contraseña del dispositivo';
          break;
        case auth_error.biometricOnlyNotSupported:
          errorMessage = 'Solo se permite autenticación biométrica';
          break;
        default:
          errorMessage = 'Error de autenticación: ${e.message}';
      }

      return BiometricResult(
        success: false,
        errorMessage: errorMessage,
      );
    } catch (e) {
      return BiometricResult(
        success: false,
        errorMessage: 'Error inesperado: $e',
      );
    }
  }

  /// Obtiene un mensaje amigable para el tipo de biometría
  static String getBiometricTypeName(BiometricType type) {
    switch (type) {
      case BiometricType.fingerprint:
        return 'Huella dactilar';
      case BiometricType.face:
        return 'Reconocimiento facial';
      case BiometricType.iris:
        return 'Reconocimiento de iris';
      case BiometricType.strong:
        return 'Autenticación fuerte';
      case BiometricType.weak:
        return 'Autenticación débil';
    }
  }

  /// Verifica si el usuario tiene configurada la autenticación biométrica
  static Future<bool> hasBiometricEnrolled() async {
    try {
      final List<BiometricType> availableBiometrics = await getAvailableBiometrics();
      return availableBiometrics.isNotEmpty;
    } catch (e) {
      debugPrint('Error checking biometric enrollment: $e');
      return false;
    }
  }
}

/// Clase para manejar el resultado de la autenticación biométrica
class BiometricResult {
  final bool success;
  final String? errorMessage;
  final BiometricType? biometricType;

  BiometricResult({
    required this.success,
    this.errorMessage,
    this.biometricType,
  });
}
