import 'package:flutter/material.dart';
import 'package:frontend/widgets/navbar.dart';
import 'package:frontend/models/password_model.dart';
import 'package:frontend/services/password_service.dart';
import 'package:frontend/widgets/password_textfield.dart';
import 'package:frontend/widgets/password_generator.dart';
import 'package:frontend/widgets/snackbar.dart';

class EditPasswordScreen extends StatefulWidget {
  final PasswordModel password;

  const EditPasswordScreen({super.key, required this.password});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreen();
}

class _EditPasswordScreen extends State<EditPasswordScreen> {
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  String keepOldIfEmpty(String newValue, String oldValue) {
    return newValue.trim().isEmpty ? oldValue : newValue;
  }

  @override
  void initState() {
    super.initState();

    serviceController.text = widget.password.service;
    loginController.text = widget.password.login;
  }

  Future<void> updatePassword() async {
    if (isLoading) return;

    final newService = keepOldIfEmpty(
      serviceController.text,
      widget.password.service,
    );

    final newLogin = keepOldIfEmpty(
      loginController.text,
      widget.password.login,
    );

    final newPassword = keepOldIfEmpty(
      passwordController.text,
      widget.password.password,
    );

    final didChange =
        newService != widget.password.service ||
        newLogin != widget.password.login ||
        newPassword != widget.password.password;

    if (!didChange) {
      Navigator.pop(context, false);
      return;
    }

    setState(() => isLoading = true);

    try {
      await PasswordService.updatePassword(
        widget.password.id,
        newService,
        newLogin,
        newPassword,
      );

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      Snackbar.show(
        context,
        icon: Icons.error,
        color: Colors.red,
        message: "Erro ao atualizar a senha!",
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 18),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Text(
              "Alterar senha",
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            PasswordTextField(
              label: "Nome do serviço",
              controller: serviceController,
            ),

            const SizedBox(height: 16),

            PasswordTextField(
              label: "Usuário / Email / Login",
              controller: loginController,
            ),

            const SizedBox(height: 16),

            PasswordGenerator(controller: passwordController),
          ],
        ),
      ),

      bottomNavigationBar: NavBar(
        icons: [
          Icons.arrow_back,
          null,
          isLoading ? Icons.hourglass_top : Icons.check, // 🔥 loading visual
        ],
        actions: [
          () => Navigator.pop(context),
          () {},
          isLoading ? () {} : updatePassword, // 🔥 bloqueia clique
        ],
        colors: [Colors.blue, Colors.transparent, Colors.green],
      ),
    );
  }
}
