import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class RadioView extends StatefulWidget {
  const RadioView({super.key});

  @override
  _RadioViewState createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView>
    with SingleTickerProviderStateMixin {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  double _volume = 1.0;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _togglePlay() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
      _animationController.stop();
    } else {
      await _audioPlayer
          .play(UrlSource('https://azura2.bitstreaming.net:8000/radio128.aac'));
      _animationController.repeat();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _stopPlayback() async {
    await _audioPlayer.stop();
    _animationController.stop();
    setState(() {
      _isPlaying = false;
    });
  }

  void _setVolume(double volume) {
    setState(() {
      _volume = volume;
    });
    _audioPlayer.setVolume(_volume);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Color(0xFF1C1C1E), // Color de fondo oscuro estilo iOS
        ),
        child: Center(
          child: Container(
            width: 350, // Establece un ancho fijo para el contenedor
            padding: const EdgeInsets.all(20), // Aumentar el padding
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue[300]!,
                  Colors.blue[700]!
                ], // Colores degradados
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26, // Sombra
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Programa Cambalache',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Text(
                  'Horario: Lunes a Viernes, 07:00 - 12:00',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                const Text(
                  'Del medio día, no te lo pierdas!!!',
                  style: TextStyle(fontSize: 14, color: Colors.white),
                ),
                const SizedBox(height: 8),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _animationController.value * 2 * 3.14159,
                      child: child,
                    );
                  },
                  child: const Icon(
                    Icons.radio,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _togglePlay,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        elevation: 8,
                      ),
                      child: Icon(
                        _isPlaying
                            ? FontAwesomeIcons.pause
                            : FontAwesomeIcons.play,
                        size: 26,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _stopPlayback,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                        elevation: 8,
                      ),
                      child: const Icon(
                        FontAwesomeIcons.stop,
                        size: 26,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Text(
                  'Volumen: ${(_volume * 100).toInt()}%',
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(
                  width: 250, // Ancho reducido del slider
                  child: Slider(
                    value: _volume,
                    onChanged: _setVolume,
                    min: 0,
                    max: 1,
                    activeColor: Colors.black,
                    inactiveColor: Colors.grey[400],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Hora y Fecha: ${DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now())}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Text(
                  'Potosí, Bolivia',
                  style: TextStyle(
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                      color: Colors.white70),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
