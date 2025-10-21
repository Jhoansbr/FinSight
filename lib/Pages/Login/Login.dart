import 'package:flutter/material.dart';
import '../registration/registration_shell.dart';
import '../../core/widgets/main_navigation.dart';
import '../../services/auth_service.dart';
import '../../services/user_service.dart';
import '../../services/biometric_service.dart';
import '../../services/biometric_settings_service.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _rememberMe = false;
  String? _errorMessage;
  bool _biometricAvailable = false;
  bool _biometricEnrolled = false;
  bool _hasUserSaved = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkBiometricAvailability();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _checkBiometricAvailability() async {
    final isAvailable = await BiometricService.isBiometricAvailable();
    final isEnrolled = await BiometricService.hasBiometricEnrolled();
    final user = await UserService.getCurrentUser();
    final hasUser = user != null;
    final isEnabled = await BiometricSettingsService.isBiometricEnabled();
    
    // Debug: Imprimir información del usuario
    if (user != null) {
      print('Usuario guardado encontrado: ${user.nombreCompleto}');
    } else {
      print('No se encontró usuario guardado');
    }
    
    print('Biométrica disponible: $isAvailable, Configurada: $isEnrolled, Habilitada: $isEnabled');
    
    setState(() {
      _biometricAvailable = isAvailable;
      _biometricEnrolled = isEnrolled;
      _hasUserSaved = hasUser;
      _biometricEnabled = isEnabled;
    });
  }

  Future<void> _handleBiometricLogin() async {
    if (!_biometricAvailable || !_biometricEnrolled) {
      setState(() {
        _errorMessage = 'La autenticación biométrica no está disponible o configurada';
      });
      return;
    }

    if (!_biometricEnabled) {
      setState(() {
        _errorMessage = 'La autenticación biométrica está deshabilitada en la configuración';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await BiometricService.authenticateWithBiometrics(
        reason: 'Autentícate para acceder a FinSight',
      );

      if (result.success) {
        // Verificar usuario guardado DESPUÉS de la autenticación biométrica exitosa
        final user = await UserService.getCurrentUser();
        print('Autenticación biométrica exitosa. Verificando usuario...');
        
        if (user != null) {
          print('Usuario encontrado: ${user.nombreCompleto}. Navegando al dashboard...');
          // Navegar directamente al dashboard
          if (mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MainNavigation()),
            );
          }
        } else {
          print('ERROR: No se encontró usuario guardado después de autenticación biométrica exitosa');
          setState(() {
            _errorMessage = 'No se encontró información de usuario. Inicia sesión con email y contraseña primero';
          });
        }
      } else {
        setState(() {
          _errorMessage = result.errorMessage ?? 'Error en la autenticación biométrica';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error inesperado: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _handleLogin() async {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Por favor, completa todos los campos';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await AuthService.login(
        _emailController.text.trim(),
        _passwordController.text,
      );

      if (result['success']) {
        // Guardar usuario en SharedPreferences
        await UserService.saveUser(result['usuario']);
        
        // Actualizar estado para mostrar botón biométrico en futuros logins
        setState(() {
          _hasUserSaved = true;
        });
        
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const MainNavigation(),
            ),
          );
        }
      } else {
        setState(() {
          _errorMessage = result['message'];
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error inesperado: ${e.toString()}';
      });
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight:
            MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                MediaQuery.of(context).padding.bottom,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Logo (ajustado a un tamaño más pequeño)
              Image.asset(
                "assets/images/logo.png",
                width: MediaQuery.of(context).size.width * 0.3,
                height: 100,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),

              const Text(
                "FinSight",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              const Text(
                "Bienvenido de vuelta a tu visión financiera",
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Colors.black54),
              ),
              const SizedBox(height: 30),

              // Email
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Correo electrónico",
                  prefixIcon: const Icon(Icons.email_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Contraseña",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Recordarme & Recuperar - CORREGIDO PARA EVITAR OVERFLOW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: _rememberMe, 
                          onChanged: (v) {
                            setState(() {
                              _rememberMe = v ?? false;
                            });
                          }
                        ),
                        const Flexible(
                          child: Text(
                            "Recordarme",
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: TextButton(
                      onPressed: () {},
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                      ),
                      child: const Text(
                        "¿Olvidaste tu contraseña?",
                        style: TextStyle(fontSize: 13),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Mensaje de error
              if (_errorMessage != null) ...[
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.red[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red[200]!),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline, color: Colors.red[600], size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: TextStyle(
                            color: Colors.red[600],
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Botón iniciar sesión
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: _isLoading ? null : _handleLogin,
                  child: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Text(
                          "Iniciar Sesión",
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                ),
              ),
              const SizedBox(height: 16),

              // Usar huella digital
              if (_biometricAvailable && _biometricEnrolled && _hasUserSaved && _biometricEnabled)
                OutlinedButton.icon(
                  icon: const Icon(Icons.fingerprint),
                  label: const Text("Usar huella dactilar"),
                  onPressed: _isLoading ? null : _handleBiometricLogin,
                ),
              const SizedBox(height: 20),

              // Redes sociales - CORREGIDO PARA EVITAR OVERFLOW
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: IconButton(
                      onPressed: () {},
                      icon: Image.asset(
                        'assets/images/lgoogle.png', // Ruta de tu imagen
                        width: 36,
                        height: 36,
                      ),
                      padding: const EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),

              // Registro - CORREGIDO PARA EVITAR OVERFLOW
              Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Text("¿No tienes una cuenta? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegistrationShell(),
                        ),
                      );
                    },
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                    ),
                    child: const Text("Regístrate gratis"),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}