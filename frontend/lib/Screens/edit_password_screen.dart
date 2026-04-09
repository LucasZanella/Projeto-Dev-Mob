import 'package:flutter/material.dart';
import 'package:frontend/widgets/navbar.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({super.key});

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreen();
}

class _EditPasswordScreen extends State<EditPasswordScreen> {
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
