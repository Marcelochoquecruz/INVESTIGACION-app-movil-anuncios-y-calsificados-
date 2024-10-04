import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomNavBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();

    return AppBar(
      title: Text(title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'theme') {
              themeController.toggleTheme();
            } else if (value == 'about') {
              Get.toNamed('/about');
            }
          },
          itemBuilder: (BuildContext context) {
            return [
              const PopupMenuItem<String>(
                value: 'theme',
                child: Text('Cambiar de tema'),
              ),
              const PopupMenuItem<String>(
                value: 'about',
                child: Text('Acerca de nosotros'),
              ),
            ];
          },
        ),
      ],
      shape: const Border(
        bottom: BorderSide(
          color: Colors.lightBlueAccent,
          width: 1.0,
        ),
      ),
      elevation: themeController.isDarkTheme.value ? 4 : 6,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
