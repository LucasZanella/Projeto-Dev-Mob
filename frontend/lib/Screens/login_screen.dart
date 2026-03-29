import 'package:flutter/material.dart';

import 'package:frontend/Widgets/input_authentication.dart';
import 'package:frontend/Widgets/button_authentication.dart';
import 'package:frontend/Widgets/snackbar.dart';
import 'package:frontend/Screens/register_screen.dart';
import 'package:frontend/Utils/input_validators.dart';
import 'package:frontend/Services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? emailError;
  String? passwordError;

  bool showPass = false;

  void showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }


  Route<void> _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const RegisterScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }


  void validateEmail() {
    if (emailController.text.isEmpty) {
      emailError = "Digite seu email";
    } 
    else if (!InputValidators.emailValid(emailController.text)) {
      emailError = "Email inválido";
    } 
    else {
      emailError = null;
    }
  }


  void validatePassword() {
    if (passwordController.text.isEmpty) {
      passwordError = "Digite sua senha";
    } else {
      passwordError = null;
    }
  }


  void login() async{
    setState(() {
      validateEmail();
      validatePassword();
    });

    if (emailError != null || passwordError != null) {
      return;
    }

    final result = await AuthService.login(
      emailController.text,
      passwordController.text,
    );

    if (!mounted) return;

    if (result["success"]) {

      Snackbar.show(
        context,
        icon: Icons.check_circle,
        color: Colors.green,
        message: result["message"],
      );

      Navigator.pushReplacementNamed(context, "/home");

    } else {

      Snackbar.show(
        context,
        icon: Icons.error,
        color: Colors.red,
        message: result["message"],
      );

  }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 18),

      body: Center(
        child: SingleChildScrollView(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const SizedBox(height: 15),
              
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 25),

                child: const Text(
                  "Bem-Vindo!",
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              InputAuthentication(
                hintText: "Email",
                controller: emailController,
                errorText: emailError,
              ),

              const SizedBox(height: 12),

              InputAuthentication(
                hintText: "Senha",
                controller: passwordController,
                onPressed: showPassword,
                icon: showPass ? Icons.visibility_off : Icons.visibility,
                obscureText: !showPass,
                errorText: passwordError,
              ),

              const SizedBox(height: 20),

              ButtonAuthentication(
                customColor: const Color.fromARGB(255, 10, 185, 121),
                text: "Entrar",
                onTap: login,
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    "Não tem uma conta?",
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(width: 20),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_createRoute());
                    },

                    child: const Text(
                      "REGISTRAR",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(255, 10, 185, 121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}