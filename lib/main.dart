// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/theme_controller.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicia el controlador de tema y lo pone a disposición globalmente
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() => GetMaterialApp(
          title: 'Anuncios Domicilio',
          themeMode: themeController.isDarkTheme.value ? ThemeMode.dark : ThemeMode.light,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          initialRoute: '/', // Ruta inicial de la app
          getPages: AppRoutes.routes, // Configuración de las rutas
          debugShowCheckedModeBanner: false, // Desactivar el debug banner
        ));
  }
}
