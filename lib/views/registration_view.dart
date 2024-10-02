import 'package:flutter/material.dart';

class RegistrationView extends StatelessWidget {
  const RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Crear mi cuenta")),
      body: const Center(child: Text("Vista de Registro")),
    );
  }
}
