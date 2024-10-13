import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anuncios_domicilio/widgets/custom_navbar.dart';

class RegistrationView extends StatefulWidget {
  const RegistrationView({super.key});

  @override
  _RegistrationViewState createState() => _RegistrationViewState();
}

class _RegistrationViewState extends State<RegistrationView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureText = true;

  // Lista de colores claros para los íconos
  final List<Color> _iconColors = [
    Colors.white70, // Color para el correo
    Colors.white70, // Color para la contraseña
    Colors.white70, // Color para la confirmación de contraseña
  ];

  // Función para registrar un usuario
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        _showErrorSnackBar('Las contraseñas no coinciden');
        return;
      }

      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());
        _showSuccessSnackBar('Cuenta creada exitosamente');
        Get.offAllNamed(
            '/main'); // Redirigir a la vista principal tras el registro
      } on FirebaseAuthException catch (e) {
        _showErrorSnackBar(e.message ?? 'Error al registrar la cuenta');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(16.0), // Aumenta la altura
          child: Text(
            message,
            style: const TextStyle(
                fontSize: 18, color: Colors.white), // Tamaño de texto grande
          ),
        ),
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating, // Hace que el SnackBar flote
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(16.0), // Aumenta la altura
          child: Text(
            message,
            style: const TextStyle(
                fontSize: 18, color: Colors.white), // Tamaño de texto grande
          ),
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 5),
        behavior: SnackBarBehavior.floating, // Hace que el SnackBar flote
      ),
    );
  }

  // Estilo de las líneas de texto
  UnderlineInputBorder _buildUnderlineBorder(Color color) {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: color, width: 2),
    );
  }

  // Función para obtener el color dinámicamente según el tema
  Color _getTextColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? Colors.white // Cambiado a white para el tema oscuro
        : Colors.black; // Color negro para el tema claro
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(title: 'Registro'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),

                // Campo de correo electrónico
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: _getTextColor(context)),
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    labelStyle: TextStyle(color: _getTextColor(context)),
                    prefixIcon: const Icon(Icons.email,
                        color: Colors.blue), // Color del ícono
                    enabledBorder: _buildUnderlineBorder(Colors.deepPurple),
                    focusedBorder:
                        _buildUnderlineBorder(Colors.deepPurpleAccent),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un correo válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Campo de contraseña
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscureText,
                  style: TextStyle(color: _getTextColor(context)),
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle: TextStyle(color: _getTextColor(context)),
                    prefixIcon: const Icon(Icons.lock,
                        color: Colors.lightBlue), // Color del ícono
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    enabledBorder: _buildUnderlineBorder(Colors.deepPurple),
                    focusedBorder:
                        _buildUnderlineBorder(Colors.deepPurpleAccent),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),

                // Campo de confirmación de contraseña
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureText,
                  style: TextStyle(color: _getTextColor(context)),
                  decoration: InputDecoration(
                    labelText: 'Confirmar contraseña',
                    labelStyle: TextStyle(color: _getTextColor(context)),
                    prefixIcon: const Icon(Icons.lock_outline,
                        color: Colors.lightGreen), // Color del ícono
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    enabledBorder: _buildUnderlineBorder(Colors.deepPurple),
                    focusedBorder:
                        _buildUnderlineBorder(Colors.deepPurpleAccent),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor confirma tu contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),

                // Botón de Crear Cuenta
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Crear Cuenta',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(height: 40),

                // Texto de enlace para iniciar sesión
                GestureDetector(
                  onTap: () {
                    Get.offNamed('/login');
                  },
                  child: const Text(
                    '¿Ya tienes una cuenta? Inicia sesión',
                    style: TextStyle(color: Colors.deepPurple, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 20),

                // Botones de Google y Facebook
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Lógica para iniciar sesión con Google
                      },
                      child: Image.asset(
                        'lib/assets/google.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 20),
                    GestureDetector(
                      onTap: () {
                        // Lógica para iniciar sesión con Facebook
                      },
                      child: Image.asset(
                        'lib/assets/facebook.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
