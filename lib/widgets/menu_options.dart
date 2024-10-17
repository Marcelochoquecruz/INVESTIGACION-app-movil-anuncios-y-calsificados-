import 'package:flutter/cupertino.dart'; // Usamos Cupertino para el estilo iOS
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
        CupertinoListTile(
          leading: _buildLeadingIcon(
            CupertinoIcons.brightness, 
            isDrawer ? CupertinoColors.systemOrange : CupertinoColors.systemYellow,
          ),
          title: const Text('Cambiar de Tema', style: TextStyle(fontSize: 18)),
          onTap: () {
            themeController.toggleTheme();
            if (isDrawer) Get.back(); // Cierra el Drawer si es el caso
          },
        ),
        CupertinoListTile(
          leading: _buildLeadingIcon(
            CupertinoIcons.info_circle, 
            CupertinoColors.systemBlue,
          ),
          title: const Text('Acerca de Nosotros', style: TextStyle(fontSize: 18)),
          onTap: () {
            Get.toNamed('/about');
          },
        ),
        CupertinoListTile(
          leading: _buildLeadingIcon(
            CupertinoIcons.arrow_right_circle, 
            CupertinoColors.systemRed,
          ),
          title: const Text('Salir', style: TextStyle(fontSize: 18)),
          onTap: () {
            Get.offAllNamed('/');
          },
        ),
      ],
    );
  }

  // Método para simplificar la creación de íconos con estilo Cupertino
  Widget _buildLeadingIcon(IconData icon, Color color) {
    return Icon(icon, color: color, size: 28);
  }
}

// Widget CupertinoListTile que combina los beneficios de ListTile y Cupertino
class CupertinoListTile extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final GestureTapCallback? onTap;

  const CupertinoListTile({
    super.key,
    required this.leading,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: CupertinoColors.separator, width: 0.5),
          ),
        ),
        child: Row(
          children: [
            leading,
            const SizedBox(width: 16),
            Expanded(child: title),
          ],
        ),
      ),
    );
  }
}
