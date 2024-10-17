import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  String? uid;
  final TextEditingController _descriptionController = TextEditingController();

  final List<String> titleOptions = [
    'ALBAÑILERÍA',
    'CARPINTERÍA',
    'LAVANDERÍA',
    'JARDINERÍA',
    'COCINA',
    'FONTANERÍA',
    'ELECTRICIDAD',
    'MECÁNICA',
    'NIÑERA',
    'CHOFER',
    'PINTURA',
    'ASEO'
  ];

  final List<String> typeOptions = [
    'Se necesita',
    'Se ofrece',
    'Solo por hoy',
    'A medio tiempo necesito',
    'Con urgencia se requiere',
    'Disponible ahora',
    'De forma temporal',
    'De forma Permanente',
    'De ocasión requiero'
  ];

  String? selectedTitle;
  String? selectedType;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  Future<void> _getUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() => uid = user.uid);
    }
  }

  Future<void> _createAd() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    await FirebaseFirestore.instance.collection('ads').add({
      'uid': user.uid,
      'title': selectedTitle,
      'type': selectedType,
      'description': _descriptionController.text.trim(),
      'createdAt': FieldValue.serverTimestamp(),
    });

    setState(() {
      selectedTitle = null;
      selectedType = null;
      _descriptionController.clear();
    });

    Get.snackbar(
      '¡Éxito!',
      'Anuncio creado con éxito.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.greenAccent.shade100,
      colorText: Colors.black,
      margin: const EdgeInsets.all(20),
      borderRadius: 10,
      duration: const Duration(seconds: 3),
      animationDuration: const Duration(milliseconds: 500),
      boxShadows: [
        BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5))
      ],
    );
  }

  void _showAdForm() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text('Crear Anuncio',
              style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, color: Colors.deepPurple),
              textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDropdown('Selecciona un Servicio', titleOptions,
                    (newValue) {
                  setState(() => selectedTitle = newValue);
                }),
                const SizedBox(height: 15),
                _buildDropdown('Selecciona un Tipo', typeOptions, (newValue) {
                  setState(() => selectedType = newValue);
                }),
                const SizedBox(height: 15),
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide:
                          const BorderSide(color: Colors.deepPurple, width: 2),
                    ),
                  ),
                  maxLines: 3,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancelar',
                  style: GoogleFonts.poppins(color: Colors.grey)),
            ),
            ElevatedButton(
              onPressed: () {
                _createAd();
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
              ),
              child: Text('Crear',
                  style: GoogleFonts.poppins(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDropdown(
      String hint, List<String> options, ValueChanged<String?> onChanged) {
    return DropdownButtonFormField<String>(
      value: hint == 'Selecciona un Servicio' ? selectedTitle : selectedType,
      hint: Text(hint, style: GoogleFonts.poppins()),
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
        ),
      ),
      items: options.map((value) {
        return DropdownMenuItem(
            value: value, child: Text(value, style: GoogleFonts.poppins()));
      }).toList(),
      onChanged: onChanged,
    );
  }

  void _showUserAds() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    final adsSnapshot = await FirebaseFirestore.instance
        .collection('ads')
        .where('uid', isEqualTo: user.uid)
        .get();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Mis Anuncios',
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
          content: SingleChildScrollView(
            child: Column(
              children: adsSnapshot.docs.map((doc) {
                final data = doc.data();
                return ListTile(
                  title: Text(data['title'] ?? 'Sin título',
                      style: GoogleFonts.poppins(fontWeight: FontWeight.bold)),
                  subtitle: Text(data['description'] ?? 'Sin descripción',
                      style: GoogleFonts.poppins()),
                  trailing: Text(data['type'] ?? '',
                      style: GoogleFonts.poppins(fontStyle: FontStyle.italic)),
                );
              }).toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cerrar', style: GoogleFonts.poppins()),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'MI PERFIL',
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: FutureBuilder<DocumentSnapshot>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error al cargar los datos',
                          style: GoogleFonts.poppins(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    if (!snapshot.hasData || !snapshot.data!.exists) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '¡FELICIDADES, SU CUENTA SE HA CREADO!',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () =>
                                Navigator.of(context).pushNamed('/'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.deepPurple,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                            ),
                            child: Text(
                              'Salir y activar',
                              style: GoogleFonts.poppins(
                                  fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ],
                      );
                    }

                    final userData =
                        snapshot.data!.data() as Map<String, dynamic>;
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.deepPurple.shade100,
                          child: const Icon(Icons.person,
                              size: 80, color: Colors.deepPurple),
                        ),
                        const SizedBox(height: 30),
                        Text(
                          'Correo:',
                          style: GoogleFonts.poppins(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          userData['email'] ?? 'Sin correo',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton.icon(
                          icon: const Icon(Icons.edit, color: Colors.white),
                          label: Text('Editar Perfil',
                              style: GoogleFonts.poppins(color: Colors.white)),
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/editar-perfil'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 12),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAdForm,
        backgroundColor: Colors.deepPurple,
        elevation: 8,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.deepPurple,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildBottomBarButton(
                text: 'Mis Anuncios',
                icon: Icons.list_alt,
                onPressed: _showUserAds,
              ),
              _buildBottomBarButton(
                text: 'Cerrar Sesión',
                icon: Icons.exit_to_app,
                onPressed: () {
                  FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushNamed('/');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBarButton(
      {required String text,
      required IconData icon,
      required VoidCallback onPressed}) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon, color: Colors.white),
              Text(text,
                  style:
                      GoogleFonts.poppins(color: Colors.white, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
