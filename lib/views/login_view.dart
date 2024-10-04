import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart'; // Asegúrate de importar tu CustomNavBar

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(
          title: 'Iniciar Sesión'), // Añadir el CustomNavBar aquí
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Correo Electrónico'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Aquí puedes implementar la lógica de inicio de sesión
              },
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                textStyle: const TextStyle(fontSize: 18),
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
