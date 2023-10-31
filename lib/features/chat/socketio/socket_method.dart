import 'package:amazon_clone_nodejs/features/chat/socketio/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.internal.socket!;

  Socket get socketClient => _socketClient;

  
}
