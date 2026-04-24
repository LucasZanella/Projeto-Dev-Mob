import 'dart:math';
import 'package:flutter/material.dart';
import 'package:frontend/utils/input_validators.dart';

class PasswordGenerator extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;

  const PasswordGenerator({
    super.key,
    required this.controller,
    this.errorText,
  });

  @override
  State<PasswordGenerator> createState() => _PasswordGeneratorState();
}

class _PasswordGeneratorState extends State<PasswordGenerator> {
  bool isManual = false;

  bool hasLower = false;
  bool hasUpper = false;
  bool hasNumbers = false;
  bool hasSpecial = false;

  double length = 12;

  final String lower = "abcdefghijklmnopqrstuvwxyz";
  final String upper = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
  final String numbers = "0123456789";
  final String special = "!@#\$%&*()_+-=[]{}";

  final TextEditingController confirmController = TextEditingController();
  String? confirmError;

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    generatePassword();
  }

  void toggleVisibility() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  void validateManualPassword() {
    final pass = widget.controller.text.trim();
    final confirm = confirmController.text.trim();

    if (isManual && !InputValidators.passwordsMatch(pass, confirm)) {
      setState(() {
        confirmError = "As senhas não coincidem";
      });
      return;
    }
  }

  void generatePassword() {
    if (isManual) return;

    String chars = "";

    if (hasLower) chars += lower;
    if (hasUpper) chars += upper;
    if (hasNumbers) chars += numbers;
    if (hasSpecial) chars += special;

    if (chars.isEmpty) {
      widget.controller.text = "";
      return;
    }

    final rand = Random();
    String pass = "";

    int size = length < 6 ? 6 : length.toInt();

    for (int i = 0; i < size; i++) {
      pass += chars[rand.nextInt(chars.length)];
    }

    widget.controller.text = pass;
  }

  Widget buildToggle(String label, bool value, Function(bool) onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 40, 40, 40),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
              fontWeight: FontWeight.w700,
            ),
          ),
          Switch(
            value: value,
            activeThumbColor: const Color.fromARGB(255, 39, 187, 25),
            onChanged: (val) {
              onChanged(val);
              generatePassword();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Opções de Senha", style: TextStyle(color: Colors.white70)),

        const SizedBox(height: 8),

        // Gerador / Manual
        Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 40, 40, 40),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isManual = false);
                    generatePassword();
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: !isManual
                          ? Colors.blue.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Gerador",
                        style: TextStyle(
                          color: !isManual ? Colors.white : Colors.white54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => isManual = true);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isManual
                          ? Colors.blue.withValues(alpha: 0.2)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Manual",
                        style: TextStyle(
                          color: isManual ? Colors.white : Colors.white54,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        if (!isManual) ...[
          const SizedBox(height: 30),

          // Visualização de senha
          TextField(
            controller: widget.controller,
            readOnly: !isManual,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
            ),
            decoration: InputDecoration(
              hintText: "Senha",
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color.fromARGB(255, 45, 45, 45),
              contentPadding: const EdgeInsets.symmetric(vertical: 17),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),

              errorText: widget.errorText,

              suffixIcon: !isManual
                  ? IconButton(
                      icon: const Icon(Icons.refresh, color: Colors.white70),
                      onPressed: generatePassword,
                    )
                  : null,
            ),
          ),

          const SizedBox(height: 15),

          const Text(
            "Configuração da senha",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 10),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2.8,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              buildToggle(
                "Minúscula",
                hasLower,
                (v) => setState(() => hasLower = v),
              ),
              buildToggle(
                "Maiúscula",
                hasUpper,
                (v) => setState(() => hasUpper = v),
              ),
              buildToggle(
                "Número",
                hasNumbers,
                (v) => setState(() => hasNumbers = v),
              ),
              buildToggle(
                "Especial",
                hasSpecial,
                (v) => setState(() => hasSpecial = v),
              ),
            ],
          ),

          const SizedBox(height: 16),

          const Text(
            "Tamanho",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          Row(
            children: [
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: Colors.deepPurple,
                    inactiveTrackColor: Colors.white70,

                    thumbColor: Colors.deepPurple,
                    overlayColor: Colors.deepPurple.withValues(alpha: 0.2),

                    valueIndicatorColor: Colors.deepPurple,

                    valueIndicatorTextStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),

                    showValueIndicator: ShowValueIndicator.onDrag,
                  ),
                  child: Slider(
                    value: length,
                    min: 6,
                    max: 32,
                    divisions: 26,
                    label: length.toInt().toString(),

                    onChanged: (value) {
                      setState(() {
                        length = value < 6 ? 6 : value;
                      });
                      generatePassword();
                    },
                  ),
                ),
              ),

              Text(
                (length < 6 ? 6 : length).toInt().toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ],
          ),

        ] else ...[

          const SizedBox(height: 30),

          const Text(
            "Senha",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 5),

          TextField(
            controller: widget.controller,
            obscureText: !showPassword,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: "Digite a senha",
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color.fromARGB(255, 45, 45, 45),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),

              errorText: widget.errorText,

              suffixIcon: IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: toggleVisibility,
              ),
            ),
            onChanged: (_) => validateManualPassword(),
          ),

          const SizedBox(height: 16),

          const Text(
            "Confirmação da senha",
            style: TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 5),

          TextField(
            controller: confirmController,
            obscureText: !showPassword,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              hintText: "Confirmar senha",
              hintStyle: const TextStyle(color: Colors.white38),
              filled: true,
              fillColor: const Color.fromARGB(255, 45, 45, 45),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 14,
              ),

              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),

              errorText: confirmError,

              suffixIcon: IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                ),
                onPressed: toggleVisibility,
              ),
            ),
            onChanged: (_) => validateManualPassword(),
          ),

          const SizedBox(height: 5),
        ],
      ],
    );
  }
}
