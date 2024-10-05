import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AppColors {
  static const Color lightGrey = Color(0x4DD3D3D3);
  static const Color blueAccent = Colors.blueAccent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color lightBlueAccent = Colors.lightBlueAccent;
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(title: 'Iniciar Sesión'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Text(
                'Bienvenido de vuelta',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.black,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              _buildTextField('Correo Electrónico', Icons.email),
              const SizedBox(height: 20),
              _buildTextField('Contraseña', Icons.lock, isPassword: true),
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Implementar lógica para olvidé mi contraseña
                  },
                  child: Text(
                    'Olvidé mi contraseña',
                    style: TextStyle(color: AppColors.blueAccent),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  // Implementar lógica de inicio de sesión
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.blueAccent,
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 5,
                ),
                child: const Text('Ingresar', style: TextStyle(fontSize: 18)),
              ),
              const SizedBox(height: 30),
              _buildDivider(),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildSocialButton(
                    'Google',
                    FontAwesomeIcons.google,
                    Colors.red,
                  ),
                  _buildSocialButton(
                    'Facebook',
                    FontAwesomeIcons.facebook,
                    Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('¿No tienes una cuenta?',
                      style: TextStyle(color: AppColors.black)),
                  TextButton(
                    onPressed: () {
                      // Navegar a la pantalla de registro
                    },
                    child: Text('Regístrate',
                        style: TextStyle(color: AppColors.blueAccent)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, IconData icon,
      {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: AppColors.blueAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: AppColors.blueAccent),
        ),
        filled: true,
        fillColor: AppColors.lightGrey.withOpacity(0.1),
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: AppColors.lightGrey)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text('O', style: TextStyle(color: AppColors.black)),
        ),
        Expanded(child: Divider(color: AppColors.lightGrey)),
      ],
    );
  }

  Widget _buildSocialButton(String text, IconData icon, Color color) {
    return ElevatedButton.icon(
      onPressed: () {
        // Implementar lógica de inicio de sesión con redes sociales
      },
      icon: FaIcon(icon, color: AppColors.white),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
