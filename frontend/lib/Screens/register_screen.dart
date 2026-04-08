import 'package:flutter/material.dart';
import 'package:frontend/Widgets/input_authentication.dart';
import 'package:frontend/Widgets/button_authentication.dart';
import 'package:frontend/Screens/login_screen.dart';
import 'package:frontend/Utils/input_validators.dart';
import 'package:frontend/Widgets/password_requirement.dart';
import 'package:frontend/Widgets/snackbar.dart';
import 'package:frontend/Services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  String? nameError;
  String? emailError;

  bool hasMinLength = false;
  bool hasNumber = false;
  bool hasSpecial = false;
  bool hasUppercase = false;
  bool hasLowercase = false;
  bool passwordsMatch = false;

  bool showPass = false;

  Route<void> _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const LoginScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
    );
  }


  void validateName() {

    if (!InputValidators.nameValid(nameController.text)) {
      nameError = "Digite um nome válido";
    } else {
      nameError = null;
    }
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


  void showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }


  void validatePassword() {
    setState(() {
      String password = passwordController.text;

      hasMinLength = InputValidators.hasMinLength(password);
      hasNumber = InputValidators.hasNumber(password);
      hasSpecial = InputValidators.hasSpecialChar(password);
      hasUppercase = InputValidators.hasUppercase(password);
      hasLowercase = InputValidators.hasLowercase(password);
    });
  }

  void validateConfirmPassword() {
    setState(() {
      final password = passwordController.text;
      final confirm = confirmPasswordController.text;

    passwordsMatch = InputValidators.passwordsMatch(password, confirm) && password.isNotEmpty && confirm.isNotEmpty;
    });
  }


  void register() async {

    setState(() {
      validateName();
      validateEmail();
      validatePassword();
      validateConfirmPassword();
    });

    if (nameError != null || emailError != null || !passwordsMatch) {
      return;
    }

    if (!InputValidators.passwordValid(passwordController.text)) return;

    try{

      final result = await AuthService.register(
        nameController.text,
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

        Navigator.of(context).push(_createRoute());

      } else {

        Snackbar.show(
          context,
          icon: Icons.error,
          color: Colors.red,
          message: result["message"],
        );
      }

    } catch (e){

      Snackbar.show(
        context,
        icon: Icons.error,
        color: Colors.red,
        message: "Erro de conexão com o servidor",
      );

    }
  }


  @override
  void initState() {
    super.initState();

    passwordController.addListener(validatePassword);
    passwordController.addListener(validateConfirmPassword);
    confirmPasswordController.addListener(validateConfirmPassword);
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
                errorText: nameError,
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
                  )
                ],
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
                    text: "As senhas coincidem",
                    valid: passwordsMatch,        
                  )
                ]
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