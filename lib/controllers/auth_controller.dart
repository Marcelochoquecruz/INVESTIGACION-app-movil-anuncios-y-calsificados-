import 'package:get/get.dart';

class AuthController extends GetxController {
  // Aquí podrías manejar la autenticación
  void login() {
    // Lógica para iniciar sesión
    Get.toNamed('/login');
  }

  void continueWithoutLogin() {
    // Lógica para continuar sin registrarse
    Get.toNamed('/continue');
  }

  void register() {
    // Lógica para registro
    Get.toNamed('/register');
  }
}
