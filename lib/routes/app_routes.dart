import 'package:get/get.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/registration_view.dart';
import '../views/continue_view.dart';

class AppRoutes {
  static const String home = '/';
  static const String login = '/login';
  static const String registration = '/registration';
  static const String continueWithoutRegistering = '/continue';

  static List<GetPage> routes = [
    GetPage(name: home, page: () => HomeView()),
    GetPage(name: login, page: () => const LoginView()),
    GetPage(name: registration, page: () => const RegistrationView()),
    GetPage(name: continueWithoutRegistering, page: () => const ContinueView()),
  ];
}
