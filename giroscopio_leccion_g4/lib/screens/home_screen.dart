import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';
import '../services/communication_service.dart';
import '../utils/gyro_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CommunicationService _communicationService =
      CommunicationService('ws://192.168.137.1:8765');
  final GyroHelper _gyroHelper = GyroHelper();

  @override
  void initState() {
    super.initState();
    // Variable para controlar el tiempo entre comandos
    DateTime lastCommandTime = DateTime.now();

    _gyroHelper.startListening((GyroscopeEvent event) {
      // Disminuir la sensibilidad ajustando el umbral
      double sensitivityThreshold =
          4.0; // Cambia este valor según la sensibilidad deseada
      Duration commandCooldown =
          const Duration(seconds: 1); // Tiempo mínimo entre comandos

      // Verificar si ha pasado suficiente tiempo desde el último comando
      if (DateTime.now().difference(lastCommandTime) >= commandCooldown) {
        if (event.x > sensitivityThreshold) {
          _communicationService.sendCommand('open_browser');
          lastCommandTime =
              DateTime.now(); // Actualizar el tiempo del último comando
        } else if (event.y > sensitivityThreshold) {
          _communicationService.sendCommand('open_word');
          lastCommandTime =
              DateTime.now(); // Actualizar el tiempo del último comando
        } else if (event.z > sensitivityThreshold) {
          _communicationService.sendCommand('play_music');
          lastCommandTime =
              DateTime.now(); // Actualizar el tiempo del último comando
        }
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
        title: const Text('Gyroscope Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Move your device to control the computer'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Enviar el comando 'open_browser' al servidor
                _communicationService.sendCommand('open_browser');
              },
              child: const Text('Open Browser'),
            ),
             const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Enviar el comando 'open_word' al servidor
                _communicationService.sendCommand('open_word');
              },
              child: const Text('Open Word'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Enviar el comando 'play_music' al servidor
                _communicationService.sendCommand('play_music');
              },
              child: const Text('Play Music'),
            ),
          ],
        ),
      ),
    );
  }
}
