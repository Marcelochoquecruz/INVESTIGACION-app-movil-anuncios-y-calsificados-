import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class HomeView extends StatelessWidget {
  final ThemeController _themeController = Get.find();

  HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Eslogan encima del ícono de cambio de tema
            const Text(
              "Tu Hogar, Nuestro Compromiso",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurpleAccent,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 20), // Espacio entre el eslogan y el ícono

            // Ícono de cambio de tema con Obx para escuchar cambios
            Obx(() => IconButton(
                  icon: Icon(
                    _themeController.isDarkMode.value
                        ? Icons.bedtime // Ícono de luna
                        : Icons.wb_sunny, // Ícono de sol
                    size: 40, // Icono más grande
                    color: _themeController.isDarkMode.value
                        ? Colors.blue // Color azul para luna
                        : Colors.yellow, // Color amarillo para sol
                  ),
                  onPressed: () {
                    _themeController.toggleTheme();
                  },
                )),
           
            Image.asset(
              'lib/assets/logo1.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 5),

            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 50,
              endIndent: 50,
            ),
            const SizedBox(height: 20),

            _buildElevatedButton(
              icon: Icons.login,
              text: 'Iniciar Sesión',
              onPressed: () => Get.toNamed('/login'),
            ),
            const SizedBox(height: 20),

            // Botón "Continuar sin Registrarse"
            _buildElevatedButton(
              icon: Icons.person_outline,
              text: 'Continuar sin Registrarse',
              onPressed: () => Get.toNamed('/continue'),
            ),
            const SizedBox(height: 20),

            // Botón "Crear mi Cuenta"
            _buildElevatedButton(
              icon: Icons.person_add,
              text: 'Crear mi Cuenta',
              onPressed: () => Get.toNamed('/registration'),
            ),
            const SizedBox(height: 30),

            const Divider(
              color: Colors.grey,
              thickness: 1,
              indent: 50,
              endIndent: 50,
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    "©copyright DICyT-2024",
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Text(
                    "©copyright UATF-2024",
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildElevatedButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 400,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.black),
        label: Text(
          text,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          backgroundColor: const Color.fromARGB(255, 244, 244, 247),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: Colors.lightBlue, width: 2),
          ),
          shadowColor: Colors.lightBlue,
          elevation: 8,
        ),
      ),
    );
  }
}
