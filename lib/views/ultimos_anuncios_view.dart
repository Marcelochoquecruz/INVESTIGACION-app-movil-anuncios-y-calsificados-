import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Importar aquí
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class UltimosAnunciosView extends StatelessWidget {
  const UltimosAnunciosView({super.key});

  void _launchWhatsApp(String number, String message) async {
    final url = "whatsapp://send?phone=$number&text=${Uri.encodeFull(message)}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Últimos Anuncios'),
      ),
      body: ListView.builder(
        itemCount: 10, // Cambiar según el número de anuncios
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            child: ListTile(
              title: Text('Título del anuncio $index'),
              subtitle: Text('Descripción breve del anuncio $index'),
              trailing: IconButton(
                icon: const Icon(FontAwesomeIcons.whatsapp),
                onPressed: () {
                  _launchWhatsApp('+123456789', 'Hola, tengo una pregunta sobre el anuncio $index');
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
