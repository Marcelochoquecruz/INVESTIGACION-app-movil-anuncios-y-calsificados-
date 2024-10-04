// lib/routes/app_routes.dart
import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/continue_view.dart';
import '../views/registration_view.dart';
import '../views/about_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => const HomeView()),
    GetPage(name: '/login', page: () => const LoginView()),
    GetPage(name: '/continue', page: () => const ContinueView()),
    GetPage(name: '/registration', page: () => const RegistrationView()),
    GetPage(name: '/about', page: () => const AboutView()),
  ];
}
