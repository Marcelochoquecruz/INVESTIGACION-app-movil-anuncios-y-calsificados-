import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class MenuOptions extends StatelessWidget {
  final bool isDrawer; // Para saber si es usado en el Drawer o AppBar
  
  const MenuOptions({super.key, required this.isDrawer});
  
  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.brightness_6, color: isDrawer ? Colors.orange : Colors.yellow),
          title: const Text('Cambiar de Tema'),
          onTap: () {
            themeController.toggleTheme();
            if (isDrawer) Get.back(); // Cierra el Drawer si es el caso
          },
        ),
        ListTile(
          leading: Icon(Icons.info, color: Colors.blue),
          title: const Text('Acerca de Nosotros'),
          onTap: () {
            Get.toNamed('/about');
          },
        ),
        ListTile(
          leading: Icon(Icons.exit_to_app, color: Colors.red),
          title: const Text('Salir'),
          onTap: () {
            Get.offAllNamed('/');
          },
        ),
      ],
    );
  }
}
