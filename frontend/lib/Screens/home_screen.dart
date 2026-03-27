import 'package:flutter/material.dart';
import 'package:frontend/Widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 18),

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
      )
    );
  }
}