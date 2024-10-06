import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart'; // Importamos CustomNavBar
import '../views/ultimos_anuncios_view.dart'; // Importamos UltimosAnunciosView
import '../views/profile_view.dart';
import '../views/chat_view.dart';
import '../views/announcement_view.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const UltimosAnunciosView(), // Página de Últimos Anuncios
    const AnnouncementView(), // Página de Anunciar
    const ChatView(), // Página de Chat
    const ProfileView(), // Página de Perfil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(title: 'Nuestros Anuncios y Clasificados'),
      body: _pages[_currentIndex], // Mostramos la página correspondiente
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign),
            label: 'Anunciar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
