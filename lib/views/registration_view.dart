import 'package:flutter/cupertino.dart';
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

  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        _showErrorSnackBar('Las contraseñas no coinciden');
        return;
      }

      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );
        _showSuccessSnackBar('Cuenta creada exitosamente');
        Get.offAllNamed('/main');
      } on FirebaseAuthException catch (e) {
        _showErrorSnackBar(e.message ?? 'Error al registrar la cuenta');
      }
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 16)),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: const TextStyle(fontSize: 16)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: const CustomNavBar(title: 'Registro'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTitle(),
              const SizedBox(height: 10),
              _buildEmailField(),
              const SizedBox(height: 20),
              _buildPasswordField(),
              const SizedBox(height: 20),
              _buildConfirmPasswordField(),
              const SizedBox(height: 30),
              _buildRegisterButton(),
              const SizedBox(height: 15),
              _buildLoginOption(),
              const SizedBox(height: 30),
              _buildSocialButtonsRow(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Ingresa tus datos',
      style: TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.onSurface,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: _inputDecoration(
        label: 'Correo',
        icon: CupertinoIcons.person_circle,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa un correo válido';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscureText,
      decoration: _inputDecoration(
        label: 'Contraseña',
        icon: CupertinoIcons.lock,
        suffixIcon: _buildVisibilityIcon(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa una contraseña';
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      controller: _confirmPasswordController,
      obscureText: _obscureText,
      decoration: _inputDecoration(
        label: 'Confirmar Contraseña',
        icon: CupertinoIcons.lock_shield,
        suffixIcon: _buildVisibilityIcon(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor confirma tu contraseña';
        }
        return null;
      },
    );
  }

  Widget _buildVisibilityIcon() {
    return IconButton(
      icon: Icon(
        _obscureText ? CupertinoIcons.eye : CupertinoIcons.eye_slash,
        color: Theme.of(context).iconTheme.color,
      ),
      onPressed: () {
        setState(() {
          _obscureText = !_obscureText;
        });
      },
    );
  }

  InputDecoration _inputDecoration({
    required String label,
    required IconData icon,
    Widget? suffixIcon,
  }) {
    final theme = Theme.of(context);
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: theme.iconTheme.color, size: 28),
      suffixIcon: suffixIcon,
      filled: true,
      fillColor: theme.colorScheme.surfaceContainerHighest,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton.icon(
      onPressed: _register,
      icon: const Icon(Icons.face_rounded, size: 24), // Cambiar Icon a Icons
      label: const Text('Crear Cuenta', style: TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        backgroundColor: CupertinoColors.black,
        foregroundColor: CupertinoColors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8, // Sombra para darle estilo iOS
      ),
    );
  }

  Widget _buildSocialButtonsRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialButton('lib/assets/google.png', 'Google'),
        const SizedBox(width: 10),
        _buildSocialButton('lib/assets/facebook.png', 'Facebook'),
      ],
    );
  }

   Widget _buildSocialButton(String asset, String label) {
    return ElevatedButton.icon(
      onPressed: () {}, // Implementar autenticación social
      icon: Image.asset(asset, height: 24),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(20),
        elevation: 5,
      ),
    );
  }

  Widget _buildLoginOption() {
    return TextButton(
      onPressed: () {
        Get.offNamed('/login'); // Navegar a la pantalla de inicio de sesión
      },
      child: const Text('¿Ya tienes una cuenta? Inicia sesión'),
    );
  }
}
