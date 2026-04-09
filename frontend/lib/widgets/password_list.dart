import 'package:flutter/material.dart';

class PasswordList extends StatelessWidget {

  final String service;
  final VoidCallback onTap;

  const PasswordList({
    super.key,
    required this.service,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: onTap,

      child: Container(
        margin: const EdgeInsets.only(bottom: 12),

        padding: const EdgeInsets.all(16),

        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 29, 29, 29),
          borderRadius: BorderRadius.circular(12),
        ),

        child: Row(
          children: [

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                service,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: Colors.white54,
            )

          ],
        ),
      ),
    );
  }
}