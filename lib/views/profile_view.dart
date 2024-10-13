import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Asegúrate de importar Get

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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar a la vista de radio
                Get.toNamed('/radio');
              },
              child: const Text('Escuchar Radio Collasuyo'), // Nuevo botón
            ),
          ],
        ),
      ),
    );
  }
}
