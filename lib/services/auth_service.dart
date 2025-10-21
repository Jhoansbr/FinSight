import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class AuthService {
  static const String baseUrl = 'https://finsight-m08s.onrender.com/api/usuarios';
  
  // Método para hacer login
  static Future<Map<String, dynamic>> login(String correo, String contrasena) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'correo': correo,
          'contrasena': contrasena,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        
        if (data['status'] == 'success') {
          return {
            'success': true,
            'usuario': Usuario.fromJson(data['usuario']),
            'message': 'Login exitoso',
          };
        } else {
          return {
            'success': false,
            'message': data['mensaje'] ?? 'Error en el login',
          };
        }
      } else {
        return {
          'success': false,
          'message': 'Error de conexión. Código: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: ${e.toString()}',
      };
    }
  }

  // Método para registrar usuario (opcional, para futuras implementaciones)
  static Future<Map<String, dynamic>> register(Usuario usuario) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(usuario.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return {
          'success': true,
          'message': 'Registro exitoso',
          'usuario': data['usuario'] != null ? Usuario.fromJson(data['usuario']) : null,
        };
      } else {
        return {
          'success': false,
          'message': 'Error en el registro. Código: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error de conexión: ${e.toString()}',
      };
    }
  }
}
