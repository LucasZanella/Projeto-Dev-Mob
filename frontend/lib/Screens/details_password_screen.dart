import 'package:flutter/material.dart';
import 'package:frontend/Widgets/navbar.dart';

class DetailsPasswordScreen extends StatefulWidget {
  const DetailsPasswordScreen({super.key});

  @override
  State<DetailsPasswordScreen> createState() => _DetailsPasswordScreen();
}

class _DetailsPasswordScreen extends State<DetailsPasswordScreen> {
  void deletePassword() {
    print("Senha deletada");
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 18),

      bottomNavigationBar: NavBar(
        icons: [Icons.arrow_back, Icons.edit, Icons.delete],
        actions: [
          () => Navigator.pop(context),
          () => Navigator.pushNamed(context, "/editPassword"),
          () => deletePassword(),
        ],
        colors: [Colors.blue, Colors.amber, Colors.red],
      ),
    );
  }
}
