// lib/views/chat_view.dart
import 'package:flutter/material.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 20, // Cambiar según el número de mensajes
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Mensaje del trabajador $index'),
                  subtitle: const Text('Contenido del mensaje'),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Lógica para enviar mensaje
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
