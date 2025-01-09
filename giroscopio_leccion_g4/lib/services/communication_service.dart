import 'package:web_socket_channel/web_socket_channel.dart';

class CommunicationService {
  final WebSocketChannel channel;

  CommunicationService(String url)
      : channel = WebSocketChannel.connect(Uri.parse(url));

  void sendCommand(String command) {
    channel.sink.add(command);
  }

  void dispose() {
    channel.sink.close();
  }
}
