import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const _baseUrl = 'https://api.escuelajs.co/api/v1';

  // ---------- LOGIN ----------
  static Future<void> login({
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', data['access_token']);
      await prefs.setString('refresh_token', data['refresh_token']);
    } else {
      throw Exception('Invalid email or password');
    }
  }

  // ---------- REGISTER ----------
  static Future<void> register({
    required String name,
    required String email,
    required String password,
    required String avatar,
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/users/'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
        'avatar': avatar,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Registration failed');
    }

    // auto login after register
    await login(email: email, password: password);
  }

  // ---------- PROFILE ----------
  static Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('No access token');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/auth/profile'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Unauthorized');
    }
  }

  // ---------- LOGOUT ----------
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
