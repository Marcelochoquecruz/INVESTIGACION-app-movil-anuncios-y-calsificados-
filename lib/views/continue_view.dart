import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/custom_navbar.dart';
import '../views/home_view.dart'; // Asegúrate de importar tu vista de Home

class ContinueView extends StatelessWidget {
  final List<Map<String, dynamic>> servicios = [
    {
      'icon': Icons.electrical_services,
      'label': 'Electricidad',
      'color': Colors.red
    },
    {'icon': Icons.format_paint, 'label': 'Pintura', 'color': Colors.purple},
    {'icon': Icons.carpenter, 'label': 'Carpintería', 'color': Colors.brown},
    {
      'icon': Icons.cleaning_services,
      'label': 'Limpieza',
      'color': Colors.blue
    },
    {'icon': Icons.nature, 'label': 'Jardinería', 'color': Colors.green},
    {
      'icon': Icons.local_shipping,
      'label': 'Transporte',
      'color': Colors.orange
    },
    {
      'icon': Icons.home_repair_service,
      'label': 'Reparaciones',
      'color': Colors.teal
    },
    {'icon': Icons.build, 'label': 'Mantenimiento', 'color': Colors.indigo},
    {'icon': Icons.plumbing, 'label': 'Plomería', 'color': Colors.black},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(
        title: "Nuestros Anuncios y Clasificados",
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const SizedBox(height: 10),
          _buildCarousel(), // El carrusel debe estar visible
          const SizedBox(height: 20),
          const Text(
            'Últimas Publicaciones',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const Expanded(child: Center(child: Text('CARDS DE ANUCIOS.'))),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white, // Fijo para el modo claro
          selectedItemColor: Colors.deepPurple, // Color del icono seleccionado
          unselectedItemColor:
              Colors.black87, // Color de los iconos no seleccionados
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Perfil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.logout), // Cambiado a icono de cerrar sesión
              label: 'Cerrar Sesión',
            ),
          ],
          onTap: (index) {
            if (index == 3) {
              Get.off(
                  () => HomeView()); // Redirigir a HomeView al cerrar sesión
            } else if (index == 1 || index == 2) {
              _showSnackbar(
                  'Necesita registrarse', 'Por favor, registrese primero.');
            }
          },
        ),
      ),
    );
  }

  Widget _buildCarousel() {
    return Container(
      color: Colors.blue.shade50, // Fondo del carrusel
      child: CarouselSlider(
        options: CarouselOptions(
          height: 80.0, // Ajusta la altura del carrusel
          enableInfiniteScroll: true,
          autoPlay: false,
          viewportFraction:
              0.2, // Cambia esto para ajustar el espacio entre los íconos
        ),
        items: servicios.map((service) {
          return Builder(
            builder: (BuildContext context) {
              Color serviceColor = service['color']; // Usar color fijo
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white, // Fondo claro para el icono
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset:
                              Offset(0, 2), // Cambia la posición de la sombra
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 25, // Ajusta el tamaño del icono
                      backgroundColor: Colors.transparent, // Fondo transparente
                      child: IconButton(
                        icon: Icon(
                          service['icon'],
                          size: 24, // Tamaño del icono
                          color: serviceColor, // Color del icono
                        ),
                        onPressed: () {
                          // Enlace muerto
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: serviceColor, width: 1), // Borde de color
                      borderRadius:
                          BorderRadius.circular(8), // Bordes redondeados
                    ),
                    child: Text(
                      service['label'],
                      style: TextStyle(color: serviceColor), // Color de texto
                    ),
                  ),
                ],
              );
            },
          );
        }).toList(),
      ),
    );
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.black, // Fondo elegante claro
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 3),
    );
  }
}
