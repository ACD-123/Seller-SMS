import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel _channel;
  final String baseUrl;

  WebSocketService(this.baseUrl);

  void connect({required String channel, required Function(String) onMessage, Function(dynamic)? onError, Function()? onDone}) {
    _channel = WebSocketChannel.connect(Uri.parse(baseUrl));


    _channel.stream.listen(
      (message) {
        onMessage(message);
      },
      onError: (error) {
        if (onError != null) {
          onError(error);
        } else {
          print('WebSocket Error: $error');
        }
      },
      onDone: () {
        if (onDone != null) {
          onDone();
        } else {
          print('WebSocket connection closed');
        }
      },
    );

    _subscribeToChannel(channel);
  }

  void _subscribeToChannel(String channel) {
    final subscriptionMessage = jsonEncode({
      "event": "pusher:subscribe",
      "data": {
        "auth": "",
        "channel": channel,
      }
    });
    _channel.sink.add(subscriptionMessage);
  }

  void closeConnection() {
    _channel.sink.close();
  }
}
