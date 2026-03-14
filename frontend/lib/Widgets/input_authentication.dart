import 'package:flutter/material.dart';

class InputAuthentication extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final void Function()? onPressed;
  final bool obscureText;
  final TextEditingController? controller;

  const InputAuthentication({
    super.key,
    required this.hintText,
    this.icon,
    this.onPressed,
    this.obscureText = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.grey[600]!.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              style: const TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                ),
              ),
              obscureText: obscureText,
            ),
          ),
          IconButton(
            onPressed: onPressed, 
            icon: Icon(icon),
            color: Colors.grey,
          ),
        ],
      ),
    );
  }
}