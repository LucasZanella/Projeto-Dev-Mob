import 'package:flutter/material.dart';

class Snackbar {

  static void show(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String message,
  }) 
  
  {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: color,
      elevation: 10,
      duration: const Duration(seconds: 2),

      margin: const EdgeInsets.only(
        bottom: 90,
        left: 16,
        right: 16,
      ),

      content: Row(
        children: [
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}