import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  IO.Socket? socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = IO.io(
        'http://192.168.1.6:4000',
        OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .enableAutoConnect()
            .build() // optional
        );

    socket!.connect();
  }

  static SocketClient get internal {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
