import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class WaveShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3) // Color con opacidad
      ..style = PaintingStyle.fill;

    final path = Path();

    // Dibujar una forma de onda suave para el estilo bancario
    path.moveTo(0, size.height);

    // Primera onda
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.8,
        size.width * 0.5, size.height * 0.9);

    // Segunda onda
    path.quadraticBezierTo(
        size.width * 0.75, size.height, size.width, size.height * 0.8);

    // Cerrar el path
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    // Añadir un círculo sutil para representar un sol o luna
    path.addOval(Rect.fromCircle(
        center: Offset(size.width * 0.8, size.height * 0.2),
        radius: size.width * 0.08));

    // Añadir una línea horizontal para dar profundidad
    path.moveTo(0, size.height * 0.6);
    path.lineTo(size.width, size.height * 0.6);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      body: Stack(
        children: [
          CustomPaint(
            painter: WaveShape(),
            child: Container(
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Obx(() => Text(
                          '¡Simplificamos tu vida!',
                          style: TextStyle(
                            fontSize: 20,
                            color: themeController.isDarkTheme.value
                                ? Colors.white
                                : Colors.black,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() => Text(
                              'Tu solo registrate en nuestra app.',
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontSize: 20,
                                color: themeController.isDarkTheme.value
                                    ? Colors.white
                                    : Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            )),
                        const SizedBox(width: 10),
                        IconButton(
                          icon: Obx(() => Icon(
                                themeController.isDarkTheme.value
                                    ? Icons.light_mode
                                    : Icons.dark_mode,
                                color: Colors.blueAccent,
                              )),
                          onPressed: () => themeController.toggleTheme(),
                          iconSize: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Image.asset(
                  'lib/assets/logo1.png',
                  height: 140,
                ),
                const SizedBox(height: 40),
                _buildButton(context, 'Iniciar Sesión', Icons.lock, '/login'),
                const SizedBox(height: 20),
                _buildButton(context, 'Continuar sin Registrarse', Icons.input,
                    '/continue'),
                const SizedBox(height: 20),
                _buildButton(
                    context, 'Crear Cuenta', Icons.person_add, '/registration'),
                const SizedBox(height: 50),
                Container(
                  width: MediaQuery.of(context).size.width * 0.6,
                  alignment: Alignment.center,
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text('© DyCIT-2024', style: TextStyle(fontSize: 12)),
                    Text('© UATF-2024', style: TextStyle(fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
      BuildContext context, String text, IconData icon, String route) {
    final ThemeController themeController = Get.find<ThemeController>();
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ElevatedButton.icon(
        onPressed: () => Get.toNamed(route),
        icon: Icon(icon, size: 26),
        label: Obx(
          () => Text(
            text,
            style: TextStyle(
              color: themeController.isDarkTheme.value
                  ? Colors.white
                  : Colors.black,
              fontWeight: themeController.isDarkTheme.value
                  ? FontWeight.normal
                  : FontWeight.bold,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20),
          textStyle: const TextStyle(fontSize: 18),
          elevation: themeController.isDarkTheme.value
              ? 10
              : 20, // Sombra más profunda en modo claro
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: const BorderSide(color: Colors.lightBlueAccent, width: 2),
          shadowColor: themeController.isDarkTheme.value
              ? Colors.black
              : Colors.grey, // Sombra más pronunciada
        ),
      ),
    );
  }
}
