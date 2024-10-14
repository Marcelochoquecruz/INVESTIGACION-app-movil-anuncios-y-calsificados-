import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void openForgotPasswordDialog() {
    String email = '';

    Get.defaultDialog(
      title: 'Recuperar Contraseña',
      content: Column(
        children: [
          const Text('Ingresa tu correo electrónico para recuperar tu contraseña:'),
          const SizedBox(height: 10),
          TextField(
            onChanged: (value) {
              email = value; // Captura el email
            },
            decoration: const InputDecoration(hintText: 'Correo electrónico'),
          ),
        ],
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          try {
            await _auth.sendPasswordResetEmail(email: email);
            Get.back(); // Cierra el diálogo

            // Actualización del Snackbar
            Get.snackbar(
              'Éxito',
              'Se envió un correo a $email. Revisa tu bandeja de entrada.',
              duration: const Duration(seconds: 5), // Duración del Snackbar
              snackPosition: SnackPosition.BOTTOM, // Posición del Snackbar
              backgroundColor: Colors.black, // Fondo negro
              colorText: Colors.white, // Color del texto
              margin: const EdgeInsets.all(10), // Margen alrededor del Snackbar
              borderRadius: 10, // Radio del borde
              titleText: const Text(
                'Éxito',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Tamaño y negrita
              ),
              messageText: Text(
                'Se envió un correo a $email. Revisa tu bandeja de entrada.',
                style: const TextStyle(fontSize: 18, color: Colors.white), // Aseguramos que sea blanco
              ),
            );
          } catch (e) {
            Get.snackbar(
              'Error',
              'No se pudo enviar el correo: ${e.toString()}',
              duration: const Duration(seconds: 5), // Duración del Snackbar
              snackPosition: SnackPosition.BOTTOM, // Posición del Snackbar
              backgroundColor: Colors.black, // Fondo negro
              colorText: Colors.white, // Color del texto
              margin: const EdgeInsets.all(10), // Margen alrededor del Snackbar
              borderRadius: 10, // Radio del borde
              titleText: const Text(
                'Error',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Tamaño y negrita
              ),
              messageText: Text(
                'No se pudo enviar el correo: ${e.toString()}',
                style: const TextStyle(fontSize: 18, color: Colors.white), // Aseguramos que sea blanco
              ),
            );
          }
        },
        child: const Text('Enviar'),
      ),
    );
  }
}
