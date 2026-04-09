import 'package:flutter/material.dart';
import 'package:frontend/widgets/navbar.dart';
import 'package:frontend/widgets/password_textfield.dart';
import 'package:frontend/models/password_model.dart';

class DetailsPasswordScreen extends StatefulWidget {
  final PasswordModel password;

  const DetailsPasswordScreen({
    super.key,
    required this.password,
  });

  @override
  State<DetailsPasswordScreen> createState() => _DetailsPasswordScreenState();
}

class _DetailsPasswordScreenState extends State<DetailsPasswordScreen> {

  late TextEditingController serviceController;
  late TextEditingController loginController;
  late TextEditingController passwordController;

  bool _showSensitiveData = false;

  @override
  void initState() {
    super.initState();

    serviceController = TextEditingController(text: widget.password.service);

    loginController = TextEditingController(text: widget.password.login);

    passwordController = TextEditingController(text: widget.password.password);
  }

  void toggleVisibility() {
    setState(() {
      _showSensitiveData = !_showSensitiveData;
    });
  }

  bool neverUpdated(DateTime created, DateTime updated) {
    return updated.difference(created).inSeconds == 0;
  }

  void deletePassword() {
    print("Senha deletada");
  }

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')} "
        "${_monthName(date.month)} "
        "${date.year}";
  }

  String _monthName(int month) {
    const months = [
      '',
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez'
    ];
    return months[month];
  }

  @override
  Widget build(BuildContext context) {

    final password = widget.password;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 19, 18, 18),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              
              const SizedBox(height: 28),

              /// TÍTULO
              const Center(
                child: Text(
                  "Detalhes",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// DIVISÓRIA
              const Divider(
                color: Colors.white12,
                thickness: 1,
              ),

              const SizedBox(height: 25),

              /// CARD DE INFORMAÇÕES
              Container(
                padding: const EdgeInsets.all(20),

                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 30, 30, 30),
                  borderRadius: BorderRadius.circular(16),
                ),

                child: Column(
                  children: [

                    /// SERVIÇO
                    PasswordTextField(
                      label: "Nome do serviço",
                      controller: serviceController,
                      readOnly: true,
                    ),

                    const SizedBox(height: 18),

                    /// LOGIN
                    PasswordTextField(
                      label: "Usuário / Login",
                      controller: loginController,
                      readOnly: true,
                      obscureText: !_showSensitiveData,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showSensitiveData
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: toggleVisibility,
                      ),
                    ),

                    const SizedBox(height: 18),

                    /// SENHA
                    PasswordTextField(
                      label: "Senha",
                      controller: passwordController,
                      readOnly: true,
                      obscureText: !_showSensitiveData,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _showSensitiveData
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.grey,
                        ),
                        onPressed: toggleVisibility,
                      ),
                    ),

                    const SizedBox(height: 28),

                    /// DATAS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        /// CRIAÇÃO
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Data de Criação",
                              style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              formatDate(password.createdAt),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        /// ATUALIZAÇÃO
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Data de alteração",
                              style: TextStyle(
                                color: Colors.white60,
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 6),

                            Text(
                              neverUpdated(password.createdAt, password.updatedAt!)
                                  ? "Nunca"
                                  : formatDate(password.updatedAt!),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: NavBar(
        icons: [Icons.arrow_back, Icons.edit, Icons.delete],
        actions: [
          () => Navigator.pop(context),
          () => Navigator.pushNamed(
            context,
            "/editPassword",
            arguments: password,
          ),
          () => deletePassword(),
        ],
        colors: [Colors.blue, Colors.amber, Colors.red],
      ),
    );
  }
}