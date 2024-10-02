import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class HomeView extends StatelessWidget {
  final ThemeController _themeController = Get.find(); // Obtener el controlador

  HomeView({super.key}); // Quitar const aquí

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ícono de cambio de tema
            IconButton(
              icon: Icon(
                _themeController.isDarkMode.value
                    ? Icons.wb_sunny
                    : Icons
                        .bedtime, // Cambiado a un estilo diferente de icono de luna
                size: 30, // Tamaño del ícono reducido
              ),
              onPressed: () {
                _themeController.toggleTheme(); // Cambiar tema al hacer clic
              },
            ),
            const SizedBox(
                height: 20), // Espaciador entre el ícono y los botones
            ElevatedButton(
              onPressed: () => Get.toNamed('/login'), // Navegar a LoginView
              child: const Text('Iniciar Sesión'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Get.toNamed('/continue'), // Navegar a ContinueView
              child: const Text('Continuar sin Registrarse'),
            ),
            ElevatedButton(
              onPressed: () =>
                  Get.toNamed('/registration'), // Navegar a RegistrationView
              child: const Text('Crear mi Cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}
