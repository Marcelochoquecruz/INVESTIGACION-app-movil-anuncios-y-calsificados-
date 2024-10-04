// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController themeController = ThemeController();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(themeController);
    return Obx(() => GetMaterialApp(
          title: 'Anuncios Domicilio',
          themeMode: themeController.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          initialRoute: '/',
          getPages: AppRoutes.routes,
          debugShowCheckedModeBanner: false, // Desactivar el debug banner
        ));
  }
}
