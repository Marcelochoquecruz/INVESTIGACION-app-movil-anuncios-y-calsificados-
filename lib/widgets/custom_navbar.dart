import 'package:anuncios_domicilio/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'menu_options.dart';

class CustomNavBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomNavBar({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF4A00E0), // Morado fuerte
            Color(0xFF8E2DE2), // Morado suave
            Color(0xFF00C9FF), // Azul claro
          ],
        ),
      ),
      child: AppBar(
        backgroundColor: Colors.transparent, // Hacemos transparente el AppBar
        elevation: 0, // Sin sombra para que se vea más limpio
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
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
                const PopupMenuItem<String>(
                  value: 'menu',
                  child: MenuOptions(isDrawer: false),
                ),
              ];
            },
          ),
        ],
        shape: const Border(
          bottom: BorderSide(
            color: Colors.white54,
            width: 1.0,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
