// lib/views/continue_view.dart
import 'package:flutter/material.dart';

class ContinueView extends StatelessWidget {
  const ContinueView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Continuar sin Registrarse'),
      ),
      body: const Center(
        child: Text('Vista para continuar sin registrarse'),
      ),
    );
  }
}
