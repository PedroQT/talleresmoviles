import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  static const String baseUrl = 'https://parking.visiontic.com.co/api';
  static const _secureStorage = FlutterSecureStorage();

  // Registro de usuario
  Future<Map<String, dynamic>> register(String name, String email, String password) async {
    final url = Uri.parse('$baseUrl/users');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    print('Respuesta registro: ${response.body}');
    return jsonDecode(response.body);
  }

  // Login y almacenamiento de datos
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'accept': '*/*',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    final data = jsonDecode(response.body);
    print('Respuesta login: $data');
    if (data['success'] == true) {
      // Guardar datos no sensibles
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', data['user']['name']);
      await prefs.setString('email', data['user']['email']);
      print('Guardado en shared_preferences: name=${data['user']['name']}, email=${data['user']['email']}');
      // Guardar token sensible
      await _secureStorage.write(key: 'access_token', value: data['token']);
      print('Guardado en flutter_secure_storage: access_token=${data['token']}');
    }
    return data;
  }

  // Obtener datos no sensibles
  Future<Map<String, String?>> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'name': prefs.getString('name'),
      'email': prefs.getString('email'),
    };
  }

  // Verificar si hay token
  Future<bool> hasToken() async {
    final token = await _secureStorage.read(key: 'access_token');
    return token != null && token.isNotEmpty;
  }

  // Cerrar sesión
  Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('name');
  await prefs.remove('email');
  await _secureStorage.delete(key: 'access_token');
  print('Datos eliminados de shared_preferences y flutter_secure_storage al cerrar sesión');
  }
}
