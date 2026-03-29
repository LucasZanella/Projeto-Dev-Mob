import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/Models/user_model.dart';

class AuthService {

  static const baseUrl = "http://localhost:8000";

  static Future<Map<String, dynamic>> login(String email, String password) async {

    LoginModel loginUser = LoginModel(
      email: email,
      password: password,
    );

    final response = await http.post(
      Uri.parse("$baseUrl/login"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(loginUser.toJson()),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return {
        "success": true,
        "message": data["message"] ?? "Login realizado com sucesso"
      };
    }

    return {
      "success": false,
      "message": data["detail"] ?? "Erro ao fazer login"
    };
  }

  static Future<Map<String, dynamic>> register(String name, String email, String password) async {

    RegisterModel registerUser = RegisterModel(
      name: name,
      email: email,
      password: password,
    );

    final response = await http.post(
      Uri.parse("$baseUrl/register"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(registerUser.toJson()),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 201) {
      return {
        "success": true,
        "message": data["message"] ?? "Registro realizado"
      };
    }

    return {
      "success": false,
      "message": data["detail"] ?? "Não foi pessível registrar-se"
    };
  }
}