import 'dart:io';
import 'package:client/failure/failure.dart';
import 'package:client/features/auth/model/user_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthRemoteRepository {
  Future<Either<AppFailure, UserModel>> signup({
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
      final resBodyMap = jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode != 201) {
        return Left(AppFailure(resBodyMap['detail']));
      }
      return Right(UserModel(name: name, email: email, id: resBodyMap['id']));
    } catch (e) {
      print("HTTP ERROR: $e");
      return Left(AppFailure(e.toString()));
    }
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse("http://192.168.1.5:8000/auth/login"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );
      if (response.statusCode != 201) {
        throw '';
      }
      final user = jsonDecode(response.body) as Map<String, dynamic>;
      return user;
    } catch (e) {
      print("HTTP ERROR: $e");
      rethrow;
    }
  }
}
