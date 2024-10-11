import 'package:anuncios_domicilio/views/main_view.dart';
import 'package:anuncios_domicilio/widgets/custom_navbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text.trim(),
                password: _passwordController.text.trim());
        _navigateToMainView(userCredential.user!.email!);
      } on FirebaseAuthException catch (e) {
        _showErrorSnackBar(e.message ?? 'Error al iniciar sesión');
      }
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        print('El usuario canceló el inicio de sesión con Google');
        return;
      }

      print('Google Sign In exitoso: ${googleUser.email}');

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      print('Autenticación de Google exitosa');

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      print('Credencial de Google creada');

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print('Inicio de sesión en Firebase exitoso');

      _navigateToMainView(userCredential.user!.email!);
    } catch (e) {
      print('Error detallado: $e');
      _showErrorSnackBar('Error inesperado al iniciar sesión con Google: $e');
    }
  }

  Future<void> _signInWithFacebook() async {
    // Implementa aquí la lógica de inicio de sesión con Facebook
    print('Inicio de sesión con Facebook');
  }

  Future<void> _signInWithGitHub() async {
    // Implementa aquí la lógica de inicio de sesión con GitHub
    print('Inicio de sesión con GitHub');
  }

  void _navigateToMainView(String email) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const MainView(),
      ),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
                Container(
                  padding: const EdgeInsets.all(16),
                  child: const Text(
                    'Ingresa tus datos',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // Campo de correo
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo',
                    labelStyle:
                        const TextStyle(fontSize: 16, color: Colors.deepPurple),
                    prefixIcon:
                        const Icon(Icons.email, color: Colors.deepPurple),
                    border: InputBorder.none, // Sin borde
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurple.withOpacity(0.5), width: 2),
                    ),
                    filled: false,
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
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    labelStyle:
                        const TextStyle(fontSize: 16, color: Colors.deepPurple),
                    prefixIcon:
                        const Icon(Icons.lock, color: Colors.deepPurple),
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
                    border: InputBorder.none, // Sin borde
                    focusedBorder: const UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.deepPurple.withOpacity(0.5), width: 2),
                    ),
                    filled: false,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa una contraseña';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 40),
                // Botón para iniciar sesión
                ElevatedButton(
                  onPressed: _login,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.deepPurple,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    'Iniciar sesión',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 24),
                // Botón para continuar con Google
                ElevatedButton.icon(
                  onPressed: _signInWithGoogle,
                  icon: Image.asset('lib/assets/google.png', height: 24),
                  label: const Text('Continuar con Google'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 12),
                // Botón para continuar con Facebook
                ElevatedButton.icon(
                  onPressed: _signInWithFacebook,
                  icon: Image.asset('lib/assets/facebook.png', height: 24),
                  label: const Text('Continuar con Facebook'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 12),
                // Botón para continuar con GitHub
                ElevatedButton.icon(
                  onPressed: _signInWithGitHub,
                  icon: const Icon(Icons.code, color: Colors.white),
                  label: const Text('Continuar con GitHub'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
