import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? uid;

  // Controladores para los campos del formulario
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _photoUrlController = TextEditingController();

  Future<void> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    uid = user.uid; // Guardar UID

    // Cargar los datos del usuario desde Firestore
    final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (doc.exists) {
      final userData = doc.data() as Map<String, dynamic>;
      _nameController.text = userData['name'] ?? '';
      _phoneController.text = userData['phone'] ?? '';
      _photoUrlController.text = userData['photoUrl'] ?? '';
    }
  }

  @override
  void initState() {
    super.initState();
    _getUserData(); // Cargar los datos al inicializar
  }

  void _showEditProfileDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Información'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre',
                  ),
                ),
                TextField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                  ),
                ),
                TextField(
                  controller: _photoUrlController,
                  decoration: const InputDecoration(
                    labelText: 'URL de la Foto',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Lógica para actualizar el perfil
                _updateProfile();
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Actualizar el nombre, teléfono y URL de la foto en Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
        'name': _nameController.text.trim(),
        'phone': _phoneController.text.trim(),
        'photoUrl': _photoUrlController.text.trim(),
      });

      // Notificación de éxito
      Get.snackbar(
        'Éxito',
        'Perfil actualizado correctamente.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.greenAccent,
        colorText: Colors.black,
      );
    }
  }

  void _showProfileDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Detalles de Mi Perfil'),
          content: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text('Error al cargar los datos'));
              } else if (!snapshot.hasData || !snapshot.data!.exists) {
                return const Center(child: Text('No se encontraron datos'));
              }

              final userData = snapshot.data!.data() as Map<String, dynamic>;

              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('UID: $uid'),
                    const SizedBox(height: 10),
                    Text('Correo: ${userData['email'] ?? 'Sin correo'}'),
                    const SizedBox(height: 10),
                    Text('Nombre: ${userData['name'] ?? 'Sin nombre'}'),
                    const SizedBox(height: 10),
                    Text('Teléfono: ${userData['phone'] ?? 'Sin teléfono'}'),
                    const SizedBox(height: 10),
                    Text('URL de la Foto: ${userData['photoUrl'] ?? 'Sin foto'}'),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(uid).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error al cargar los datos'));
            } else if (!snapshot.hasData || !snapshot.data!.exists) {
              return Center(
                child: Column(
                  children: [
                    Text('Felicidades su cuenta ha sido clonada'),
                    Text('Vuelva a ingresar para activar su cuenta'),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/'); // Ir a la página de inicio
                      },
                      child: const Text('Salir'),
                    ),
                  ],
                ),
              );
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>;

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '¡Felicidades, su cuenta ha sido hackeada!',
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Sus datos hackeados son:',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 40),
                  Text('UID: $uid'),
                  const SizedBox(height: 20),
                  Text('Correo: ${userData['email'] ?? 'Sin correo'}'),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: _showEditProfileDialog, // Abre el diálogo para editar información
                    child: const Text('Editar Perfil'),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _showProfileDetails, // Abre el diálogo para mostrar todos los datos
                    child: const Text('Mostrar Mi Perfil'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
