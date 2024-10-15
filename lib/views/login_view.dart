import 'package:anuncios_domicilio/controllers/auth_controller.dart';
import 'package:anuncios_domicilio/views/main_view.dart';
import 'package:anuncios_domicilio/widgets/custom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Firestore

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomNavBar(title: 'Regresar'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTitle(),
                const SizedBox(height: 10),
                _buildEmailField(),
                const SizedBox(height: 24),
                _buildPasswordField(),
                const SizedBox(height: 40),
                _buildLoginButton(),
                const SizedBox(height: 24),
                _buildGoogleButton(),
                const SizedBox(height: 12),
                _buildFacebookButton(),
                const SizedBox(height: 12),
                _buildForgotPasswordButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return const Text(
      'Ingresa tus datos',
      style: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.bold,
        color: Colors.deepPurple,
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      decoration: const InputDecoration(
        labelText: 'Correo',
        prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
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
      decoration: InputDecoration(
        labelText: 'Contraseña',
        prefixIcon: const Icon(Icons.lock, color: Colors.deepPurple),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.deepPurple,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingresa una contraseña';
        }
        return null;
      },
    );
  }

  Widget _buildLoginButton() {
    return TextButton(
      onPressed: _login,
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
        minimumSize: const Size(double.infinity, 50),
      ),
      child: const Text('Iniciar sesión', style: TextStyle(fontSize: 20)),
    );
  }

  Widget _buildGoogleButton() {
    return ElevatedButton.icon(
      onPressed: _signInWithGoogle,
      icon: Image.asset('lib/assets/google.png', height: 24),
      label: const Text('Continuar con Google'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildFacebookButton() {
    return ElevatedButton.icon(
      onPressed: _signInWithFacebook,
      icon: Image.asset('lib/assets/facebook.png', height: 24),
      label: const Text('Continuar con Facebook'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return TextButton(
      onPressed: () {
        Get.find<AuthController>().openForgotPasswordDialog();
      },
      child: const Text(
        'Olvidaste tu contraseña?',
        style: TextStyle(
          fontSize: 16,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());

        await _saveUserToFirestore(userCredential.user!.uid);

        Get.snackbar(
          'Éxito',
          'Inicio de sesión exitoso para ${_emailController.text}!',
        );

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainView()),
        );
      } on FirebaseAuthException catch (e) {
        _showErrorSnackBar(e.message ?? 'Error al iniciar sesión');
      }
    }
  }

  Future<void> _saveUserToFirestore(String uid) async {
    await FirebaseFirestore.instance.collection('users').doc(uid).set({
      'userId': uid,
      'email': _emailController.text,
      'lastLogin': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _signInWithGoogle() async {
    // Implementar autenticación con Google
  }

  Future<void> _signInWithFacebook() async {
    // Implementar autenticación con Facebook
  }
}
