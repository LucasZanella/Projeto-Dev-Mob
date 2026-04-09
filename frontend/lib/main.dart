import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/home_screen.dart';
import 'screens/add_password_screen.dart';
import 'screens/details_password_screen.dart';
import 'screens/edit_password_screen.dart';
import 'screens/auth_check_screen.dart';
import 'package:frontend/models/password_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevMob App',
      debugShowCheckedModeBanner: false,

      /// tela inicial
      initialRoute: "/authCheck",

      /// rotas do app
      routes: {
        "/authCheck": (context) => const AuthCheckScreen(),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        "/home": (context) => const HomeScreen(),
        "/addPassword": (context) => const AddPasswordScreen(),

        "/detailsPassword": (context) {
          final password = ModalRoute.of(context)!.settings.arguments as PasswordModel;

          return DetailsPasswordScreen(password: password);
        },

        "/editPassword": (context) => const EditPasswordScreen(),
      },
    );
  }
}