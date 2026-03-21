import 'package:flutter/material.dart';
import 'package:frontend/Widgets/input_authentication.dart';
import 'package:frontend/Widgets/button_authentication.dart';
import 'package:frontend/Screens/login_screen.dart';
import 'package:frontend/Utils/input_validators.dart';
import 'package:frontend/Widgets/password_requirement.dart';

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


  @override
  void initState() {
    super.initState();

    passwordController.addListener(validatePassword);
    passwordController.addListener(validateConfirmPassword);
    confirmPasswordController.addListener(validateConfirmPassword);
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


  void validateEmail() {
    setState(() {

      if (emailController.text.isEmpty) {
        emailError = "Digite seu email";
      } 
      else if (!InputValidators.emailValid(emailController.text)) {
        emailError = "Email inválido";
      } 
      else {
        emailError = null;
      }

    });
  }


  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasSpecial = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool passwordsMatch = false;

  void validatePassword() {
    String password = passwordController.text;

    setState(() {
      hasMinLength = InputValidators.hasMinLength(password);
      hasNumber = InputValidators.hasNumber(password);
      hasSpecial = InputValidators.hasSpecialChar(password);
      hasUppercase = InputValidators.hasUppercase(password);
      hasLowercase = InputValidators.hasLowercase(password);
    });
  }


  String? emailError;
  String? confirmPasswordError;

  void validateConfirmPassword() {

    String password = passwordController.text;
    String confirm = confirmPasswordController.text;

    setState(() {
      passwordsMatch = password.isNotEmpty && confirm.isNotEmpty && password == confirm;
    });
  }

  void register() {

    validateEmail();
    validatePassword();
    validateConfirmPassword();

    if (nameController.text.isEmpty) return;

    if (emailError != null) return;

    if (!hasMinLength || !hasNumber || !hasSpecial || !hasUppercase || !hasLowercase) return;

    if (!passwordsMatch) return;

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
                hintText: "Nome",
                controller: nameController,
              ),

              const SizedBox(height: 12),

              InputAuthentication(
                hintText: "E-mail",
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
              ),

              const SizedBox(height: 12),

              InputAuthentication(
                hintText: "Confirme a senha",
                controller: confirmPasswordController,
                onPressed: showPassword,
                icon: showPass ? Icons.visibility_off : Icons.visibility,
                obscureText: !showPass,
              ),

              const SizedBox(height: 6),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  PasswordRequirement(
                    text: "Pelo menos 8 caracteres",
                    valid: hasMinLength,
                  ),

                  PasswordRequirement(
                    text: "Pelo menos 1 número",
                    valid: hasNumber,
                  ),

                  PasswordRequirement(
                    text: "1 caractere especial",
                    valid: hasSpecial,
                  ),

                  PasswordRequirement(
                    text: "1 letra maiúscula",
                    valid: hasUppercase,
                  ),

                  PasswordRequirement(
                    text: "1 letra minúscula",
                    valid: hasLowercase,
                  ),

                  PasswordRequirement(
                    text: "As senhas coincidem",
                    valid: passwordsMatch,
                  ),

                ],
              ),

              const SizedBox(height: 20),

              ButtonAuthentication(
                customColor: const Color.fromARGB(255, 10, 185, 121),
                text: "Registrar",
                onTap: register,
              ),

              const SizedBox(height: 25),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const Text(
                    "Já possui uma conta?",
                    style: TextStyle(color: Colors.white),
                  ),

                  const SizedBox(width: 20),

                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(_createRoute());
                    },

                    child: const Text(
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
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}