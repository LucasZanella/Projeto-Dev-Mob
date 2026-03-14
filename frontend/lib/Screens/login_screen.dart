import 'package:flutter/material.dart';
import 'package:frontend/Widgets/input_authentication.dart';
import 'package:frontend/Widgets/button_authentication.dart';
import 'package:frontend/Screens/register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPass = false;
  void showPassword() {
    setState(() {
      showPass = !showPass;
    });
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 18, 18),
      body: Center(
        child: SafeArea(
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
                        color: Color.fromARGB(255, 255, 255, 255)
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              InputAuthentication(hintText: "Email"),
              const SizedBox(height: 15),
              InputAuthentication(
                hintText: "Password",
                onPressed: showPassword,
                icon: showPass ? Icons.visibility_off : Icons.visibility,
                obscureText: showPass ? false : true,
              ),
              const SizedBox(height: 35),
              MyButton(
                customColor: Color.fromARGB(255, 10, 185, 121),
                text: "Entrar",
                onTap: () {},
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Não tem uma conta?",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => RegisterScreen()));
                    },
                    child: Text(
                      "REGISTRAR",
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Color.fromARGB(255, 10, 185, 121),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ],         
          ),
        ),
      ),
    );
  }
}
