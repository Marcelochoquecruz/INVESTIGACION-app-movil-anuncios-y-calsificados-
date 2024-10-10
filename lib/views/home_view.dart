import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class WaveShape extends CustomPainter {
  final bool isShadow;

  WaveShape({this.isShadow = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isShadow
          ? Colors.black.withOpacity(0.5) // Color del borde sombreado
          : Colors.white.withOpacity(0.8) // Color de la figura interna
      ..style = PaintingStyle.fill;

    final path = Path();

    // Dibujo de la curva
    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.8,
        size.width * 0.5, size.height * 0.9);
    path.quadraticBezierTo(
        size.width * 0.75, size.height, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    // Dibujo en el lienzo
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Scaffold(
      body: Obx(
        () => Container(
          // Fondo sin degradado
          color: themeController.isDarkTheme.value
              ? Colors.grey.shade900 // Color de fondo para tema oscuro
              : const Color.fromARGB(255, 197, 230, 231), // Color de fondo para tema claro
          child: Stack(
            children: [
              // Sombra externa
              CustomPaint(
                painter:
                    WaveShape(isShadow: true), // Pintamos el borde sombreado
                child: Container(
                  height: MediaQuery.of(context).size.height +
                      10, // Un poco más grande para el sombreado
                ),
              ),
              // Figura original
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
                    const SizedBox(height: 35),
                    // Eslogan de la app
                    Text(
                      'Tu Hogar, nuestro compromiso.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: themeController.isDarkTheme.value
                            ? Colors.black // Texto oscuro en tema oscuro
                            : const Color.fromARGB(
                                255, 33, 33, 33), // Texto oscuro en tema claro
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                        height: 30), // Aumentamos el espacio superior
                    // Icono del sol/luna con textos "Día" y "Noche"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: _animation,
                          child: IconButton(
                            icon: Icon(
                              themeController.isDarkTheme.value
                                  ? Icons
                                      .dark_mode // Otra luna para tema oscuro
                                  : Icons.wb_sunny, // Sol para tema claro
                              color: themeController.isDarkTheme.value
                                  ? Colors.blue
                                  : Colors.blueGrey,
                            ),
                            onPressed: () => themeController.toggleTheme(),
                            iconSize: 25, // Tamaño del icono más grande
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          themeController.isDarkTheme.value
                              ? '¡De noche!'
                              : '¡De día!', // Cambia el texto
                          style: TextStyle(
                            fontSize: 15, // Tamaño más grande del texto
                            color: themeController.isDarkTheme.value
                                ? Colors.black87
                                : Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 20), // Espacio entre el icono y el logo
                    // Logo de la app
                    Image.asset(
                      'lib/assets/logo.png',
                      height: 110,
                    ),
                    const SizedBox(height: 40),
                    _buildButton(
                        context, 'Iniciar Sesión', Icons.lock, '/login'),
                    const SizedBox(height: 30),
                    _buildButton(context, 'Continuar sin Registrarse',
                        Icons.input, '/continue'),
                    const SizedBox(height: 30),
                    _buildButton(context, 'Crear Cuenta', Icons.person_add,
                        '/registration'),
                    const SizedBox(height: 80),
                    // Pie de página
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          '© DyCIT-2024',
                          style: TextStyle(
                            fontSize: 13,
                            color: themeController.isDarkTheme.value
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        Text(
                          '© UATF-2024',
                          style: TextStyle(
                            fontSize: 13,
                            color: themeController.isDarkTheme.value
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
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
              
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: themeController.isDarkTheme.value
              ? Colors.grey.shade900
              : const Color.fromARGB(255, 255, 255, 255),
          padding: const EdgeInsets.symmetric(vertical: 20),
          textStyle: const TextStyle(fontSize: 18),
          elevation: themeController.isDarkTheme.value ? 10 : 20,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          side: const BorderSide(color: Colors.lightBlueAccent, width: 1),
          shadowColor:
              themeController.isDarkTheme.value ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
