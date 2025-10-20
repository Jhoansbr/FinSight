import 'package:flutter/material.dart';
import 'Pages/Login/Login.dart';
import 'Pages/registration/registration_shell.dart';
import 'core/widgets/main_navigation.dart';
import 'core/theme/app_theme.dart';
import 'services/user_service.dart';

void main() {
  runApp(const FinSightApp());
}

class FinSightApp extends StatelessWidget {
  const FinSightApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinSight',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const LoginScreen(), // Pantalla de login por defecto
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationShell(),
        '/main': (context) => const MainNavigation(),
      },
    );
  }
}

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  bool _isLoading = true;
  bool _isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final isLoggedIn = await UserService.isLoggedIn();
    setState(() {
      _isLoggedIn = isLoggedIn;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return _isLoggedIn ? const MainNavigation() : const LoginScreen();
  }
}
