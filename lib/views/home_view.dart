import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../controllers/theme_controller.dart';

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
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic,
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Obx(
        () => Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: themeController.isDarkTheme.value
                  ? [
                      const Color(0xFF1A1A1A),
                      const Color(0xFF2D2D2D),
                    ]
                  : [
                      const Color(0xFFF5F5F7),
                      const Color(0xFFE8E8E8),
                    ],
            ),
          ),
          child: Stack(
            children: [
              // Burbujas de fondo animadas
              Positioned(
                top: -50,
                right: -30,
                child: AnimatedGradientBubble(
                  size: 200,
                  colors: themeController.isDarkTheme.value
                      ? const [Color(0xFF2D2D2D), Color(0xFF1A1A1A)]
                      : const [Color(0xFFE3E3E3), Color(0xFFF0F0F0)],
                ),
              ),
              Positioned(
                bottom: size.height * 0.3,
                left: -40,
                child: AnimatedGradientBubble(
                  size: 150,
                  colors: themeController.isDarkTheme.value
                      ? const [Color(0xFF2D2D2D), Color(0xFF1A1A1A)]
                      : const [Color(0xFFE3E3E3), Color(0xFFF0F0F0)],
                ),
              ),
              // Contenido principal
              SafeArea(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Modo claro/oscuro
                    GestureDetector(
                      onTap: () => themeController.toggleTheme(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: themeController.isDarkTheme.value
                              ? Colors.black.withOpacity(0.3)
                              : Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              themeController.isDarkTheme.value
                                  ? Icons.dark_mode
                                  : Icons.light_mode,
                              color: themeController.isDarkTheme.value
                                  ? Colors.white
                                  : Colors.black,
                              size: 20,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              themeController.isDarkTheme.value
                                  ? 'Modo Oscuro'
                                  : 'Modo Claro',
                              style: TextStyle(
                                color: themeController.isDarkTheme.value
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    // Logo animado
                    ScaleTransition(
                      scale: _animation,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: themeController.isDarkTheme.value
                              ? Colors.black.withOpacity(0.3)
                              : Colors.white.withOpacity(0.7),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Image.asset(
                          'lib/assets/logo.png',
                          height: 100,
                          width: 100,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Título
                    Text(
                      'Tu Hogar',
                      style: TextStyle(
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        color: themeController.isDarkTheme.value
                            ? Colors.white
                            : Colors.black,
                        letterSpacing: -0.5,
                      ),
                    ),
                    Text(
                      'Nuestro Compromiso',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        color: themeController.isDarkTheme.value
                            ? Colors.white.withOpacity(0.7)
                            : Colors.black.withOpacity(0.7),
                        letterSpacing: -0.5,
                      ),
                    ),
                    const Spacer(),
                    // Botones
                    _buildButton(
                      context,
                      'Iniciar Sesión',
                      Icons.face_rounded,
                      '/login',
                      true,
                    ),
                    const SizedBox(height: 16),
                    _buildButton(
                      context,
                      'Continuar como Invitado',
                      Icons.person_outline_rounded,
                      '/continue',
                      false,
                    ),
                    const SizedBox(height: 16),
                    _buildButton(
                      context,
                      'Crear Nueva Cuenta',
                      Icons.add_rounded,
                      '/registration',
                      false,
                    ),
                    const SizedBox(height: 30),
                    // Footer
                    _buildFooter(themeController),
                    const SizedBox(height: 20),
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
    BuildContext context,
    String text,
    IconData icon,
    String route,
    bool isPrimary,
  ) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      height: 54,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Get.toNamed(route),
              child: Container(
                decoration: BoxDecoration(
                  color: text == 'Continuar como Invitado'
                      ? Colors.black // Botón del medio siempre negro
                      : isPrimary
                          ? Colors.white // Primer botón siempre blanco
                          : (themeController.isDarkTheme.value
                              ? Colors.black.withOpacity(0.3)
                              : Colors.white.withOpacity(0.7)),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: text == 'Continuar como Invitado' || isPrimary
                        ? Colors.transparent
                        : (themeController.isDarkTheme.value
                            ? Colors.white.withOpacity(0.1)
                            : Colors.black.withOpacity(0.1)),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: text == 'Continuar como Invitado'
                          ? Colors
                              .white // Icono blanco para el botón negro del medio
                          : isPrimary
                              ? Colors.black // Icono negro para el botón blanco
                              : (themeController.isDarkTheme.value
                                  ? Colors.white
                                  : Colors.black),
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      text,
                      style: TextStyle(
                        color: text == 'Continuar como Invitado'
                            ? Colors
                                .white // Texto blanco para el botón negro del medio
                            : isPrimary
                                ? Colors
                                    .black // Texto negro para el botón blanco
                                : (themeController.isDarkTheme.value
                                    ? Colors.white
                                    : Colors.black),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildFooter(ThemeController themeController) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      decoration: BoxDecoration(
        color: themeController.isDarkTheme.value
            ? Colors.black.withOpacity(0.3)
            : Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '© DyCIT',
            style: TextStyle(
              color: themeController.isDarkTheme.value
                  ? Colors.white.withOpacity(0.7)
                  : Colors.black.withOpacity(0.7),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Container(
              height: 12,
              width: 1,
              color: themeController.isDarkTheme.value
                  ? Colors.white.withOpacity(0.3)
                  : Colors.black.withOpacity(0.3),
            ),
          ),
          Text(
            'UATF 2024',
            style: TextStyle(
              color: themeController.isDarkTheme.value
                  ? Colors.white.withOpacity(0.7)
                  : Colors.black.withOpacity(0.7),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedGradientBubble extends StatefulWidget {
  final double size;
  final List<Color> colors;

  const AnimatedGradientBubble({
    super.key,
    required this.size,
    required this.colors,
  });

  @override
  _AnimatedGradientBubbleState createState() => _AnimatedGradientBubbleState();
}

class _AnimatedGradientBubbleState extends State<AnimatedGradientBubble>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: widget.colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(_controller.value * 2 * 3.14159),
            ),
          ),
        );
      },
    );
  }
}
