import 'package:anuncios_domicilio/views/ultimos_anuncios_view.dart';
import 'package:anuncios_domicilio/widgets/custom_navbar.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/radio_view.dart'; // Importa la vista de Radio

class ContinueView extends StatefulWidget {
  const ContinueView({super.key});

  @override
  _ContinueViewState createState() => _ContinueViewState();
}

class _ContinueViewState extends State<ContinueView> {
  int _selectedIndex = 0; // Índice seleccionado del BottomNavigationBar

  final List<Widget> _views = [
    const UltimosAnunciosView(), // Pantalla de Inicio
    Center(child: Text('Perfil')), // Placeholder para Perfil
    Center(child: Text('Chat')), // Placeholder para Chat
    const RadioView(), // Vista de Radio
    Center(child: Text('Cerrar Sesión')), // Placeholder para Logout
  ];

  void _onItemTapped(int index) {
    if (index == 1 || index == 2) {
      _showSnackbar('Necesita registrarse', 'Por favor, registrese primero.');
      return;
    }
    setState(() {
      _selectedIndex = index; // Actualiza el índice seleccionado
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(
        title: "Nuestros Anuncios y Clasificados",
      ),
      backgroundColor: Colors.white,
      body: IndexedStack(
        index: _selectedIndex,
        children: _views,
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildCarousel(dynamic servicios) {
    return Container(
      color: Colors.blue.shade50,
      height: 120,
      child: CarouselSlider.builder(
        itemCount: servicios.length,
        itemBuilder: (BuildContext context, int index, int realIndex) {
          final service = servicios[index];
          return _buildCarouselItem(service);
        },
        options: CarouselOptions(
          height: 120,
          viewportFraction: 0.25,
          enableInfiniteScroll: true,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }

  Widget _buildCarouselItem(Map<String, dynamic> service) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.transparent,
            child: Icon(
              service['icon'],
              size: 30,
              color: service['color'],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            border: Border.all(color: service['color'], width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            service['label'],
            style: TextStyle(color: service['color'], fontSize: 12),
          ),
        ),
      ],
    );
  }

  Widget _buildAnunciosList() {
    final List<Map<String, dynamic>> anuncios = [
      {
        'title': 'SE VENDE LOTE DE TERRENO',
        'date': '4 oct 2024, 11:06:07',
        'description':
            'Se ofrece a la venta un lote de terreno cerca del hospital.',
        'icon': Icons.phone,
        'iconColor': Colors.green,
      },
      {
        'title': 'SE REQUIERE AYUDANTE DE CONSTRUCCIÓN',
        'date': '4 oct 2024, 11:04:07',
        'description': 'Se busca ayudante con experiencia. Llamar al 68746145.',
        'icon': Icons.message,
        'iconColor': Colors.blue,
      },
      {
        'title': 'SE VENDE AUTO USADO',
        'date': '4 oct 2024, 12:00:00',
        'description': 'Auto usado en buen estado. Interesados: 123456789.',
        'icon': Icons.directions_car,
        'iconColor': Colors.red,
      },
      {
        'title': 'SE ALQUILA OFICINA',
        'date': '4 oct 2024, 12:30:00',
        'description':
            'Oficina en el centro de la ciudad. Contacto: 987654321.',
        'icon': Icons.business,
        'iconColor': Colors.orange,
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
                Icon(anuncio['icon'], size: 24, color: anuncio['iconColor']),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(anuncio['title'],
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(anuncio['date'],
                          style: TextStyle(color: Colors.grey.shade600)),
                      const SizedBox(height: 4),
                      Text(anuncio['description'],
                          style: const TextStyle(fontSize: 16)),
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

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      selectedItemColor: Theme.of(context).colorScheme.primary,
      unselectedItemColor: Theme.of(context).colorScheme.onSurface,
      currentIndex: _selectedIndex, // Índice actual
      onTap: _onItemTapped, // Actualiza el índice
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
        BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
        BottomNavigationBarItem(icon: Icon(Icons.radio, color: Colors.red), label: 'Radio'), // Cambiar color a amarillo
        BottomNavigationBarItem(
            icon: Icon(Icons.logout), label: 'Cerrar Sesión'),
      ],
    );
  }

  void _showSnackbar(String title, String message) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black,
      colorText: Colors.white,
      margin: const EdgeInsets.all(60),
      duration: const Duration(seconds: 3),
    );
  }
}
