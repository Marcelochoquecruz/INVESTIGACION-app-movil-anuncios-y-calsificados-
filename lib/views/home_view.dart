// lib/views/home_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('¡Relájate!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6),
            onPressed: () => themeController.toggleTheme(),
          )
        ],
        // Estilos añadidos para el AppBar
        shape: const Border(
          bottom: BorderSide(
            color: Colors.lightBlueAccent, // Color del borde
            width: 1.0, // Grosor del borde
          ),
        ),
        elevation: themeController.isDarkTheme.value ? 4 : 6, // Sombra del AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/logo1.png',
              height: 130,
            ),
            const SizedBox(height: 10),
            const Text(
              'Deja el trabajo duro a nosotros',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            const Text(
              'Tú solo relájate y disfruta',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    offset: Offset(1.0, 1.0),
                    blurRadius: 3.0,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildButton(context, 'Iniciar Sesión', Icons.lock, '/login'),
            const SizedBox(height: 15),
            _buildButton(context, 'Continuar sin Registrarse', Icons.input, '/continue'),
            const SizedBox(height: 15),
            _buildButton(context, 'Crear Cuenta', Icons.person_add, '/registration'),
            const SizedBox(height: 30),
            // Nueva línea divisoria con sombreado
            Container(
              width: MediaQuery.of(context).size.width * 0.6, // Ancho de los botones
              alignment: Alignment.center,
              
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround, // Menos separación
              children: [
                Text('© DyCIT-2024', style: TextStyle(fontSize: 12)),
                Text('© UATF-2024', style: TextStyle(fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon, String route) {
    final ThemeController themeController = Get.find<ThemeController>();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.6,
      child: ElevatedButton.icon(
        onPressed: () => Get.toNamed(route),
        icon: Icon(icon, size: 24),
        label: Text(text),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          textStyle: const TextStyle(fontSize: 16),
          elevation: themeController.isDarkTheme.value ? 6 : 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          side: const BorderSide(color: Colors.lightBlueAccent, width: 1),
          shadowColor: themeController.isDarkTheme.value ? Colors.white24 : Colors.black38,
        ),
      ),
    );
  }
}
