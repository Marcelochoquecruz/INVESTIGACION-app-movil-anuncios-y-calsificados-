// lib/routes/app_routes.dart
import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/continue_view.dart';
import '../views/registration_view.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => HomeView()),
    GetPage(name: '/login', page: () => LoginView()),
    GetPage(name: '/continue', page: () => ContinueView()),
    GetPage(name: '/registration', page: () => RegistrationView()),
  ];
}
