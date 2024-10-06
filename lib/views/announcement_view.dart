// lib/views/announcement_view.dart
import 'package:flutter/material.dart';
class AnnouncementView extends StatelessWidget {
  const AnnouncementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Anunciar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(labelText: 'Título del Anuncio'),
            ),
            const TextField(
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para publicar el anuncio
              },
              child: const Text('Publicar Anuncio'),
            ),
          ],
        ),
      ),
    );
  }
}
