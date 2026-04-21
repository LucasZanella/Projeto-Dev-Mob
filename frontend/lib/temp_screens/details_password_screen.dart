import 'package:flutter/material.dart';
import 'package:frontend/widgets/navbar.dart';
import 'package:frontend/widgets/password_textfield.dart';
import 'package:frontend/models/password_model.dart';
import 'package:frontend/services/password_service.dart';
import 'package:frontend/widgets/snackbar.dart';

class DetailsPasswordScreen extends StatefulWidget {
  final PasswordModel password;

  const DetailsPasswordScreen({
    super.key,
    required this.password,
  });

  @override
  State<DetailsPasswordScreen> createState() => _DetailsPasswordScreenState();
}

class _DetailsPasswordScreenState extends State<DetailsPasswordScreen> {

  late TextEditingController serviceController;
  late TextEditingController loginController;
  late TextEditingController passwordController;
  late PasswordModel password;

  bool _showSensitiveData = false;

  @override
  void initState() {
    super.initState();

    password = widget.password;

    serviceController = TextEditingController(text: password.service);
    loginController = TextEditingController(text: password.login);
    passwordController = TextEditingController(text: password.password);
  }

  void toggleVisibility() {
    setState(() {
      _showSensitiveData = !_showSensitiveData;
    });
  }

  bool neverUpdated(DateTime created, DateTime? updated) {
    if (updated == null) return true;
    return updated.difference(created).inSeconds == 0;
  }

  Future<void> reloadPassword() async {
    try {
      final list = await PasswordService.getPasswords();

      final updatedPassword = list.firstWhere(
        (p) => p.id == password.id,
      );

      setState(() {
        password = updatedPassword;

        serviceController.text = password.service;
        loginController.text = password.login;
        passwordController.text = password.password;
      });

    } catch (e) {
      Snackbar.show(
        context,
        icon: Icons.error,
        color: Colors.red,
        message: "Erro ao carregar os dados!",
      );
    }
  }

  Future<void> goToEdit() async {
    final updated = await Navigator.pushNamed(
      context,
      "/editPassword",
      arguments: password,
    );

    if (updated == true) {
      await reloadPassword();
    }
  }

  void confirmDeletePassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 30, 30, 30),
          title: const Text(
            "Confirmar exclusão",
            style: TextStyle(color: Colors.white),
          ),
          content: const Text(
            "Tem certeza que deseja excluir esta senha?",
            style: TextStyle(color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancelar",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                deletePassword();
              },
              child: const Text(
                "Excluir",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void deletePassword() async {
    try {
      await PasswordService.deletePassword(password.id); // ✅ corrigido

      if (!mounted) return;

      Snackbar.show(
        context,
        icon: Icons.check_circle,
        color: Colors.green,
        message: "Senha removida!",
      );

      Navigator.pop(context, true);

    } catch (e) {
      Snackbar.show(
        context,
        icon: Icons.error,
        color: Colors.red,
        message: "Erro ao remover a senha!",
      );
    }
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} "
        "${_monthName(date.month)} "
        "${date.year}";
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan','Fev','Mar','Abr','Mai','Jun',
      'Jul','Ago','Set','Out','Nov','Dez'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {

    final password = this.password; // ✅ CORREÇÃO PRINCIPAL

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 18),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 28),

              const Center(
                child: Text(
                  "Detalhes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Divider(
                color: Colors.white12,
                thickness: 1,
              ),

              const SizedBox(height: 25),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 30, 30, 30),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  children: [

                    PasswordTextField(
                      label: "Nome do serviço",
                      controller: serviceController,
                      readOnly: true,
                    ),

                    const SizedBox(height: 18),

                    PasswordTextField(
                      label: "Usuário / Login",
                      controller: loginController,
                      readOnly: true,
                      obscureText: !_showSensitiveData,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showSensitiveData
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: toggleVisibility,
                      ),
                    ),

                    const SizedBox(height: 18),

                    PasswordTextField(
                      label: "Senha",
                      controller: passwordController,
                      readOnly: true,
                      obscureText: !_showSensitiveData,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showSensitiveData
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: toggleVisibility,
                      ),
                    ),

                    const SizedBox(height: 28),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Data de Criação",
                              style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              formatDate(password.createdAt),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Data de alteração",
                              style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              neverUpdated(password.createdAt, password.updatedAt)
                                  ? "Nunca"
                                  : formatDate(password.updatedAt!),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: NavBar(
        icons: [Icons.arrow_back, Icons.edit, Icons.delete],
        actions: [
          () => Navigator.pop(context, true),
          () => goToEdit(),
          () => confirmDeletePassword(),
        ],
        colors: [Colors.blue, Colors.amber, Colors.red],
      ),
    );
  }
}