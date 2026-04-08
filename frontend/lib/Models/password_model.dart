class PasswordModel {

  final String id;
  final String service;
  final String login;
  final String password;
  final DateTime createdAt;
  final DateTime updatedAt;

  PasswordModel({
    required this.id,
    required this.service,
    required this.login,
    required this.password,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PasswordModel.fromJson(Map<String, dynamic> json) {
    return PasswordModel(
      id: json['_id'],
      service: json['service'],
      login: json['login'],
      password: json['password'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}