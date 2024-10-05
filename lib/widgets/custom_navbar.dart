import 'package:anuncios_domicilio/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'menu_options.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomNavBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.deepPurple,
      title: Text(
        title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () {
          Get.to(() => const HomeView());
        },
      ),
      actions: [
        PopupMenuButton<String>(
          onSelected: (value) {
            // No necesitas lógica aquí, la maneja MenuOptions
          },
          icon: const Icon(Icons.menu, color: Colors.white),
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'menu',
                child: MenuOptions(
                    isDrawer: false), // Usamos el widget reutilizable
              ),
            ];
          },
        ),
      ],
      shape: const Border(
        bottom: BorderSide(
          color: Colors.deepPurpleAccent,
          width: 1.0,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
