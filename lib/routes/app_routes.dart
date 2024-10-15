import 'package:get/get.dart';
import '../views/home_view.dart'; // Mantenemos HomeView
import '../views/ultimos_anuncios_view.dart'; // Nueva vista de Últimos Anuncios
import '../views/login_view.dart';
import '../views/continue_view.dart';
import '../views/registration_view.dart';
import '../views/about_view.dart';
import '../views/profile_view.dart';
import '../views/announcement_view.dart';
import '../views/chat_view.dart';
import '../views/main_view.dart'; // Vista principal
import '../views/radio_view.dart'; // Nueva vista de Radio

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomeView()), // Ruta principal
    GetPage(
        name: '/ultimos_anuncios',
        page: () =>
            const UltimosAnunciosView()), // Nueva ruta para Últimos Anuncios
    GetPage(name: '/login', page: () => const LoginView()),
    GetPage(name: '/continue', page: () => const ContinueView()),
    GetPage(name: '/registration', page: () => const RegistrationView()),
    GetPage(name: '/about', page: () => const AboutView()),
    GetPage(
        name: '/profile', page: () => const ProfileView()), // Ruta para perfil
    GetPage(
        name: '/announcement',
        page: () => const AnnouncementView()), // Ruta para anuncios
    GetPage(name: '/chat', page: () => const ChatView()), // Ruta para chat
    GetPage(
        name: '/main',
        page: () =>
            const MainView()), // Ruta para la vista principal con NavigationBar
    GetPage(
        name: '/radio', page: () => const RadioView()), // Nueva ruta para Radio
  ];
}
