import 'package:flutter/material.dart';

class ContinueView extends StatelessWidget {
  const ContinueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Continuar sin registrarse")),
      body: const Center(child: Text("Vista de Continuar")),
    );
  }
}
