import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class WaveShape extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path();

    path.moveTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.8,
        size.width * 0.5, size.height * 0.9);
    path.quadraticBezierTo(
        size.width * 0.75, size.height, size.width, size.height * 0.8);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();

    path.addOval(Rect.fromCircle(
        center: Offset(size.width * 0.8, size.height * 0.2),
        radius: size.width * 0.08));

    path.moveTo(0, size.height * 0.6);
    path.lineTo(size.width, size.height * 0.6);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

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
    )..repeat(reverse: true); // Repetir la animación en reversa

    _animation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Suave en ambos sentidos
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
                          'Tu Hogar, nuestro compromiso.',
                          style: TextStyle(
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: themeController.isDarkTheme.value
                                ? Colors.white
                                : const Color.fromARGB(255, 65, 58, 124),
                          ),
                          textAlign: TextAlign.center,
                        )),
                    const SizedBox(height: 20),
                    // Fila que contiene el logo
                    Image.asset(
                      'lib/assets/logo.png',
                      height: 110, // Cambié el tamaño a 110
                    ),
                    const SizedBox(
                        height: 20), // Espacio entre el logo y el ícono
                    // Ícono del teléfono y texto "¡Llamame!"
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ScaleTransition(
                          scale: _animation,
                          child: IconButton(
                            icon: Obx(() => Icon(
                                  themeController.isDarkTheme.value
                                      ? Icons.phone_android
                                      : Icons.phone_iphone,
                                  color: Colors
                                      .black, // Cambiamos el color a negro
                                )),
                            onPressed: () => themeController.toggleTheme(),
                            iconSize: 50,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '¡Llamame!',
                          style: TextStyle(
                            fontSize: 20,
                            color: themeController.isDarkTheme.value
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    _buildButton(
                        context, 'Iniciar Sesión', Icons.lock, '/login'),
                    const SizedBox(height: 20),
                    _buildButton(context, 'Continuar sin Registrarse',
                        Icons.input, '/continue'),
                    const SizedBox(height: 20),
                    _buildButton(context, 'Crear Cuenta', Icons.person_add,
                        '/registration'),
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
