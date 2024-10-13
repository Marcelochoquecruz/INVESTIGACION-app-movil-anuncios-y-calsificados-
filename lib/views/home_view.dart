import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/theme_controller.dart';

class WaveShape extends CustomPainter {
  final bool isShadow;

  WaveShape({this.isShadow = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..shader = isShadow
          ? const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(255, 45, 14, 87), Color.fromARGB(255, 9, 2, 41)],
            ).createShader(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)))
          : const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color.fromARGB(115, 172, 134, 238), Color.fromARGB(255, 243, 243, 247)],
            ).createShader(Rect.fromPoints(Offset.zero, Offset(size.width, size.height)))
      ..style = PaintingStyle.fill;

    final path = Path();

    // Dibujo de la curva de izquierda a derecha
    // Inicio en el punto (0, tamaño de la altura)
    path.moveTo(0, size.height);
    // Curva cuadrática pasando por el punto (ancho del tamaño * 0.25, altura del tamaño * 0.8)
    path.quadraticBezierTo(size.width * 0.100, size.height * 0.8,
        // Curva cuadrática pasando por el punto (ancho del tamaño * 0.5, altura del tamaño * 0.9)
        size.width * 0.5, size.height * 0.9);
    // Curva cuadrática pasando por el punto (ancho del tamaño * 0.75, tamaño de la altura)
    path.quadraticBezierTo(
        size.width * 0.75, size.height, 
        // Línea recta al punto (ancho del tamaño, altura del tamaño * 0.8)
        size.width, size.height * 0.8);
    // Línea recta al punto (ancho del tamaño, 0)
    path.lineTo(size.width, 0);
    // Línea recta al punto (0, 0)
    path.lineTo(0, 0);
    // Cierre del camino
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
          // Fondo con degradado
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: themeController.isDarkTheme.value
                  ? [Colors.deepPurple[700]!, Colors.deepPurple[300]!] // Degradado para tema oscuro
                  : [
                      Colors.deepPurple[700]!,
                      Colors.deepPurple[300]!
                    ], // Degradado para tema claro
            ),
          ),
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
                    const SizedBox(height: 10),
                    // Eslogan de la app
                    Text(
                      'Tu Hogar\n Nuestro compromiso',
                      style: TextStyle(
                        //fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: themeController.isDarkTheme.value
                            ? Colors.white// Texto azul oscuro en tema oscuro
                            : Colors.black, // Texto oscuro en tema claro
                        fontStyle: FontStyle.italic, // Estilo de letra cursiva
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                        height: 10), // Aumentamos el espacio superior
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
                                  ? Colors.black
                                  : Colors.black,
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
                            fontSize: 10, // Tamaño más grande del texto
                            color: themeController.isDarkTheme.value
                                ? Colors.black87
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                        height: 10), // Espacio entre el icono y el logo
                    // Logo de la app
                    Image.asset(
                      'lib/assets/logo.png',
                      height: 110,
                    ),
                    const SizedBox(height: 20),
                    _buildButton(
                        context, 'Iniciar Sesión', Icons.lock, '/login'),
                    const SizedBox(height: 30),
                    _buildButton(context, 'Continuar sin Registrarse',
                        Icons.input, '/continue'),
                    const SizedBox(height: 30),
                    _buildButton(context, 'Crear Cuenta', Icons.person_add,
                        '/registration'),
                    const SizedBox(height: 110),
                    // Pie de página
                    _buildFooter(themeController), // Reemplazado por el nuevo widget
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
                  : Colors.black, // Esteo es para cambiar el color de los textos botones
              
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

  Widget _buildFooter(ThemeController themeController) {
    final footerTextStyle = TextStyle(
      fontSize: 10,
      color: themeController.isDarkTheme.value ? Colors.white : Colors.black,
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text('© DyCIT-2024', style: footerTextStyle),
        Text('© UATF-2024', style: footerTextStyle),
      ],
    );
  }
}
