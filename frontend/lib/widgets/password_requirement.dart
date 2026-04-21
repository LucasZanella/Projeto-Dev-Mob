import 'package:flutter/material.dart';

class PasswordRequirement extends StatelessWidget {

  final String text;
  final bool valid;

  const PasswordRequirement({
    super.key,
    required this.text,
    required this.valid,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 4),

      child: Row(
        children: [

          Icon(
            valid ? Icons.check_circle : Icons.cancel,
            color: valid ? Colors.green : Colors.red,
            size: 18,
          ),

          const SizedBox(width: 8),

          Text(
            text,
            style: TextStyle(
              color: valid ? Colors.green : Colors.red,
              fontSize: 12,
            ),
          ),

        ],
      ),
    );
  }
}