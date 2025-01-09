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
      CommunicationService('ws://localhost:8765');
  final GyroHelper _gyroHelper = GyroHelper();

  @override
  void initState() {
    super.initState();
    _gyroHelper.startListening((GyroscopeEvent event) {
      // Map gyroscope data to commands
      if (event.x > 1.0) {
        _communicationService.sendCommand('open_browser');
      } else if (event.y > 1.0) {
        _communicationService.sendCommand('open_word');
      } else if (event.z > 1.0) {
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
        child: Text('Move your device to control the computer'),
      ),
    );
  }
}
