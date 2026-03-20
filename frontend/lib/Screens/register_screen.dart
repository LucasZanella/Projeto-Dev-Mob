import 'package:flutter/material.dart';
import 'package:frontend/Widgets/input_authentication.dart';
import 'package:frontend/Widgets/button_authentication.dart';
import 'package:frontend/Screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool showPass = false;
  void showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }

  Route<void> _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }

  bool emailValid(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 18, 18),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 25.0),
                child: Row(
                  children: [
                    Text(
                      "Bem-Vindo!",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              InputAuthentication(hintText: "Nome", controller: nameController,),
              const SizedBox(height: 12),
              InputAuthentication(hintText: "E-mail", controller: emailController,),
              const SizedBox(height: 12),
              InputAuthentication(
                hintText: "Senha",
                controller: passwordController,
                onPressed: showPassword,
                icon: showPass ? Icons.visibility_off : Icons.visibility,
                obscureText: showPass ? false : true,
              ),
              const SizedBox(height: 12),
              InputAuthentication(
                hintText: "Confirme a senha",
                controller: confirmPasswordController,
                onPressed: showPassword,
                icon: showPass ? Icons.visibility_off : Icons.visibility,
                obscureText: showPass ? false : true,
              ),
              const SizedBox(height: 20),
              MyButton(
                customColor: Color.fromARGB(255, 10, 185, 121),
                text: "Registrar",
                onTap: () {

                  if (nameController.text.isEmpty) {
                    showMessage("Digite seu nome");
                    return;
                  }

                  if (!emailValid(emailController.text)) {
                    showMessage("Email inválido");
                    return;
                  }

                  if (passwordController.text.isEmpty) {
                    showMessage("Digite uma senha");
                    return;
                  }

                  if (passwordController.text != confirmPasswordController.text) {
                    showMessage("As senhas não coincidem");
                    return;
                  }

                },
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Já possui uma conta?",
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_createRoute());
                    },
                    child: Text(
                      "ENTRAR",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(255, 10, 185, 121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
