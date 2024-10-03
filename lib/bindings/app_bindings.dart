import 'package:get/get.dart';
import '../controllers/theme_controller.dart';
import '../controllers/auth_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ThemeController>(() => ThemeController());
    Get.lazyPut<AuthController>(() => AuthController());
  }
}
