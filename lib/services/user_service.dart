import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/usuario.dart';

class UserService {
  static const String _userKey = 'current_user';
  
  // Guardar usuario en SharedPreferences
  static Future<void> saveUser(Usuario usuario) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(usuario.toJson());
    await prefs.setString(_userKey, userJson);
  }
  
  // Obtener usuario guardado
  static Future<Usuario?> getCurrentUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString(_userKey);
    
    if (userJson != null) {
      final userMap = jsonDecode(userJson);
      return Usuario.fromJson(userMap);
    }
    
    return null;
  }
  
  // Verificar si hay un usuario logueado
  static Future<bool> isLoggedIn() async {
    final user = await getCurrentUser();
    return user != null;
  }
  
  // Cerrar sesión
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }
}
