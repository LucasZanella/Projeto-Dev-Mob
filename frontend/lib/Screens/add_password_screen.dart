import 'package:flutter/material.dart';
import 'package:frontend/widgets/navbar.dart';
import 'package:frontend/services/password_service.dart';
import 'package:frontend/widgets/password_textfield.dart';
import 'package:frontend/widgets/password_generator.dart';
import 'package:frontend/widgets/snackbar.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({super.key});

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreen();
}

class _AddPasswordScreen extends State<AddPasswordScreen> {
  final TextEditingController serviceController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? serviceError;
  String? loginError;
  String? passwordError;

  bool isLoading = false;

  Future<void> createPassword() async {
    if (isLoading) return;

    final service = serviceController.text.trim();
    final login = loginController.text.trim();
    final password = passwordController.text.trim();

    setState(() {
      serviceError = service.isEmpty ? "Campo obrigatório" : null;
      loginError = login.isEmpty ? "Campo obrigatório" : null;
      passwordError = password.isEmpty ? "Campo obrigatório" : null;
    });

    if (serviceError != null || loginError != null || passwordError != null) {
      return;
    }

    setState(() => isLoading = true);

    try {
      await PasswordService.createPassword(service, login, password);

      if (!mounted) return;

      Snackbar.show(
        context,
        icon: Icons.check_circle,
        color: Colors.green,
        message: "Senha criada!",
      );

      Navigator.pop(context, true);

    } catch (e) {

      if (!mounted) return;

      Snackbar.show(
        context,
        icon: Icons.error,
        color: Colors.red,
        message: "Erro ao criar a senha!",
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
              "Nova senha",
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
              errorText: serviceError,
            ),

            const SizedBox(height: 16),

            PasswordTextField(
              label: "Usuário / Email / Login",
              controller: loginController,
              errorText: loginError,
            ),

            const SizedBox(height: 16),

            PasswordGenerator(
              controller: passwordController, 
              errorText: passwordError,
            ),
          ],
        ),
      ),

      bottomNavigationBar: NavBar(
        icons: [
          Icons.arrow_back,
          null,
          isLoading ? Icons.hourglass_top : Icons.check,
        ],
        actions: [
          () => Navigator.pop(context),
          () {},
          isLoading ? () {} : createPassword,
        ],
        colors: [Colors.blue, Colors.transparent, Colors.green],
      ),
    );
  }
}
