import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRemoteRepository {
  Future<void> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.5:8000/auth/signup"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'name': name, 'email': email, 'password': password}),
      );
      // 192.168.1.5
      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");
    } catch (e) {
      print("HTTP ERROR: $e");
      rethrow;
    }
  }

  Future<void> login({required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.5:8000/auth/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");
    } catch (e) {
      print("HTTP ERROR: $e");
      rethrow;
    }
  }
}
