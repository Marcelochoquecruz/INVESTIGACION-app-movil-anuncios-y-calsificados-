import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import 'dart:math' as math;

// AnimatedIconButton Widget
class AnimatedIconButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final Color iconColor;

  const AnimatedIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    required this.iconColor,
  }) : super(key: key);

  @override
  _AnimatedIconButtonState createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
    _animation = Tween<double>(begin: 0, end: 2 * math.pi).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return CustomPaint(
            painter: CircleAnimationPainter(_animation.value, widget.iconColor),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(widget.icon, size: 30, color: widget.iconColor),
            ),
          );
        },
      ),
    );
  }
}

class CircleAnimationPainter extends CustomPainter {
  final double angle;
  final Color color;

  CircleAnimationPainter(this.angle, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      angle,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

// HomeView Widget
class HomeView extends StatelessWidget {
  final ThemeController _themeController = Get.find();

  HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Eslogan encima del ícono de cambio de tema
            Obx(() => Text(
                  "La app que cuida tu hogar, donde tú estés.",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _themeController.isDarkMode.value
                        ? Colors.white70
                        : Color.fromARGB(255, 24, 54, 80),
                  ),
                )),
            const SizedBox(height: 20),

            // AnimatedIconButton para cambio de tema
            Obx(() => AnimatedIconButton(
                  icon: _themeController.isDarkMode.value
                      ? Icons.bedtime
                      : Icons.wb_sunny,
                  iconColor: _themeController.isDarkMode.value
                      ? Colors.yellowAccent
                      : Color.fromARGB(255, 24, 54, 80),
                  onPressed: () {
                    _themeController.toggleTheme();
                  },
                )),

            // Logo de la aplicación
            Image.asset(
              'lib/assets/logo1.png',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 5),

            // Línea divisora que cambia de color según el tema
            Obx(() => Divider(
                  color: _themeController.isDarkMode.value
                      ? Colors.white70
                      : Colors.black87,
                  thickness: 0.5,
                  indent: 100,
                  endIndent: 100,
                )),
            const SizedBox(height: 20),

            // Botón "Iniciar Sesión"
            _buildElevatedButton(
              icon: Icons.login,
              text: 'Iniciar Sesión',
              onPressed: () => Get.toNamed('/login'),
            ),
            const SizedBox(height: 20),

            // Botón "Continuar sin Registrarse"
            _buildElevatedButton(
              icon: Icons.person_outline,
              text: 'Continuar sin Registrarse',
              onPressed: () => Get.toNamed('/continue'),
            ),
            const SizedBox(height: 20),

            // Botón "Crear mi Cuenta"
            _buildElevatedButton(
              icon: Icons.person_add,
              text: 'Crear mi Cuenta',
              onPressed: () => Get.toNamed('/registration'),
            ),
            const SizedBox(height: 30),

            // Segunda línea divisora que cambia de color según el tema
            Obx(() => Divider(
                  color: _themeController.isDarkMode.value
                      ? Colors.white70
                      : Colors.black87,
                  thickness: 1,
                  indent: 100,
                  endIndent: 100,
                )),
            const SizedBox(height: 10),

            // Línea de copyright con colores que cambian según el tema
            Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100),
                      child: Text(
                        "©copyright DICyT-2024",
                        style: TextStyle(
                          color: _themeController.isDarkMode.value
                              ? Colors.white70
                              : Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100),
                      child: Text(
                        "©copyright UATF-2024",
                        style: TextStyle(
                          color: _themeController.isDarkMode.value
                              ? Colors.white70
                              : Colors.black87,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }

  // Método para construir un botón elevado con un ícono y texto
  Widget _buildElevatedButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: 320,
      child: Obx(() => ElevatedButton.icon(
            onPressed: onPressed,
            icon: Icon(
              icon,
              color: _themeController.isDarkMode.value
                  ? Colors.black87
                  : Colors.white70,
            ),
            label: Text(
              text,
              style: TextStyle(
                fontSize: 20,
                color: _themeController.isDarkMode.value
                    ? Colors.black
                    : Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              backgroundColor: _themeController.isDarkMode.value
                  ? Colors.white
                  : const Color.fromARGB(255, 24, 54, 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: _themeController.isDarkMode.value
                      ? const Color.fromARGB(255, 3, 3, 3)
                      : Colors.black87,
                ),
              ),
            ),
          )),
    );
  }
}
