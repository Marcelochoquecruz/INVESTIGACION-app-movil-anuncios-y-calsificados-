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
        content: Text(message),
        backgroundColor: Colors.black,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
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
        ? Colors.black
        : Colors.black; // Cambiado a black
  }

  // Función para obtener el color de las sombras
  BoxShadow _getBoxShadow() {
    return BoxShadow(
      color: Colors.white70,
      spreadRadius: 2,
      blurRadius: 5,
      offset: const Offset(0, 3),
    );
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
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [_getBoxShadow()],
                  ),
                  child: TextFormField(
                    controller: _emailController,
                    style: TextStyle(color: _getTextColor(context)),
                    decoration: InputDecoration(
                      labelText: 'Correo',
                      labelStyle: TextStyle(color: _getTextColor(context)),
                      prefixIcon: Icon(Icons.email, color: Colors.blue),
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
                ),
                const SizedBox(height: 24),

                // Campo de contraseña
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [_getBoxShadow()],
                  ),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: _obscureText,
                    style: TextStyle(color: _getTextColor(context)),
                    decoration: InputDecoration(
                      labelText: 'Contraseña',
                      labelStyle: TextStyle(color: _getTextColor(context)),
                      prefixIcon: Icon(Icons.lock, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.deepPurple,
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
                ),
                const SizedBox(height: 24),

                // Campo de confirmación de contraseña
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [_getBoxShadow()],
                  ),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: _obscureText,
                    style: TextStyle(color: _getTextColor(context)),
                    decoration: InputDecoration(
                      labelText: 'Confirmar contraseña',
                      labelStyle: TextStyle(color: _getTextColor(context)),
                      prefixIcon: Icon(Icons.lock_outline, color: Colors.blue),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.deepPurple,
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
                ),
                const SizedBox(height: 40),

                // Botón de Crear Cuenta
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [_getBoxShadow()],
                  ),
                  child: ElevatedButton(
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
                ),
                const SizedBox(height: 40),

                // Texto de enlace para iniciar sesión
                GestureDetector(
                  onTap: () {
                    Get.offNamed('/login');
                  },
                  child: Text(
                    '¿Ya tienes una cuenta? Inicia sesión',
                    style:
                        TextStyle(color: Colors.deepPurple, fontSize: 16),
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
