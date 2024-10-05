import 'package:flutter/material.dart';
import '../widgets/custom_navbar.dart';

class AppColors {
  static const Color lightGrey = Color(0x4DD3D3D3);
  static const Color blueAccent = Colors.blueAccent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color lightBlueAccent = Colors.lightBlueAccent;
}

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(title: 'Únete a nosotros'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding para el contenedor
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 14), // Espacio superior
              const Text(
                'Ingresa tus datos',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.blueAccent,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20), // Espacio entre el texto y el primer campo
              _buildTextField('Nombre completo', Icons.person),
              const SizedBox(height: 10), // Espacio entre los campos
              _buildTextField('Correo Electrónico', Icons.email),
              const SizedBox(height: 10), // Espacio entre los campos
              _buildPasswordField('Contraseña', _isPasswordVisible),
              const SizedBox(height: 10), // Espacio entre los campos
              _buildPasswordField('Confirmar Contraseña', _isConfirmPasswordVisible),
              const SizedBox(height: 20), // Espacio antes del botón de crear cuenta
              ElevatedButton(
                onPressed: () {
                  // Implementar lógica de creación de cuenta
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 40, 47, 51),
                  foregroundColor: AppColors.white,
                  padding: const EdgeInsets.symmetric(vertical: 10), // Ajustar padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                ),
                child: const Text('Crear Cuenta', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 20), // Espacio después del botón
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton('Google', 'lib/assets/google.png'),
                  const SizedBox(width: 10), // Espacio entre botones sociales
                  _buildSocialButton('Facebook', 'lib/assets/facebook.png'),
                ],
              ),
              const SizedBox(height: 20), // Espacio después de los botones sociales
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
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(color: AppColors.blueAccent),
        ),
        filled: true,
        fillColor: AppColors.lightGrey.withOpacity(0.1),
      ),
    );
  }

  Widget _buildPasswordField(String label, bool isVisible) {
    return TextField(
      obscureText: !isVisible,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(Icons.lock, color: AppColors.blueAccent), // Icono de candado
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off,
            color: AppColors.blueAccent,
          ),
          onPressed: () {
            setState(() {
              if (label == 'Contraseña') {
                _isPasswordVisible = !_isPasswordVisible;
              } else {
                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
              }
            });
          },
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Ajuste del borde
          borderSide: const BorderSide(color: AppColors.lightGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), // Ajuste del borde
          borderSide: const BorderSide(color: AppColors.blueAccent),
        ),
        filled: true,
        fillColor: AppColors.lightGrey.withOpacity(0.1),
      ),
    );
  }

  Widget _buildSocialButton(String text, String assetPath) {
    return ElevatedButton(
      onPressed: () {
        // Implementar lógica de inicio de sesión con redes sociales
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        padding: const EdgeInsets.symmetric(
            horizontal: 20, vertical: 16), // Ajuste del padding
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
          const SizedBox(width: 10), // Espacio entre el icono y el texto
          Text(text),
        ],
      ),
    );
  }
}
