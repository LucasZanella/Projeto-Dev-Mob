import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:frontend/models/password_model.dart';
import 'package:frontend/services/session_service.dart';

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

  static Future<void> deletePassword(String id) async {
    final token = await SessionService.getToken();

    final response = await http.delete(
      Uri.parse("$baseUrl/passwords/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Erro ao deletar senha");
    }
  }

  static Future<void> updatePassword(
    String id,
    String service,
    String login,
    String password,
  ) async {
    final token = await SessionService.getToken();

    final response = await http.put(
      Uri.parse("$baseUrl/passwords/$id"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "service": service,
        "login": login,
        "password": password,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception("Erro ao atualizar senha");
    }
  }

  static Future<void> createPassword(
    String service,
    String login,
    String password,
  ) async {
    final token = await SessionService.getToken();

    final response = await http.post(
      Uri.parse("$baseUrl/passwords/"),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({
        "service": service,
        "login": login,
        "password": password,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201 && response.statusCode != 204) {
      throw Exception("Erro ao criar senha");
    }
  }
}
