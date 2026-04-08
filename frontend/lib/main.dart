import 'package:flutter/material.dart';

import 'Screens/login_screen.dart';
import 'Screens/register_screen.dart';
import 'Screens/home_screen.dart';
import 'Screens/add_password_screen.dart';
import 'Screens/details_password_screen.dart';
import 'Screens/edit_password_screen.dart';
import 'Screens/auth_check_screen.dart';

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
        "/detailsPassword": (context) => const DetailsPasswordScreen(),
        "/editPassword": (context) => const EditPasswordScreen(),
      },
    );
  }
}