import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_navbar.dart';
import '../views/home_view.dart'; // Asegúrate de importar tu vista de Home

class ContinueView extends StatelessWidget {
  final List<Map<String, dynamic>> servicios = [
    {
      'icon': Icons.electrical_services,
      'label': 'Electricidad',
      'color': Colors.red,
    },
    {
      'icon': Icons.format_paint,
      'label': 'Pintura',
      'color': Colors.purple,
    },
    {
      'icon': Icons.carpenter,
      'label': 'Carpintería',
      'color': Colors.brown,
    },
    {
      'icon': Icons.cleaning_services,
      'label': 'Limpieza',
      'color': Colors.blue,
    },
    {
      'icon': Icons.nature,
      'label': 'Jardinería',
      'color': Colors.green,
    },
    {
      'icon': Icons.local_shipping,
      'label': 'Transporte',
      'color': Colors.orange,
    },
    {
      'icon': Icons.home_repair_service,
      'label': 'Reparaciones',
      'color': Colors.teal,
    },
    {
      'icon': Icons.plumbing,
      'label': 'Plomería',
      'color': Colors.black,
    },
  ];

  ContinueView({super.key});

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
          _buildCarousel(), // El carrusel de servicios
          const SizedBox(height: 20),
          const Text(
            'Últimas Publicaciones',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Expanded(child: _buildAnunciosList()), // Lista de anuncios
        ],
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.black, // Fijo para el modo claro
          selectedItemColor: Theme.of(context).colorScheme.primary, // Color del icono seleccionado
          unselectedItemColor: Theme.of(context).colorScheme.onSurface, // Color de los iconos no seleccionados
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
              Get.off(() => const HomeView()); // Redirigir a HomeView al cerrar sesión
            } else if (index == 1 || index == 2) {
              _showSnackbar('Necesita registrarse', 'Por favor, registrese primero.');
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
          height: 90.0, // Ajusta la altura del carrusel aquí
          enableInfiniteScroll: true,
          autoPlay: false,
          viewportFraction: 0.2, // Cambia esto para ajustar el espacio entre los íconos
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
                          offset: const Offset(0, 2), // Cambia la posición de la sombra
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
                      border: Border.all(color: serviceColor, width: 1), // Borde de color
                      borderRadius: BorderRadius.circular(8), // Bordes redondeados
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

  Widget _buildAnunciosList() {
    final List<Map<String, dynamic>> anuncios = [
      {
        'title': 'SE VENDE LOTE DE TERRENO',
        'date': '4 oct 2024, 11:06:07',
        'description': 'Se ofrece a la venta un lote de terreno ubicado por el Hospital de Tercer Nivel. Referencias al 79440370',
        'icon': Icons.phone,
        'iconColor': Colors.green, // Color específico para el icono
      },
      {
        'title': 'SE REQUIERE AYUDANTE DE CONSTRUCCIÓN',
        'date': '4 oct 2024, 11:04:07',
        'description': 'Se requiere ayudante de construcción. Referencias al 68746145',
        'icon': Icons.message,
        'iconColor': Colors.blue, // Color específico para el icono
      },
      {
        'title': 'SE VENDE AUTO USADO',
        'date': '4 oct 2024, 12:00:00',
        'description': 'Vendo auto usado en buenas condiciones. Referencias al 123456789.',
        'icon': Icons.directions_car,
        'iconColor': Colors.red, // Color específico para el icono
      },
      {
        'title': 'SE ALQUILA OFICINA',
        'date': '4 oct 2024, 12:30:00',
        'description': 'Se alquila oficina en el centro de la ciudad. Interesados llamar al 987654321.',
        'icon': Icons.business,
        'iconColor': Colors.orange, // Color específico para el icono
      },
    ];

    return ListView.builder(
      itemCount: anuncios.length,
      itemBuilder: (context, index) {
        final anuncio = anuncios[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(anuncio['icon'], size: 24, color: anuncio['iconColor']), // Icono del anuncio
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        anuncio['title'],
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        anuncio['date'],
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        anuncio['description'],
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black, // Fondo elegante claro
      colorText: Colors.white,
      margin: const EdgeInsets.all(60),
      duration: const Duration(seconds: 3),
    );
  }
}
