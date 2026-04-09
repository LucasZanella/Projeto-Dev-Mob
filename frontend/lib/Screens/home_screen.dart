import 'package:flutter/material.dart';
import 'package:frontend/widgets/navbar.dart';
import 'package:frontend/widgets/password_list.dart';
import 'package:frontend/services/session_service.dart';
import 'package:frontend/services/password_service.dart';
import 'package:frontend/models/password_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PasswordModel> passwords = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadPasswords();
  }

  void loadPasswords() async {
    try {
      final data = await PasswordService.getPasswords();

      setState(() {
        passwords = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

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
              const SizedBox(height: 30),

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
                    icon: const Icon(Icons.logout, color: Colors.red, size: 32),
                    onPressed: logout,
                  ),
                ],
              ),

              const SizedBox(height: 10),

              const Divider(
                color: Colors.white12,
                thickness: 1,
              ),

              const SizedBox(height: 20),

              /// ÁREA DAS SENHAS
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Suas senhas",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 24, 24, 24),
                          borderRadius: BorderRadius.circular(12),
                        ),

                        child: isLoading

                            /// LOADING
                            ? const Center(child: CircularProgressIndicator())

                            /// LISTA VAZIA
                            : passwords.isEmpty
                            ? const Center(
                                child: Text(
                                  "Nenhuma senha cadastrada",
                                  style: TextStyle(color: Colors.white54),
                                ),
                              )
                              
                            /// LISTA DE SENHAS
                            : ListView.builder(
                                itemCount: passwords.length,
                                itemBuilder: (context, index) {
                                  final password = passwords[index];

                                  return PasswordList(
                                    service: password.service,

                                    onTap: () {
                                      Navigator.pushNamed(
                                        context,
                                        "/detailsPassword",
                                        arguments: password,
                                      );
                                    },
                                  );
                                },
                              ),
                      ),
                    ),
                  ],
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
        colors: [Colors.transparent, Colors.green, Colors.transparent],
      ),
    );
  }
}
