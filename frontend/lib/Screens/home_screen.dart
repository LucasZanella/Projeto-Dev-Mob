import 'package:flutter/material.dart';
import 'package:frontend/Widgets/navbar.dart';
import 'package:frontend/Services/session_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  void logout() async {

    await SessionService.removeToken();

    if (!mounted) return;

    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 18),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),

          child: Column(
            children: [

            const SizedBox(height: 50),
              /// HEADER
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [

                  const Text(
                    "Olá!!",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),

                  IconButton(
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                      size: 32,
                    ),
                    onPressed: logout,
                  )

                ],
              ),

              const SizedBox(height: 20),

              /// CONTEÚDO FUTURO
              const Expanded(
                child: Center(
                  child: Text(
                    "senhas",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),

      bottomNavigationBar: NavBar(
        icons: [null, Icons.add, null],
        actions: [
          () {},
          () => Navigator.pushNamed(context, "/addPassword"),
          () {},
        ],
        colors: [
          Colors.transparent,
          Colors.green,
          Colors.transparent
        ],
      ),
    );
  }
}