import 'package:anuncios_domicilio/views/main_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/custom_navbar.dart';

class AppColors {
  static const Color lightGrey = Color(0x4DD3D3D3);
  static const Color blueAccent = Colors.blueAccent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color lightBlueAccent = Colors.lightBlueAccent;
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isPasswordVisible =
      false; // Controlador para mostrar/ocultar la contraseña

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(title: 'Bienvenido de vuelta'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 30), // Espacio superior
              const Text(
                'Ingresa tus datos',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.blueAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30), // Espacio entre título y primer campo
              _buildTextField('Correo Electrónico', Icons.email),
              const SizedBox(height: 20), // Espacio entre campos
              _buildPasswordField('Contraseña', Icons.lock), // Cambié aquí
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Implementar lógica para olvidé mi contraseña
                  },
                  child: const Text(
                    'Olvidé mi contraseña',
                    style: TextStyle(
                      color: AppColors.blueAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Get.to(() => const MainView());
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 44, 49, 59),
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text('Ingresar', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 30), // Espacio entre botón y divisor
              _buildDivider(),
              const SizedBox(
                  height: 10), // Espacio entre divisor y botones sociales
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialButton(
                      'Google', 'lib/assets/google.png', 'Google'),
                  _buildSocialButton(
                      'Facebook', 'lib/assets/facebook.png', 'Facebook'),
                ],
              ),
              const SizedBox(
                  height:
                      10), // Espacio entre botones sociales y pregunta de registro
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('¿No tienes una cuenta?',
                      style: TextStyle(color: AppColors.blueAccent)),
                  TextButton(
                    onPressed: () {
                      // Navegar a la pantalla de registro
                    },
                    child: const Text('Regístrate',
                        style:
                            TextStyle(color: Color.fromARGB(255, 223, 80, 70))),
                  ),
                ],
              ),
              const SizedBox(height: 30), // Espacio inferior antes del final
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.blueAccent),
        ),
        filled: true,
        fillColor: AppColors.lightGrey.withOpacity(0.1),
      ),
    );
  }

  // Campo de contraseña con la funcionalidad de mostrar/ocultar
  Widget _buildPasswordField(String label, IconData icon) {
    return TextField(
      obscureText: !_isPasswordVisible,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.blueAccent),
        suffixIcon: IconButton(
          icon: Icon(
            _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.blueAccent,
          ),
          onPressed: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: AppColors.blueAccent),
        ),
        filled: true,
        fillColor: AppColors.lightGrey.withOpacity(0.1),
      ),
    );
  }

  Widget _buildDivider() {
    return const Row(
      children: [
        Expanded(child: Divider(color: AppColors.blueAccent)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text('O', style: TextStyle(color: AppColors.blueAccent)),
        ),
        Expanded(child: Divider(color: AppColors.blueAccent)),
      ],
    );
  }

  Widget _buildSocialButton(String text, String assetPath, String socialName) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Implementar lógica de inicio de sesión con redes sociales
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
              side: const BorderSide(color: AppColors.lightGrey, width: 1),
            ),
            elevation: 5,
          ),
          child: Row(
            children: [
              Image.asset(
                assetPath,
                height: 40,
                width: 40,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8), // Espacio entre el botón y el texto
        Text(
          socialName,
          style: const TextStyle(
            fontSize: 12, // Texto pequeño
            color: Color.fromARGB(255, 29, 21, 21),
          ),
        ),
      ],
    );
  }
}
