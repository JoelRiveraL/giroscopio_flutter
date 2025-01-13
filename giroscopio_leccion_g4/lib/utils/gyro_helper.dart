import 'package:sensors_plus/sensors_plus.dart';

class GyroHelper {
  void startListening(Function onGyroData) {
     gyroscopeEventStream().listen((GyroscopeEvent event) {
      onGyroData(event);
    });
  }
}
  