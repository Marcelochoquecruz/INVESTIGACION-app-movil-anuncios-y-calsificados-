import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class RadioView extends StatefulWidget {
  const RadioView({Key? key}) : super(key: key);

  @override
  _RadioViewState createState() => _RadioViewState();
}

class _RadioViewState extends State<RadioView> with SingleTickerProviderStateMixin {
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
      await _audioPlayer.play(UrlSource('https://azura2.bitstreaming.net:8000/radio128.aac'));
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
      appBar: AppBar(
        title: const Text('Radio Collasuyo', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepPurple[800],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Aquí iría la lógica para regresar
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple[700]!, Colors.deepPurple[300]!],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Programa Cambalache',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              const Text(
                'Potosí, Bolivia',
                style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white70),
              ),
              SizedBox(height: 20),
              Text(
                'Horario: Lunes a Viernes, 07:00 - 12:00 \n Del medio dia, no te lo pierdas!!!',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              SizedBox(height: 40),
              AnimatedBuilder(
                animation: _animationController,
                builder: (_, child) {
                  return Transform.rotate(
                    angle: _animationController.value * 2 * 3.14159,
                    child: child,
                  );
                },
                child: Icon(
                  Icons.radio,
                  size: 120,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _togglePlay,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      elevation: 10,
                    ),
                    child: Icon(
                      _isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play,
                      size: 30,
                      color: Colors.deepPurple[800],
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: _stopPlayback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      shape: CircleBorder(),
                      padding: EdgeInsets.all(20),
                      elevation: 10,
                    ),
                    child: Icon(
                      FontAwesomeIcons.stop,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Text(
                'Volumen: ${(_volume * 100).toInt()}%',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Slider(
                value: _volume,
                onChanged: _setVolume,
                min: 0,
                max: 1,
                activeColor: Colors.black,
                inactiveColor: Colors.grey[400],
              ),
              SizedBox(height: 20),
              Text(
                'Hora y Fecha: ${DateFormat('HH:mm dd/MM/yyyy').format(DateTime.now())}',
                style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}