import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/Models/password_model.dart';
import 'package:frontend/Services/session_service.dart';

class PasswordService {

  static const baseUrl = "https://projeto-dev-mob.onrender.com";

  static Future<List<PasswordModel>> getPasswords() async {

    final token = await SessionService.getToken();

    final response = await http.get(
      Uri.parse("$baseUrl/passwords"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode == 200) {

      final List data = jsonDecode(response.body);

      return data.map((item) => PasswordModel.fromJson(item)).toList();
    }

    throw Exception("Erro ao buscar senhas");
  }
}