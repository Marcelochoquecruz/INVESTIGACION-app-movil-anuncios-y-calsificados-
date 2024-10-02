// Importamos las bibliotecas necesarias para la interfaz de usuario (Material) y GetX para la gestión de estado y rutas.
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Importamos el controlador de tema para manejar el cambio de tema en la aplicación.
import '../controllers/theme_controller.dart';

class HomeView extends StatelessWidget {
  // Creamos una instancia del controlador de tema usando Get.find() para gestionar los cambios de tema.
  final ThemeController _themeController = Get.find();

  // Constructor de HomeView
  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Eslogan encima del ícono de cambio de tema
            Obx(() => Text(
                  "La app que cuida tu hogar, donde tú estés.",
                  style: TextStyle(
                    fontSize: 18, // Aumentar tamaño de letra
                    fontWeight: FontWeight.bold,
                    color: _themeController.isDarkMode.value
                        ? Colors.white
                        : Color.fromARGB(
                            255, 24, 54, 80), // Cambia según el tema
                  ),
                )),
            const SizedBox(height: 20), // Espacio entre el eslogan y el ícono

            // Ícono de cambio de tema con Obx para escuchar cambios
            Obx(() => IconButton(
                  icon: Icon(
                    _themeController.isDarkMode.value
                        ? Icons.bedtime // Ícono de luna
                        : Icons.wb_sunny, // Ícono de sol
                    size: 30, // Icono más grande
                    color: _themeController.isDarkMode.value
                        ? Color.fromARGB(
                      255, 24, 54, 80) // Color azul para luna
                        : Colors.yellowAccent, // Color amarillo para sol
                  ),
                  onPressed: () {
                    _themeController
                        .toggleTheme(); // Cambia el tema al hacer clic
                  },
                )),

            // Logo de la aplicación
            Image.asset(
              'lib/assets/logo1.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 5),

            // Línea divisora que cambia de color según el tema
            Obx(() => Divider(
                  color: _themeController.isDarkMode.value
                      ? Colors.white70
                      : Colors.black87, // Cambia según el tema
                  thickness: 0.5,
                  indent: 100,
                  endIndent: 100,
                )),
            const SizedBox(height: 20),

            // Botón "Iniciar Sesión"
            _buildElevatedButton(
              icon: Icons.login,
              text: 'Iniciar Sesión',
              onPressed: () => Get.toNamed(
                  '/login'), // Navegar a la vista de inicio de sesión
            ),
            const SizedBox(height: 20),

            // Botón "Continuar sin Registrarse"
            _buildElevatedButton(
              icon: Icons.person_outline,
              text: 'Continuar sin Registrarse',
              onPressed: () =>
                  Get.toNamed('/continue'), // Navegar a la vista sin registro
            ),
            const SizedBox(height: 20),

            // Botón "Crear mi Cuenta"
            _buildElevatedButton(
              icon: Icons.person_add,
              text: 'Crear mi Cuenta',
              onPressed: () => Get.toNamed(
                  '/registration'), // Navegar a la vista de registro
            ),
            const SizedBox(height: 30),

            // Segunda línea divisora que cambia de color según el tema
            Obx(() => Divider(
                  color: _themeController.isDarkMode.value
                      ? Colors.white70
                      : Colors.black87, // Cambia según el tema
                  thickness: 1,
                  indent: 100,
                  endIndent: 100,
                )),
            const SizedBox(height: 10),

            // Línea de copyright con colores que cambian según el tema
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "©copyright DICyT-2024",
                        style: TextStyle(
                          color: _themeController.isDarkMode.value
                              ? Colors.white70
                              : Colors.black87, // Cambia según el tema
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        "©copyright UATF-2024",
                        style: TextStyle(
                          color: _themeController.isDarkMode.value
                              ? Colors.white70
                              : Colors.black87, // Cambia según el tema
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  // Método para construir un botón elevado con un ícono y texto
  Widget _buildElevatedButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 320,
      child: Obx(() => ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: _themeController.isDarkMode.value
                  ? Colors.black87
                  : Colors
                      .white70, // Color del ícono: negro en modo oscuro, blanco en modo claro
            ),
            label: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: _themeController.isDarkMode.value
                    ? Colors.black
                    : Colors.white, // Color del texto según el tema
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              backgroundColor: _themeController.isDarkMode.value
                  ? Colors.white
                  : const Color.fromARGB(
                      255, 24, 54, 80), // Color de los botones
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Bordes redondeados
                side: BorderSide(
                  color: _themeController.isDarkMode.value
                      ? const Color.fromARGB(255, 3, 3, 3)
                      : Colors.black87, // Borde según el tema
                ),
              ),
            ),
          )),
    );
  }
}
