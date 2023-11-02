import 'package:amazon_clone_nodejs/features/chat/socketio/socket_client.dart';
import 'package:amazon_clone_nodejs/models/user.dart';
import 'package:socket_io_client/socket_io_client.dart';

class SocketMethods {
  final _socketClient = SocketClient.internal.socket!;

  Socket get socketClient => _socketClient;

  // List<Message> listmess = [];

  // create room chat client
  void createRoomChat(User user, String message, String id) {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    if (message.isNotEmpty) {
      _socketClient.emit(
        'createRoomChat',
        {'user': user, 'message': message, "time": time, "id": id},
      );
    }
  }
}
