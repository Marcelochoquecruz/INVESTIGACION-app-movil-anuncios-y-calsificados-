// lib/views/profile_view.dart
import 'package:flutter/material.dart';
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Nombre: Usuario Ejemplo'),
            const Text('Correo: usuario@ejemplo.com'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para editar perfil
              },
              child: const Text('Editar Perfil'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para ver historial
              },
              child: const Text('Ver Historial de Anuncios'),
            ),
          ],
        ),
      ),
    );
  }
}
