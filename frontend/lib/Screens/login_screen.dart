import 'package:flutter/material.dart';
import 'package:frontend/Widgets/input_on_login_screen.dart';

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

  bool checkTheBox = false;
  void check() {
    setState(() {
      checkTheBox = !checkTheBox;
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
              InputOnLoginScreen(hintText: "Email"),
              const SizedBox(height: 15),
              InputOnLoginScreen(
                hintText: "Password",
                onPressed: showPassword,
                icon: showPass ? Icons.visibility_off : Icons.visibility,
                obscureText: showPass ? false : true,
              ),
            ],         
          ),
        ),
      ),
    );
  }
}
