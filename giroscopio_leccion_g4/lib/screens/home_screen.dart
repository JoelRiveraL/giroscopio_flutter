import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../services/communication_service.dart';
import '../utils/gyro_helper.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CommunicationService _communicationService =
      CommunicationService('ws://192.168.137.54:8765');
  final GyroHelper _gyroHelper = GyroHelper();

  @override
  void initState() {
    super.initState();
    _gyroHelper.startListening((GyroscopeEvent event) {
      // Disminuir la sensibilidad ajustando el umbral
      double sensitivityThreshold = 0.5; // Ajusta este valor para cambiar la sensibilidad

      // Mapear los datos del giroscopio a comandos
      if (event.x > sensitivityThreshold) {
        _communicationService.sendCommand('open_browser');
      } else if (event.y > sensitivityThreshold) {
        _communicationService.sendCommand('open_word');
      } else if (event.z > sensitivityThreshold) {
        _communicationService.sendCommand('play_music');
      }
    });
  }

  @override
  void dispose() {
    _communicationService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gyroscope Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Move your device to control the computer'),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Enviar el comando 'open_browser' al servidor
                _communicationService.sendCommand('open_browser');
              },
              child: Text('Open Browser'),
            ),
          ],
        ),
      ),
    );
  }
}
