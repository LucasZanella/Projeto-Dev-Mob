import 'package:flutter/material.dart';
import 'package:frontend/Widgets/navbar.dart';

class AddPasswordScreen extends StatefulWidget {
  const AddPasswordScreen({super.key});

  @override
  State<AddPasswordScreen> createState() => _AddPasswordScreen();
}

class _AddPasswordScreen extends State<AddPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 18),



      bottomNavigationBar: NavBar(
        icons: [Icons.arrow_back, null, null],
        actions: [
          () => Navigator.pop(context), 
          () {}, 
          () {},
        ],
        colors: [Colors.blue, Colors.transparent, Colors.transparent],
      ),
    );
  }
}
